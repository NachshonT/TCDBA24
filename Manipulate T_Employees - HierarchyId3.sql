
USE SampleDB
GO

SELECT * FROM T_Employees

-- GetReparentedValue... Wanda now reports to Jill and no longer to Amy
DECLARE @HierarchyId_Wanda HIERARCHYID = (SELECT NodeId FROM T_Employees WHERE EmployeeName = 'Wanda') -- Move Wanda
DECLARE @HierarchyId_Amy HIERARCHYID = @HierarchyId_Wanda.GetAncestor(1)                       --  from Amy
DECLARE @HierarchyId_Jill HIERARCHYID = (SELECT NodeId FROM T_Employees WHERE EmployeeName = 'Jill') --  to Jill

UPDATE T_Employees
SET   NodeId = NodeId.GetReparentedValue(@HierarchyId_Amy, @HierarchyId_Jill)
WHERE NodeId = @HierarchyId_Wanda

SELECT * FROM T_Employees

-- Move the entire subtree beneath Amy to a new location beneath Kevin
DECLARE @HierarchyId_Kevin HIERARCHYID = (SELECT NodeId FROM T_Employees WHERE EmployeeName = 'Kevin') --  beneath Kevin

UPDATE T_Employees
SET   NodeId = NodeId.GetReparentedValue(@HierarchyId_Amy, @HierarchyId_Kevin)
WHERE NodeId.IsDescendantOf(@HierarchyId_Amy) = 1 AND NodeId <> @HierarchyId_Amy -- Excludes Amy herself

SELECT * FROM T_Employees

GO