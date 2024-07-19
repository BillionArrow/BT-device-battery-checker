import os
from plyer import notification


def check_battery_status(file_path):
    # Check if the file exists
    if not os.path.isfile(file_path):
        print(f"File not found: {file_path}")
        return

    # Read the contents of the file with the correct encoding
    with open(file_path, 'r', encoding='utf-16-le') as file:
        content = file.read().strip()

    # Remove the BOM (When python reads the file, for some reason the text is preceded by
    # "\ufeff", which is a byte order mark and not necessary. furthermore, it throws an error
    # so why not just remove it)
    content = content.lstrip('\ufeff')

    # Check the content and handle accordingly
    if "Device 'BT5.0 KB' not found" in content:
        pass
        # We don't want to return a notification every x minutes informing the user
        # that the device is not found, i.e. either the user input had a typo or the values
        # are stored somewhere else.
    elif "Device 'BT5.0 KB' is not connected" in content:
        pass
        # idem above, but with 'true' and 'false' inside the "is connected" property.
    elif "Battery property not found or is empty" in content:
        pass

    else:
        try:
            battery_percentage = int(content.split(':')[-1].strip())
            # You can play around with this if you want, remove the 3 apostrophes above ander under this piece of code
            '''    
            notification.notify(
                title='Battery Status',
                message=f'Your keyboard battery is at {battery_percentage}%',
                app_name='Battery Checker'
                )
            '''
            if battery_percentage <= 15 and battery_percentage > 5: # Arbitrary, you can set this to whatever value you want.
                notification.notify(
                    title='Low Battery Warning',
                    message=f'Your device battery is at {battery_percentage}%, please consider plugging in your device.',
                    app_name='Battery Checker'
                )
            elif battery_percentage <= 5:
                notification.notify(
                    title='Low Battery Warning',
                    message=f'Your device battery is at {battery_percentage}%, plug in your device before it shuts down.',
                    app_name='Battery Checker'
                )

        except ValueError:
            print("Failed to parse battery percentage from the file content.")


# Get the directory of the current script
script_dir = os.path.dirname(os.path.abspath(__file__))

# Get the parent directory
parent_dir = os.path.abspath(os.path.join(script_dir, os.pardir))

# Construct the path to the output file in the parent directory
file_path = os.path.join(parent_dir, "output.txt")


check_battery_status(file_path)