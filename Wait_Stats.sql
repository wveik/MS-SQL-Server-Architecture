SELECT	*, 
				Wait_time_ms - signal_wait_time_ms AS Resource_wait_time_ms
FROM		sys.dm_os_wait_stats
ORDER BY	Resource_wait_time_ms DESC