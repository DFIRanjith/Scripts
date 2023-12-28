#!/bin/bash

# Set the path to the package file
pkg_file="/Library/Application Support/Microsoft/Defender/response/Aftermath.pkg"

# Check if the package file exists
if [ -f "$pkg_file" ]; then
    echo "Found package file: $pkg_file"
else
    echo "Package file not found: $pkg_file. Exiting."
    exit 1
fi

# Install the package
echo "Installing $pkg_file..."
if sudo installer -pkg "$pkg_file" -target /; then
    echo "Installation complete."
else
    echo "Failed to install $pkg_file. Exiting."
    exit 1
fi

echo "Script execution complete."