#                                                             VVVVVVVV Change this to your device's name as it appears on device manager
$device = Get-PnpDevice | Where-Object { $_.FriendlyName -eq 'BT5.0 KB' }

# Initialize an empty string for output
$outputContent = ""

# Check if the device was found
if ($device) {
    # Check if the device is connected                                                     (1)
    $isConnectedProperty = Get-PnpDeviceProperty -InstanceId $device.InstanceId -KeyName '{83DA6326-97A6-4088-9453-A1923F573B29} 15'
    $isConnected = $isConnectedProperty.Data

    if ($isConnected -eq $true) {
        # Retrieve the battery property,                                                     (2)
        $batteryProperty = Get-PnpDeviceProperty -InstanceId $device.InstanceId -KeyName '{104EA319-6EE2-4701-BD47-8DDBF425BBE5} 2'
        
        # Check if the battery property is not empty, otherwise it will return the same value over and over when the device is not connected.
        if ($batteryProperty.Type -ne 'Empty') {
            # Get the battery percentage
            $batteryPercentage = $batteryProperty.Data
            $outputContent = "Battery percentage of $($device.FriendlyName) is: $batteryPercentage"
        } else {
            $outputContent = "Battery property not found or is empty for $($device.FriendlyName)." # If it returns this message: something went wrong at (2).
            # First open  device manager > double click your bt device > go to the details tab > go through all properties and see if there's 
            # a property that contains a percentage value, if there is one, run the .ps1 file inside 
            # the debug folder (remember to write your device's name on line 4!!!!) and find the corresponding property for the percentage value.
            # if there's none, then I'm afraid this script is rendered useless.
        }
    } else {
        $outputContent = "Device $($device.FriendlyName) is not connected." # if it returns this message: 
            # First check device manager> double click your bt device> go to the details tab > see if there's a property named "is connected" 
            # (some devices may have other names for this property, if it's not there you should look for the long hex or whatever strings and 
            # cycle between bt on and off to see what boolean value it returns), if there is an "is connected" property, run the .ps1 file inside 
            # the debug folder (remember to write your device's name on line 4!) and find the corresponding property for "is connected". 
            # If it did not yield any results, but there *is* a battery percentage see (2), you can remove lines 31-37 (which includes this line) and 17-18.
    }
} else {
    $outputContent = "Device $($device.FriendlyName) not found." # You entered the incorrect bt device name, make sure you entered it correctly 
                                                                 # as it appears in device manager.
}

# Write the output content to the output file
"$outputContent" # Displays the output for debugging if necessary
$scriptDir = Split-Path -Parent $PSScriptRoot
$outputFilePath = Join-Path $scriptDir "output.txt"
$outputContent | Out-File -FilePath $outputFilePath