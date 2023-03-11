set nocount on;

select state
from sys.databases 
where name ='LicenseManagement'
and state_desc = 'ONLINE'
go