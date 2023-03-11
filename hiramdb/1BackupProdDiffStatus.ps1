while($val -notmatch '@{run_status=1}')
{
    $val = Invoke-DbaQuery -SqlInstance hiramdb2 -File ".\1BackupProdDiffStatus.sql" | select-object run_status
    Write-Host $val
    Start-Sleep -Seconds 3
}
