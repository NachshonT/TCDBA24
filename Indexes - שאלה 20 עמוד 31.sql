USE [eDate]
GO

/****** Object:  Table [dbo].[checkfillfactor]    Script Date: 30/12/2018 22:18:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[checkfillfactor](
	[CheckFillFactor] [varchar](100) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


declare @i int = 1000

while (@i > 0)
	begin
		insert into [dbo].[checkfillfactor]([Value])
		values ('1234567890')
		set @i -= 1
	end
go

CREATE NONCLUSTERED INDEX [80PercentFillFactor] ON [dbo].[checkfillfactor]
(
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80)

GO
CREATE NONCLUSTERED INDEX [10PercentFillFactor] ON [dbo].[checkfillfactor]
(
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 10)

GO


select dbPartitionStats.*
from sys.indexes as sysIndexes
	inner join sys.dm_db_partition_stats as dbPartitionStats
		on sysIndexes.index_id = dbPartitionStats.index_id and
			sysIndexes.object_id = dbPartitionStats.object_id
where sysIndexes.name = '80PercentFillFactor' or
		sysIndexes.name = '10PercentFillFactor'