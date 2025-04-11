#!/bin/bash

# Prompt the user for the directory to search in
read -p "Enter the directory to search for bodyfile.txt: " searchDir

# Check if the directory exists
if [ ! -d "$searchDir" ]; then
    echo "The directory '$searchDir' does not exist. Please provide a valid directory."
    exit 1
fi

# Prompt the user for the output file name
read -p "Enter the output file name (default: all_bodyfiles.csv): " outputFile
outputFile=${outputFile:-all_bodyfiles.csv}  # Default to all_bodyfiles.csv if no input

# Define the full path for the output file in the search directory
outputFile="$searchDir/$outputFile"

# Create or clear the output file
> "$outputFile"  # Clear the file if it exists or create a new one

# Find all instances of bodyfile.txt
find "$searchDir" -type f -name "bodyfile.txt" | while read -r file; do
    echo "Found: $file"
    # Run the mactime command for each found bodyfile.txt and append to the output file
    if ! mactime -b "$file" -d >> "$outputFile"; then
        echo "Error processing $file with mactime."
    fi
done

# Remove duplicate header rows from the output file
awk 'NR==1 {print; header=$0; next} $0 != header' "$outputFile" > temp_file && mv temp_file "$outputFile"

# Summary message
echo "All Body files have been processed and saved to $outputFile."