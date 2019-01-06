select sysStats.*
from sys.stats as sysStats
	inner join sys.indexes as sysIndexes
		on sysStats.object_id = sysIndexes.object_id and
			sysStats.stats_id = sysIndexes.index_id
	inner join sys.index_columns as sysIndexColumns
		on sysIndexes.object_id = sysIndexColumns.object_id and
			sysIndexes.index_id = sysIndexColumns.index_id
	inner join sys.columns as sysColumns
		on sysIndexColumns.column_id = sysColumns.column_id and
			sysIndexColumns.object_id = sysColumns.object_id --and
			--sysIndexColumns.index_id = sysIndexes.index_id and
			--sysIndexColumns.object_id = sysIndexes.object_id
where sysColumns.name = 'CountryId'
