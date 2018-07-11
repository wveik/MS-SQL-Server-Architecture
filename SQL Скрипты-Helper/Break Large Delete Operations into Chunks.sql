--Delete records from large tables in batches without growing the Transaction Log in SQL Server.
set nocount on;
 
declare @deleteBatchSize int;
declare @rowsAffected bigint;
 
set @deleteBatchSize = 10000;
set @rowsAffected = @deleteBatchSize;
 
while @rowsAffected = @deleteBatchSize
begin
  begin transaction;
    delete top (@deleteBatchSize) from SOME_LG_TABLE
    set @rowsAffected = @@ROWCOUNT;
  commit transaction;
 
  -- CHECKPOINT;    -- if simple recovery model
  -- BACKUP LOG ... -- if full recovery model
end;
