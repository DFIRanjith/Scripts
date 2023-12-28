#!/bin/bash

# Set paths
plist_file="/Library/Application Support/Microsoft/Defender/response/launchd.aftermath.plist"
launch_daemons_dir="/Library/LaunchDaemons"
launch_daemon_file="launchd.aftermath.plist"

# Copy the plist file to LaunchDaemons
echo "Copying $plist_file to $launch_daemons_dir..."
sudo cp "$plist_file" "$launch_daemons_dir"

# Load the LaunchDaemon
echo "Loading LaunchDaemon..."
sudo launchctl load -w "$launch_daemons_dir/$launch_daemon_file"

echo "Script execution complete."
