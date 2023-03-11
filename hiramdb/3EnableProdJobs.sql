exec msdb.dbo.sp_update_job  @job_name = N'WhoIsActive', @enabled = 1;  
exec msdb.dbo.sp_update_job  @job_name = N'Backup.TLogs', @enabled = 1;
go