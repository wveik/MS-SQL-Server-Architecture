declare @TableName varchar(100)='[dbo].[EpsJob]'

SELECT @TableName

EXECUTE('select * from ' + @TableName)