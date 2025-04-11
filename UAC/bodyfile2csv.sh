#!/bin/bash

# Prompt the user for the directory to search in
read -p "Enter the directory to search for bodyfile.txt: " searchDir

# Check if the directory exists
if [ ! -d "$searchDir" ]; then
    echo "The directory '$searchDir' does not exist. Please provide a valid directory."
    exit 1
fi

# Find all instances of bodyfile.txt
find "$searchDir" -type f -name "bodyfile.txt" | while read -r file; do
    echo "Found: $file"
    # Run the mactime command for each found bodyfile.txt
    mactime -b "$file" -d > "${file%.txt}.csv"
done

echo "Done."
