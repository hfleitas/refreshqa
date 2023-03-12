select rh.destination_database_name as 'Database',
       case when rh.restore_type = 'D' then 'Database'
            when rh.restore_type = 'F' then 'File'
            when rh.restore_type = 'I' then 'Differential'
            when rh.restore_type = 'L' then 'Log'
            else rh.restore_type end as RestoreType,
       rh.restore_date as RestoreDate,
       bmf.physical_device_name as Source, 
       rf.destination_phys_name as RestoreFile,
       rh.user_name as RestoredBy
from msdb.dbo.restorehistory rh
inner join msdb.dbo.backupset bs on rh.backup_set_id = bs.backup_set_id
inner join msdb.dbo.restorefile rf on rh.restore_history_id = rf.restore_history_id
inner join msdb.dbo.backupmediafamily bmf on bmf.media_set_id = bs.media_set_id
order by rh.restore_history_id desc
go
