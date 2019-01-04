select count(innerSelect.IndexID) as CountOfIndexes,
	sum(innerSelect.FilteredIndexes) as CountOfFilteredInedexes,
	sum(innerSelect.ClusteredIndexes) as CountOfClusteredIndexes,
	sum(innerSelect.NonClusteredIndexes) as CountOfNonClusteredIndexes,
	sum(innerSelect.UniqueIndexes) as CountOfUniqueIndexes,
	sum(innerSelect.NonUniqueIndexes) as CountOfNonUniqueIndexes,
	sum(innerSelect.UniqueConstraintIndexes) as CountOfUniqueConstraintIndexes,
	sum(innerSelect.NonUniqueConstraintIndexes) as CountOfNonUniqueConstraintIndexes

	from
	(
		select 
			index_id as IndexID,
			[name] as IndexName,
			case
				when has_filter = 1 then 1
				else 0
			end as FilteredIndexes,
			case
				when [type] = 1 then 1
				else 0
			end as ClusteredIndexes,
			case
				when [type] = 1 then 0
				else 1
			end as NonClusteredIndexes,
			case
				when is_unique = 1 then 1
				else 0
			end as UniqueIndexes,
			case
				when is_unique = 1 then 0
				else 1
			end as NonUniqueIndexes,
			case
				when is_unique_constraint = 1 then 1
				else 0
			end as UniqueConstraintIndexes,
			case
				when is_unique_constraint = 1 then 0
				else 1
			end as NonUniqueConstraintIndexes
		from sys.indexes
		where [type] <> 0
		) as innerSelect
