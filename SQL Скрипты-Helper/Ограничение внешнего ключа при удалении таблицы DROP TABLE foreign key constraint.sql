SELECT * 
FROM sys.foreign_keys
WHERE referenced_object_id = object_id('[cfg].[tree]')

select * from sys.objects
where object_id=754817751 --parent_object_id

--and if there are any, with this statement here, you could create SQL statements to actually drop those FK relations:

SELECT 
    'ALTER TABLE [' +  OBJECT_SCHEMA_NAME(parent_object_id) +
    '].[' + OBJECT_NAME(parent_object_id) + 
    '] DROP CONSTRAINT [' + name + ']'
FROM sys.foreign_keys
WHERE referenced_object_id = object_id('[cfg].[tree]')
