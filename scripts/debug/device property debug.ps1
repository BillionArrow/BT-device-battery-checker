#run this in windows terminal or powershell (not command prompt)
# see bt_battery_checker.ps1 for extra steps.

# Retrieve the Bluetooth device with the specified friendly name                 VVVVVVVV Change the device to what you see on device manager, all properties will then be shown.
$device = Get-PnpDevice -Class 'Bluetooth' | Where-Object { $_.FriendlyName -eq 'BT5.0 KB' }
Get-PnpDeviceProperty -InstanceId $device.InstanceId