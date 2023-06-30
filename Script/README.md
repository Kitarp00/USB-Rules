# USB Serial Device Configuration Script

This script allows you to configure consistent COM port assignments for USB serial devices on Linux. It creates a custom udev rule based on the provided Vendor ID (VID), Product ID (PID), and desired name.

## Prerequisites

- Linux operating system
- Root access or sudo privileges

## Usage

1. Download the `usb-serial-config.sh` script.
2. Open a terminal and navigate to the directory where the script is located.
3. Make the script executable by running the command:

```
chmod +x usb-serial-config.sh
```
4. Run the script with root privileges:
```
sudo ./usb-serial-config.sh
```

The script will guide you through the configuration process by prompting you to enter the VID, PID, and desired name for your USB serial device. It will create a udev rule, reload the udev rules, and provide instructions for reconnecting the USB serial device to apply the changes.

Please note that executing this script requires root privileges, so make sure to run it with `sudo` or as the root user.

## Existing Rule

If an existing udev rule for USB serial devices already exists, the script will prompt you to confirm if you want to delete it before creating a new rule. If you choose not to delete the existing rule, the script will exit without making any changes. This ensures that you have control over modifying existing configurations.

## Troubleshooting

If you encounter any issues or if the COM port assignments are not consistent after running the script, you can try the following:

- Verify that the VID and PID values provided are correct for your USB serial device.
- Check if the udev rule file `/etc/udev/rules.d/99-usb-serial.rules` has been created or modified as expected.
- Reload the udev rules manually by running the command:

```
sudo udevadm control --reload-rules
```
- Make sure to reconnect your USB serial device after running the script for the changes to take effect.

If the problem persists, you can seek further assistance from the device manufacturer or Linux community forums.


