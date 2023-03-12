exec msdb.dbo.sp_update_job  @job_name = N'DatabaseBackup - USER_DATABASES - LOG', @enabled = 1;
go
