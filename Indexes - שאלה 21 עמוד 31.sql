SELECT avg_fragmentation_in_percent,
	fragment_count,
	avg_fragment_size_in_pages,
	page_count,
FROM sys.dm_db_index_physical_stats(db_id('eDAte'), OBJECT_ID('Members'), NULL, NULL, NULL)