WIHT MyProducts AS (
	SELECT *,
		ROW_NUMBER() OVER (ORDER BY Price ASC) AS NUM1,
		ROW_NUMBER() OVER (ORDER BY Price DESC) AS NUM2
	FROM ORDERS
)

SELECT --*, NUM1 - NUM2
AVG(Price)
FROM MyProducts
WHERE ABS(NUM1 - NUM2) <= 2
