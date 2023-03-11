exec msdb.dbo.sp_update_job  @job_name = N'DatabaseBackup - USER_DATABASES - LOG', @enabled = 0;  
GO  

if @@servername not in ('hiramdb1')
begin 
	if exists (select 1 from msdb.dbo.sysjobs where name ='DatabaseBackup - USER_DATABASES - DIFF') 
	begin
		exec msdb.dbo.sp_start_job 'DatabaseBackup - USER_DATABASES - DIFF'
	end
	waitfor delay '00:05:00'
end
go 
