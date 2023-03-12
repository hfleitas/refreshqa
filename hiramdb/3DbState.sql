set nocount on;

select state
from sys.databases 
where name ='hiramdb'
and state_desc = 'ONLINE'
go
