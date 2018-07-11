select object_name(objectid),
    BlockTime = total_elapsed_time - total_worker_time,
    execution_count,
    total_logical_reads
from sys.dm_exec_query_stats as qs
cross apply sys.dm_exec_sql_text(qs.sql_handle)
where OBJECT_NAME(objectid) is not null
order by total_elapsed_time - total_worker_time desc;
