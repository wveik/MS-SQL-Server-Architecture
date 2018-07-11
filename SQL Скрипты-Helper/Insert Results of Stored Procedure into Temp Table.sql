use myDbName;
go
 
--
-- drop the temp table if already exists:
if OBJECT_ID('tempdb..#myTableName') is not null
    begin
        drop table #myTableName;
    end;
 
create table #myTableName(
    location varchar(30) null,
    created_at datetime null
);
 
insert into #myTableName
    exec dbo.sp_name;
 
select * from #myTableName;
