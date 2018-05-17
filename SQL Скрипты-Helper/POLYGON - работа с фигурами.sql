DECLARE	@Figure1 geometry,
					@Figure2 geometry,
					@Figure3 geometry

SET	@Figure1 = 'POLYGON ((1 1, 4 1, 4 3, 1 3, 1 1))'
SET	@Figure2 = 'POLYGON ((2 0, 5 2, 1 4, 2 0))'


SELECT	@Figure1
	UNION ALL
SELECT	@Figure2

SELECT	@Figure1.STIntersects (@Figure2), @Figure1.STIntersection (@Figure2)

SET	@Figure3 = @Figure1.STIntersection (@Figure2)

SELECT	@Figure3.STArea (), @Figure3.ToString (), @Figure3.STLength (), @Figure3.STNumPoints ()
