# Define the path to the PowerShell script
$scriptPath = "$PSScriptRoot\keeb_battery_checker.ps1"

# Start the job to run the PowerShell script
$job = Start-Job -ScriptBlock {
    param($path)
    & $path
} -ArgumentList $scriptPath

# Wait for the job to complete and retrieve the results
$job | Wait-Job | Receive-Job

# Optionally, remove the job after completion
Remove-Job -Job $job
