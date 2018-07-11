select db_name(dbid) as DatabaseName,
    count(dbid) as NumberOfConnections,
    loginame as LoginName
from sys.sysprocesses
where dbid > 0
group by dbid, loginame;