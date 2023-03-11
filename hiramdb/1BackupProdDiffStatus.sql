set nocount on;
drop table if exists #jobstatus;

create table #jobstatus (
	session_id int, 
	job_id uniqueidentifier,
	job_name sysname,
	run_requested_date datetime,
	run_requested_source sysname null,
	queued_date datetime,
	start_execution_date datetime,
	last_executed_step_id int,
	last_exectued_step_date datetime,
	stop_execution_date	datetime,
	next_scheduled_run_date	datetime, 
	job_history_id int,
	message	nvarchar(1024), 
	run_status int,
	operator_id_emailed int,
	operator_id_netsent int,
	operator_id_paged int
)
insert #jobstatus exec msdb.dbo.sp_help_jobactivity; 

select run_status 
from #jobstatus 
where job_name ='DatabaseBackup - USER_DATABASES - DIFF'
and run_requested_date >= dateadd(minute,-15,getdate()) 
and run_status = 1;
go
