exec msdb.dbo.sp_update_job  @job_name = N'WhoIsActive', @enabled = 0;  
exec msdb.dbo.sp_update_job  @job_name = N'Backup.TLogs', @enabled = 0;
go