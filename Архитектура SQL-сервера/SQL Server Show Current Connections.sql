select
    GetDate() as Run_Date,
    rtrim(Cast(@@ServerName as varchar(100))) as [Server],
    spid,
    blocked,
    waittime,
    sb.name,
    lastwaittype,
    sp.cpu,
    sp.login_time,
    sp.last_batch,
    sp.status,
    sp.hostname,
    sp.program_name,
    sp.cmd,
    sp.loginame,
    getdate() - last_batch as duration
from master..sysprocesses as sp
inner join master..sysdatabases as sb
    on sp.dbid = sb.dbid;
