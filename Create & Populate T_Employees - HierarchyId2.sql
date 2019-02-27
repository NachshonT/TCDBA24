/*
	Sample Hierarchy 
	================

                                  Dave
                                    |
                   +----------------+---------------+
                   |                |               |
									Amy							John						Jill
                   |                |               |
              +----+----+           |               |
              |         |           |               |
						Cheryl		Wanda				Mary			      Kevin
              |
         +----+----+
         |         |
			Richard			Jeff
*/

USE SampleDB
GO

DROP TABLE [dbo].[T_Employees]
GO

CREATE TABLE [dbo].[T_Employees]
(
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [nchar](20) NOT NULL,
	[Title] [nchar](120) NULL,
	[NodeID] [hierarchyid] NULL,
	[NodeID2String]  AS ([NodeID].[ToString]()),
	[NodeLevel]  AS ([NodeID].[GetLevel]()),
	[DisplayPath]  AS ([dbo].[F_GetEmployeeDisplayPath]([NodeID]))

	CONSTRAINT [PK_T_Employees_EmployeeID] PRIMARY KEY CLUSTERED 
	(
		[EmployeeID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- Create a Non-Clustered Index on the NodeID column
CREATE UNIQUE NONCLUSTERED INDEX [UIX_T_Employees_NodeID] ON [dbo].[T_Employees]
(
	[NodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description',
																@value=N'This Index Enfores Uniqueness on the NodeID column',
																@level0type=N'SCHEMA',
																@level0name=N'dbo',
																@level1type=N'TABLE',
																@level1name=N'T_Employees',
																@level2type=N'INDEX',
																@level2name=N'UIX_T_Employees_NodeID'
GO

-- Insert root node - Dave (Level 0)
INSERT INTO T_Employees (EmployeeName, Title, NodeID) VALUES ('Dave', 'CEO', HIERARCHYID::GetRoot());
DECLARE @HierarchyId_Dave HIERARCHYID = (SELECT NodeID FROM T_Employees WHERE EmployeeName = 'Dave' AND Title = 'CEO')
--GO

-- Insert Amy as the 1st Employee beneath Dave (Level 1)
DECLARE @HierarcyId_Amy HIERARCHYID = @HierarchyId_Dave.GetDescendant(NULL, NULL)
INSERT INTO T_Employees(EmployeeName, Title, NodeID) VALUES('Amy', 'Cheif Marketing Officer', @HierarcyId_Amy)

-- Insert John as the 2nd Employee (after Ami) beneath Dave (Level 1)
DECLARE @HierarcyId_John HIERARCHYID = @HierarchyId_Dave.GetDescendant(@HierarcyId_Amy, NULL)
INSERT INTO T_Employees(EmployeeName, Title, NodeID) VALUES('John', 'Cheif Technologies Officer', @HierarcyId_John)

-- Insert Jill as the third Employee (after John) beneath Dave (Level 1)
DECLARE @HierarcyId_Jill HIERARCHYID = @HierarchyId_Dave.GetDescendant(@HierarcyId_John, NULL)
INSERT INTO T_Employees(EmployeeName, Title, NodeID) VALUES('Jill', 'Cheif Financial Officer', @HierarcyId_Jill)

-- Insert Cheryl as the 1st Employee beneath Amy (Level 2)
DECLARE @HierarcyId_Cheryl HIERARCHYID = @HierarcyId_Amy .GetDescendant(NULL, NULL)
INSERT INTO T_Employees(EmployeeName, Title, NodeID) VALUES('Cheryl', 'Marketing Specialist', @HierarcyId_Cheryl )

-- Insert Wanda as the 2nd Employee (after Cheryl) beneath Amy (Level 2)
DECLARE @HierarcyId_Wanda HIERARCHYID = @HierarcyId_Amy .GetDescendant(@HierarcyId_Cheryl, NULL)
INSERT INTO T_Employees(EmployeeName, Title, NodeID) VALUES('Wanda', 'Marketing Operator', @HierarcyId_Wanda )

-- Insert Wanda as the 1st Employee beneath John (Level 2)
DECLARE @HierarcyId_Mari HIERARCHYID = @HierarcyId_John.GetDescendant(NULL, NULL)
INSERT INTO T_Employees(EmployeeName, Title, NodeID) VALUES('Mari', 'R&D Specialist', @HierarcyId_Mari )

-- Insert Kevin as the 1st Employee beneath Jill (Level 2)
DECLARE @HierarcyId_Kevin HIERARCHYID = @HierarcyId_Jill.GetDescendant(NULL, NULL)
INSERT INTO T_Employees(EmployeeName, Title, NodeID) VALUES('Kevin', 'Head of Accounting', @HierarcyId_Kevin)

-- Insert Richard as the 1st Employee beneath Cheryl (Level 3)
DECLARE @HierarcyId_Richard HIERARCHYID = @HierarcyId_Cheryl.GetDescendant(NULL, NULL)
INSERT INTO T_Employees(EmployeeName, Title, NodeID) VALUES('Richard', 'Marketing Coordinator', @HierarcyId_Richard)

-- Insert Jeff as the 2nd Employee (after Richard) beneath Cheryl (Level 3)
DECLARE @HierarcyId_Jeff HIERARCHYID = @HierarcyId_Cheryl.GetDescendant(@HierarcyId_Richard, NULL)
INSERT INTO T_Employees(EmployeeName, Title, NodeID) VALUES('Jeff', 'Advertising Specialist', @HierarcyId_Jeff)


SELECT * FROM T_Employees ORDER BY	DisplayPath
GO
