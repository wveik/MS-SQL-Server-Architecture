select * from INFORMATION_SCHEMA.COLUMNS		-- Проверка базы на наличие кирилицы в полях (и именах таблиц TABLE_NAME)
Where COLUMN_NAME like  N'%[А-Яа-я]%'