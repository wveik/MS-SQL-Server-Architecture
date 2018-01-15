SELECT	*
FROM		sys.dm_exec_connections C RIGHT JOIN sys.dm_exec_sessions S
				ON C.Session_ID = S.session_id
				INNER JOIN sys.dm_exec_requests R
				ON	S.Session_ID = R.session_id
				INNER JOIN sys.dm_os_tasks T
				ON	R.session_id = T.session_id
				INNER JOIN sys.dm_os_workers W
				ON	T.task_address = W.task_address
				INNER JOIN sys.dm_os_threads Th
				ON	W.worker_address = Th.worker_address
WHERE	C.Session_ID IN (67, 78)
ORDER BY	C.Session_ID
