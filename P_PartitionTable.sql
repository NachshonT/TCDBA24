USE SampleDB
GO

CREATE PROCEDURE P_PartitionTable
(
	@TableName SYSNAME = 'PartitionedTable',
	@ColumnName SYSNAME = 'PartitioningColumn',
	@SchemeName SYSNAME = 'PartitioningScheme',
	@FunctionName SYSNAME = 'PartitioningFunction'
)
AS
BEGIN
	ALTER DATABASE [SampleDB] ADD FILEGROUP [FG_Partition1]
	ALTER DATABASE [SampleDB] ADD FILE ( NAME = N'SampleDB_Partition1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.TAMIR1\MSSQL\Data\UserDBs\SampleDB_Partition1.ndf' , SIZE = 5120KB , FILEGROWTH = 1024KB ) TO FILEGROUP [FG_Partition1]

	ALTER DATABASE [SampleDB] ADD FILEGROUP [FG_Partition2]
	ALTER DATABASE [SampleDB] ADD FILE ( NAME = N'SampleDB_Partition2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.TAMIR1\MSSQL\Data\UserDBs\SampleDB_Partition2.ndf' , SIZE = 5120KB , FILEGROWTH = 1024KB ) TO FILEGROUP [FG_Partition2]

	ALTER DATABASE [SampleDB] ADD FILEGROUP [FG_Partition3]
	ALTER DATABASE [SampleDB] ADD FILE ( NAME = N'SampleDB_Partition3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.TAMIR1\MSSQL\Data\UserDBs\SampleDB_Partition3.ndf' , SIZE = 5120KB , FILEGROWTH = 1024KB ) TO FILEGROUP [FG_Partition3]

	-- Creates a partition function called @FunctionName that will partition a table into 3 partitions
	EXECUTE ('CREATE PARTITION FUNCTION ' + @FunctionName + '(INT) AS RANGE LEFT FOR VALUES (100, 1000);')

	-- Creates a partition scheme called @SchemeName that applies @FunctionName to the 3 filegroups created above  
	EXECUTE ('CREATE PARTITION SCHEME ' + @SchemeName + ' AS PARTITION PartitionFunction TO (FG_Partition1, FG_Partition2, FG_Partition3);')
	
	-- Creates a partitioned table called PartitionTable that uses @SchemeName to partition col1  
	EXECUTE ('CREATE TABLE ' + @TableName + ' (' + @ColumnName +'  INT PRIMARY KEY, col2 CHAR(10)) ON ' + @SchemeName + '(' + @ColumnName + ');')
END
