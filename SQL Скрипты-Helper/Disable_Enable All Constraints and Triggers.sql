use <database_name>;
go
 
--
-- Disable All Constraints and Triggers:
exec sp_msforeachtable
    @command1 = "print 'Disabling Constraints on ?'",
    @command2 = "ALTER TABLE ? NOCHECK CONSTRAINT all";
exec sp_msforeachtable
    @command1 = "print 'Disabling Triggers in ?'",
    @command2 = "ALTER TABLE ? DISABLE TRIGGER all";
 
--
-- Enable All Constraints and Triggers:
exec sp_msforeachtable
    @command1 = "print 'Enabling Constraints on ?'",
    @command2 = "ALTER TABLE ? CHECK CONSTRAINT all";
exec sp_msforeachtable
    @command1 = "print 'Enabling Triggers in ?'",
    @command2 = "ALTER TABLE ? ENABLE TRIGGER all";
