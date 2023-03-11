import-module dbatools
Set-Location c:\fleitasarts\Private\RefreshQA\LicenseManagement

## save latest qa backup
$dir = "\\fldsvm_apps01\SQLSHARED\FLDSVRSQA01\"
$filter = "LicenseManagement_backup_*.bak"
$latest = Get-ChildItem -Path $dir -Filter $filter | Sort-Object LastAccessTime -Descending | Select-Object -First 1
$dest = "Deployments\"
$to = ($dir + $dest + $latest.name)
$from = ($dir + $latest.name)
Move-Item -Path $from -Destination $to

# script out permissions
Invoke-DbaQuery -SqlInstance FLDSVRSQA01 -Database LicenseManagement -File ".\0ScriptOutPermissions.sql" -Verbose -MessagesToOutput | out-file "5ResetDBSecurityPermissions.sql" -force

#refresh
Invoke-DbaQuery -SqlInstance FLDASP01_LG01 -File ".\0DisableProdJobs.sql"
Invoke-DbaQuery -SqlInstance FLDASP01_LG01 -File ".\1BackupProdDiff.sql"
Invoke-DbaQuery -SqlInstance FLDSVRSQA01 -File ".\1Kill.sql"

$RestoreTime = Get-Date 
Get-DbaDbBackupHistory -SqlInstance FLDASP01_LG01 `
-Database LicenseManagement `
-Last | Restore-DbaDatabase -SqlInstance FLDSVRSQA01 `
-DestinationDataDirectory S:\SQLDATA\ `
-DestinationLogDirectory L:\SQLLOGS\ `
-WithReplace | Format-Table -auto | out-file "OutputRefresh.txt" -Append
write-host 'STARTED' $RestoreTime ', FINISHED'(get-date)

#reset
Invoke-DbaQuery -SqlInstance FLDSVRSQA01 -File ".\2TrustWorthyDBOwnerTLogShrink.sql"
Invoke-DbaQuery -SqlInstance FLDASP01_LG01 -File ".\3EnableProdJobs.sql"
Invoke-DbaQuery -SqlInstance FLDSVRSQA01 -Database LicenseManagement -File ".\4ResetData.sql"

Invoke-DbaQuery -SqlInstance FLDSVRSQA01 -Database LicenseManagement -File ".\4SyncLogins.sql"
Invoke-DbaQuery -SqlInstance FLDSVRSQA01 -Database LicenseManagement -File ".\5ResetDBSecurityPermissions.sql"
