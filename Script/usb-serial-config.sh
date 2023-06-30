#!/bin/bash

# Create udev rule file
RULE_FILE="/etc/udev/rules.d/99-usb-serial.rules"

# Check if running with root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root or with sudo privileges."
  exit 1
fi

# Function to delete existing udev rule
delete_existing_rule() {
  # Check if udev rule file exists
  if [[ -f $RULE_FILE ]]; then
    read -p "An existing udev rule file already exists. Do you want to delete it? (y/n): " confirm
    if [[ $confirm == "y" || $confirm == "Y" ]]; then
      sudo rm "$RULE_FILE"
      echo "Existing udev rule deleted."
    else
      echo "Please remove or rename the existing udev rule file before running this script."
      exit 1
    fi
  fi
}

# Prompt user for configuration values
read -p "Enter the Vendor ID (VID) of your USB serial device (in hexadecimal format): " VID
read -p "Enter the Product ID (PID) of your USB serial device (in hexadecimal format): " PID
read -p "Enter the desired name for the USB serial device (e.g., ttyUSB0): " DESIRED_NAME

# Delete existing udev rule if confirmed by the user
delete_existing_rule

# Create udev rule
echo "SUBSYSTEM==\"tty\", ATTRS{idVendor}==\"$VID\", ATTRS{idProduct}==\"$PID\", SYMLINK+=\"$DESIRED_NAME\"" | sudo tee "$RULE_FILE" >/dev/null

# Set group ownership and permissions for the USB device
DEVICE_FILE="/dev/$DESIRED_NAME"
sudo chown root:usbusers "$DEVICE_FILE"
sudo chmod g+rw "$DEVICE_FILE"

# Reload udev rules
sudo udevadm control --reload-rules

echo "Configuration completed successfully. Reconnect your USB serial device for the changes to take effect."
