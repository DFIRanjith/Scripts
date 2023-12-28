#!/bin/bash

# Set the path to the uninstaller package file
uninstaller_pkg="/Library/Application Support/Microsoft/Defender/response/AftermathUninstaller.pkg"

# Set the path to the Aftermath daemon launch daemon file
launch_daemons_dir="/Library/LaunchDaemons"
launch_daemon_file="launchd.aftermath.plist"

# Check if the uninstaller package file exists
if [ -f "$uninstaller_pkg" ]; then
    echo "Found uninstaller package file: $uninstaller_pkg"
else
    echo "Uninstaller package file not found: $uninstaller_pkg. Exiting."
    exit 1
fi

# Uninstall Aftermath
echo "Uninstalling Aftermath using $uninstaller_pkg..."
if sudo installer -pkg "$uninstaller_pkg" -target /; then
    echo "Uninstallation complete."
else
    echo "Failed to uninstall Aftermath using $uninstaller_pkg. Exiting."
    exit 1
fi

# Unload Aftermath daemon
echo "Unloading Aftermath daemon..."
if sudo launchctl unload -w "$launch_daemons_dir/$launch_daemon_file"; then
    echo "Aftermath daemon unloaded successfully."
else
    echo "Failed to unload Aftermath daemon. Exiting."
    exit 1
fi

echo "Script execution complete."
