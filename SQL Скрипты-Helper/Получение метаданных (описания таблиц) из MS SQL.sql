SELECT tbl.name [Table],
       c.name [Column],
       t.name AS system_data_type,
       t.max_length [MaxLength],
       c.precision,
       c.[scale],
       c.is_nullable [IsNullable],
       sep.value [Description]
FROM sys.tables tbl
     INNER JOIN sys.columns c ON tbl.object_id = c.object_id
     INNER JOIN sys.types t ON c.user_type_id = t.user_type_id
     LEFT JOIN sys.extended_properties sep ON tbl.object_id = sep.major_id
                                              AND c.column_id = sep.minor_id
                                              AND sep.name = 'MS_Description'
WHERE tbl.name IN('cardoption')
AND c.name='cardid_r';