DECLARE	@Letter varchar (50)
SET	@Letter = 'Z'

--EXECUTE ('SELECT * FROM Table_1 WHERE Raz = ''' + @Letter + '''')

EXECUTE		sp_ExecuteSQL	N'SELECT * FROM Table_1 WHERE Raz = @MyParam1',
												N'@MyParam1 varchar (50)',
												@Letter