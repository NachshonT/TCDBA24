DECLARE curIndexes CURSOR READ_ONLY FORWARD_ONLY
FOR 
	SELECT sysIndexes.index_id AS IndexID,
		sysIndexes.[name] AS IndexName,
		sysTables.[name] AS TableName,
		sysSchemas.[name] AS SchemaName,
		IndexesStats.avg_fragmentation_in_percent AS FragmentationPercent
	FROM
		sys.indexes as sysIndexes
		INNER JOIN sys.tables AS sysTables
			ON sysIndexes.object_id = sysTables.object_id
		INNER JOIN sys.schemas AS sysSchemas
			ON sysTables.schema_id = sysSchemas.schema_id
		INNER JOIN sys.dm_db_index_physical_stats(DB_ID(), null, null, null, 'LIMITED') AS IndexesStats
			ON IndexesStats.index_id = sysIndexes.index_id
				AND IndexesStats.object_id = sysIndexes.object_id
	WHERE IndexesStats.avg_fragmentation_in_percent > 0.1
		AND sysIndexes.index_id <> 0 -- filter out the 'heap' index

DECLARE @IndexID int,
	@IndexName sysname,
	@TableName sysname,
	@SchemaName sysname,
	@FragmentationPercent float

OPEN curIndexes  

FETCH NEXT FROM curIndexes 
	INTO @IndexID,
		@IndexName,
		@TableName,
		@SchemaName,
		@FragmentationPercent 

WHILE @@FETCH_STATUS = 0
BEGIN
	IF (@FragmentationPercent > 0.3)
		PRINT 'ALTER INDEX [' + @IndexName + '] ON [' + @SchemaName + '].[' + @TableName + '] REBUILD'
	ELSE
		PRINT 'ALTER INDEX [' + @IndexName + '] ON [' + @SchemaName + '].[' + @TableName + '] REORGANIZE'

	FETCH NEXT FROM curIndexes
	INTO @IndexID,
			@IndexName,
			@TableName,
			@SchemaName,
			@FragmentationPercent 
END

CLOSE curIndexes
DEALLOCATE curIndexes
