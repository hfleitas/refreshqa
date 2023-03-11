set nocount on;

if @@servername in ('FLDSVRSDV01','FLDSVRSQA01')
begin
	ALTER DATABASE [LicenseManagement] SET RECOVERY SIMPLE WITH NO_WAIT;
	exec ('use LicenseManagement; DBCC SHRINKFILE (2 , 64)');
end
go

--Dbowner to sa
EXEC master.dbo.sp_MSforeachdb @command1 = N'
if ''?'' not in (''master'',''model'',''msdb'',''tempdb'',''distribution'',''distribution1'',''distribution2'',''claims'') 
begin 
	exec ?.dbo.sp_changedbowner @loginame = sa, @map = false 
end'
go
