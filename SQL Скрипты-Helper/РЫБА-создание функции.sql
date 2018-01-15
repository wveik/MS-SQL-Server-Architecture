if object_id('dbo.GetFlightDirectionType') is not null
 drop function dbo.GetFlightDirectionType
go
create function [dbo].[GetFlightDirectionType]
(
 @chkey int,
 @ResStartPoint int
)
RETURNS int
BEGIN
 
 
 return 1;
END
go
grant exec on dbo.GetFlightDirectionType to public
go