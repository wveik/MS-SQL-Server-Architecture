SELECT
    P.spid,
    RIGHT(CONVERT(VARCHAR, DATEADD(MS, DATEDIFF(MS, P.last_batch, GETDATE()), '1900-01-01'), 121), 12) AS [BATCH_DURATION],
    P.program_name,
    P.hostname AS HOST_NAME,
    P.loginame AS LOGIN_NAME
FROM master.dbo.sysprocesses AS P
WHERE 
    P.spid > 50 AND
    P.status NOT IN ('background', 'sleeping') AND
    P.cmd NOT IN 
    (
        'AWAITING COMMAND',
        'MIRROR HANDLER',
        'LAZY WRITER',
        'CHECKPOINT SLEEP',
        'RA MANAGER'
    )
ORDER BY 2


SELECT
	tl.request_session_id,
	wt.blocking_session_id,
    db.name AS DB_NAME,
    tl.request_session_id AS REQUESTING_SESSION,
    wt.blocking_session_id AS BLOCKING_SESSION,
    OBJECT_NAME(p.OBJECT_ID) AS BLOCKED_OBJECT,
    tl.resource_type AS RESOURCE_TYPE,
    h1.TEXT AS REQUEST_QUERY,
    h2.TEXT AS BLOCKING_QUERY,
    tl.request_mode
FROM sys.dm_tran_locks AS tl
INNER JOIN sys.databases db ON db.database_id = tl.resource_database_id
INNER JOIN sys.dm_os_waiting_tasks AS wt ON tl.lock_owner_address =     wt.resource_address
INNER JOIN sys.partitions AS p ON p.hobt_id = tl.resource_associated_entity_id
INNER JOIN sys.dm_exec_connections ec1 ON ec1.session_id =     tl.request_session_id
INNER JOIN sys.dm_exec_connections ec2 ON ec2.session_id =     wt.blocking_session_id
CROSS APPLY sys.dm_exec_sql_text(ec1.most_recent_sql_handle) AS h1
CROSS APPLY sys.dm_exec_sql_text(ec2.most_recent_sql_handle) AS h2


-- kill 66