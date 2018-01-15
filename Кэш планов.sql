SELECT	*
FROM		sys.dm_exec_cached_plans CP
				CROSS APPLY sys.dm_exec_sql_text (CP.plan_handle)
				CROSS APPLY sys.dm_exec_query_plan (CP.plan_handle)