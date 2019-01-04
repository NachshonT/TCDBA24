SELECT sysSchemas.[name] AS SchemaName,
	sysTables.[name] AS TableName,
	sysIndexes.[name] AS IndexName,
	sysIndexes.[type_desc] AS IndexType,
	sysIndexes.is_unique AS IsUnique,
	sysIndexes.fill_factor AS [FillFactor],
	sysIndexesUsage.user_lookups + sysIndexesUsage.user_scans + sysIndexesUsage.user_seeks AS [CountOfUserUsage]
FROM sys.indexes AS sysIndexes
	INNER JOIN sys.tables AS sysTables
		ON sysIndexes.object_id = sysTables.object_id
	INNER JOIN sys.schemas AS sysSchemas
		ON sysTables.schema_id = sysSchemas.schema_id
	INNER JOIN sys.dm_db_index_usage_stats AS sysIndexesUsage
		ON sysIndexes.index_id = sysIndexesUsage.index_id