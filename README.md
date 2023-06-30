# Consistent COM Port Assignments for USB Serial Devices on Linux

This guide explains how to create a udev rule to ensure that a USB serial device retains the same COM port assignment on Linux every time it is connected.

## Prerequisites

- Linux operating system
- Root access or sudo privileges

## Instructions

### 1. Identify the USB Device

Connect your USB serial device to your Linux system and run the following command to identify its attributes:

```
lsusb
```


Look for the entry corresponding to your USB serial device, which will provide information about the Vendor ID (VID) and Product ID (PID). Make a note of these values for later use.

```
Bus 006 Device 002: ID 1a86:7523 QinHeng Electronics CH340 serial converter
```

In above example the VID is "1a86" and PID is "7523"

### 2. Create a udev Rule File

Open a terminal and create a new udev rule file with a name like `99-usb-serial.rules` in the `/etc/udev/rules.d/` directory using a text editor:

```
sudo nano /etc/udev/rules.d/99-usb-serial.rules
```


### 3. Add the udev Rule

In the text editor, add a line that matches the VID and PID of your USB serial device and assigns a specific name to it. The rule should be in the following format:

```
SUBSYSTEM=="tty", ATTRS{idVendor}=="your_VID", ATTRS{idProduct}=="your_PID", SYMLINK+="your_desired_name"
```


Replace `your_VID` and `your_PID` with the actual VID and PID of your USB serial device. Also, replace `your_desired_name` with the name you want to assign to the device, such as `ttyUSB0`.

### 4. Save and Exit

Save the file and exit the text editor. In Nano, you can do this by pressing Ctrl+O to save and Ctrl+X to exit.

### 5. Reload udev Rules

Run the following command to reload the udev rules:

```
sudo udevadm control --reload-rules
```

### 6. Reconnect the USB Serial Device

Disconnect and reconnect your USB serial device to apply the changes.

## Testing

To verify that the udev rule is working correctly, you can check if the USB serial device is assigned the specified name by running the following command:

```
ls -l /dev/your_desired_name
```


Replace `your_desired_name` with the name you assigned in the udev rule. If the device is successfully recognized, it should display the device file with its corresponding path, such as `/dev/ttyUSB0`.

## Conclusion

By following these instructions and creating a custom udev rule, you can ensure that your USB serial device retains the same COM port assignment on Linux every time it is connected. This can be particularly useful when working with applications that rely on consistent device paths.
