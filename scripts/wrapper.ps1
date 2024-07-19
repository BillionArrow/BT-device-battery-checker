# No idea how this works, but is necessary to run the script without flashing a fugly black terminal screen #for .2 seconds

# Define the path to the PowerShell script
$scriptPath = "$PSScriptRoot\bt_battery_checker.ps1"

$job = Start-Job -ScriptBlock {
    param($path)
    & $path
} -ArgumentList $scriptPath

$job | Wait-Job | Receive-Job

Remove-Job -Job $job
