--  By: Hiram Fleitas, hiramfleitas@hotmail.com. 

--  +--------+
--  | Backup |
--  +--------+
--  :connect lprospect010
backup database [LicenseManagement] to disk = '\\fldsvm_apps01\SQLSHARED\FLDSVRSQA01\Deployments\LicenseManagement20210419_preRollback.bak'
with noformat, noinit, skip, norewind, nounload, compression
, encryption(algorithm = AES_256, server certificate = [BackupCertWithPK2020])
, stats = 25;
go

--  +-------------------+
--  | Restore + Replace |
--  +-------------------+
--  :connect localhost
set nocount on;
declare @kill nvarchar(max) = '';

if exists (select 1 from sys.dm_exec_sessions where database_id  = db_id('LicenseManagement'))
begin
	select 	@kill = @kill + 'KILL ' + convert(varchar(5), session_id) + ';'
	from	sys.dm_exec_sessions
	where 	database_id  = db_id('LicenseManagement')

	exec sp_executesql @kill;
end
go

if db_id(N'LicenseManagement') is not null
begin 
	alter database [LicenseManagement] set single_user with rollback immediate;
	drop database [LicenseManagement] 
end
if 1=1 
begin
	restore database [LicenseManagement] from disk = '\\fldsvm_apps01\SQLSHARED\FLDSVRSQA01\Deployments\LicenseManagement_backup_2021_04_18_000002_4865164.bak' with replace, file = 1,  
	nounload, stats = 25;
end
go
