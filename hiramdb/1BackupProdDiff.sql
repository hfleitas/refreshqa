exec msdb.dbo.sp_update_job  @job_name = N'WhoIsActive', @enabled = 0;
exec msdb.dbo.sp_update_job  @job_name = N'Backup.TLogs', @enabled = 0;  
GO  

if @@servername not in ('FLDSVRSDV01','FLDSVRSQA01')
begin 
	if exists (select 1 from msdb.dbo.sysjobs where name ='Backup.Diff') 
	begin
		exec msdb.dbo.sp_start_job 'Backup.Diff'
	end
	waitfor delay '00:05:00'
end
go 
