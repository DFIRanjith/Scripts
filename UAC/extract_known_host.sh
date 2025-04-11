#!/bin/bash

# Prompt the user for the directory to search for known_hosts files
read -p "Enter the directory to search for known_hosts files: " search_directory

# Check if the search directory exists
if [[ ! -d "$search_directory" ]]; then
    echo "Search directory not found: $search_directory"
    exit 1
fi

# Prompt the user for the output file name (without path)
read -p "Enter the output file name (e.g., output.txt): " output_file_name

# Define the full path for the output file
output_file="$search_directory/$output_file_name"

# Find all known_hosts files in the specified directory and its subdirectories
known_hosts_files=$(find "$search_directory" -type f -name "known_hosts")

# Check if any known_hosts files were found
if [[ -z "$known_hosts_files" ]]; then
    echo "No known_hosts files found in: $search_directory"
    exit 1
fi

# Write the content of each found known_hosts file to the output file
for known_hosts_file in $known_hosts_files; do
    echo "Contents of $known_hosts_file:" >> "$output_file"
    cat "$known_hosts_file" >> "$output_file"
    echo -e "\n" >> "$output_file"  # Add a newline for separation
done

echo "Contents of known_hosts files have been written to: $output_file"
