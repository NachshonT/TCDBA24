USE [SampleDB]
GO

/****** Object:  UserDefinedFunction [dbo].[F_GetEmployeePosition]    Script Date: 27/02/2019 22:15:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[F_GetEmployeeDisplayPath](@EmployeeNodeID HIERARCHYID)
	RETURNS VARCHAR(MAX) 
AS 
	BEGIN
			-- Start with the specified Employee
		DECLARE @EmployeeNodeLevel SMALLINT
		DECLARE @DisplayPath VARCHAR(MAX)

		SELECT @EmployeeNodeLevel = NodeLevel, @DisplayPath = EmployeeName FROM dbo.T_Employees WHERE NodeID = @EmployeeNodeID
 
		DECLARE @iLevelsUp SMALLINT = 0
		DECLARE @ManagerNodeID HIERARCHYID
		DECLARE @ManagerName VARCHAR(20)

		-- Loop through all its ancestors
		WHILE @EmployeeNodeLevel - @iLevelsUp > 0
			BEGIN
				SET @iLevelsUp += 1

				-- Get manager's NodeID
				SELECT @ManagerNodeID = @EmployeeNodeID.GetAncestor(@iLevelsUp)

				-- Get Manager's Name
				SELECT @ManagerName = EmployeeName FROM T_Employees WHERE NodeID = @ManagerNodeID

				-- Prepend to display path
				SET @DisplayPath = @ManagerName + ' > ' + @DisplayPath
			END
 
		RETURN(@DisplayPath)
	END 

GO


