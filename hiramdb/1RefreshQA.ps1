import-module dbatools
Set-Location c:\RefreshQA

## save latest qa backup
$dir = "\\hiramsqlgroupdiag.file.core.windows.net\sqlshared\hiramdb1\hiramdb\FULL\"
$filter = "*hiramdb*.bak"
$latest = Get-ChildItem -Path $dir -Filter $filter | Sort-Object LastAccessTime -Descending | Select-Object -First 1
$dest = "deployments\"
$to = ("\\hiramsqlgroupdiag.file.core.windows.net\sqlshared\hiramdb1\" + $dest + $latest.name)
$from = ($dir + $latest.name)
Move-Item -Path $from -Destination $to


# script out permissions
Invoke-DbaQuery -SqlInstance hiramdb1 -Database hiramdb -File ".\0ScriptOutPermissions.sql" -Verbose -MessagesToOutput | out-file "5ResetDBSecurityPermissions.sql" -force

#refresh
Invoke-DbaQuery -SqlInstance hiramdb2 -File ".\0DisableProdJobs.sql"
Invoke-DbaQuery -SqlInstance hiramdb2 -File ".\1BackupProdDiff.sql"
Invoke-DbaQuery -SqlInstance hiramdb1 -File ".\1Kill.sql"

$RestoreTime = Get-Date 
Get-DbaDbBackupHistory -SqlInstance hiramdb2 `
-Database hiramdb `
-Last | Restore-DbaDatabase -SqlInstance hiramdb1 `
-DestinationDataDirectory f:\data\ `
-DestinationLogDirectory g:\log\ `
-WithReplace | Format-Table -auto | out-file "OutputRefresh.txt" -Append
write-host 'STARTED' $RestoreTime ', FINISHED'(get-date)

#reset
Invoke-DbaQuery -SqlInstance hiramdb1 -File ".\2TrustWorthyDBOwnerTLogShrink.sql"
Invoke-DbaQuery -SqlInstance hiramdb2 -File ".\3EnableProdJobs.sql"
Invoke-DbaQuery -SqlInstance hiramdb1 -Database hiramdb -File ".\4ResetData.sql"

Invoke-DbaQuery -SqlInstance hiramdb1 -Database hiramdb -File ".\4SyncLogins.sql"
Invoke-DbaQuery -SqlInstance hiramdb1 -Database hiramdb -File ".\5ResetDBSecurityPermissions.sql"
