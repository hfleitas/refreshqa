set nocount on;

if @@servername in ('hiramdb1')
begin
	ALTER DATABASE [hiramdb] SET RECOVERY SIMPLE WITH NO_WAIT;
	exec ('use hiramdb; DBCC SHRINKFILE (2 , 64)');
end
go

--Dbowner to sa
EXEC master.dbo.sp_MSforeachdb @command1 = N'
if ''?'' not in (''master'',''model'',''msdb'',''tempdb'',''distribution'',''distribution1'',''distribution2'',''claims'') 
begin 
	exec ?.dbo.sp_changedbowner @loginame = skylar, @map = false 
end'
go
