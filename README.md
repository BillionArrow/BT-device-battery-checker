# BT-device-battery-checker
A simple Powershell script that checks the battery percentage of a specified Bluetooth device (e.g. keyboards, headphones etc.) using powershell and sends a warning through notifications that the battery level is low, prompts the user to recharge their device.
## Requirements
- A Windows device
- git
- Python (any version will probably work, tested with 3.12)
- plyer (for sending notifications) can be installed by entering `pip install plyer` into your terminal, 
## Installation
1. Install git and python if you haven't already

To make everything run faster, you can create a virtual environment:
2. Change the terminal directory using `cd` (if you're trying to move to a parent directory you can simply enter `cd ..`) to something of your choice and enter the following:
```
python -m venv bt_battery_checker
```
3. Check if the venv has been configured, it should look this:
```
>Scripts\activate
(bt_battery_checker) PS C:\Users\<user>\bt_battery_checker>
```
4. Install plyer
```
pip install plyer
```
1. Clone this repository into your venv:
```
git clone https://github.com/BillionArrow/BT-device-battery-checker/
```
You're good to go!
## Usage
(working on it)

## To-do
- Make a setup script
- automate the python code (right now it only sends a notif when the python file is ran manually)
- write scripts to add task scheduler entries automatically
