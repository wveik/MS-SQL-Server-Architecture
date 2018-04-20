DECLARE		@F1 geography = 'POLYGON ((50 30, 60 30, 60 40, 50 40, 50 30))',
						@F2 geography = 'POLYGON ((-40 -30, -70 -30, -70 -60, -40 -60, -40 -30))'
SELECT	@F1
	UNION ALL
SELECT	@F2
