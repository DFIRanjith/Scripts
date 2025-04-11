#!/bin/bash

# Prompt the user for the directory to search for .bash_history files
read -p "Enter the directory to search for .bash_history files: " search_directory

# Check if the search directory exists
if [[ ! -d "$search_directory" ]]; then
    echo "Search directory not found: $search_directory"
    exit 1
fi

# Prompt the user for the output file name (without path)
read -p "Enter the output file name (e.g., output.txt): " output_file_name

# Define the full path for the output file
output_file="$search_directory/$output_file_name"

# Find all .bash_history files in the specified directory and its subdirectories
bash_history_files=$(find "$search_directory" -type f -name ".bash_history")

# Check if any .bash_history files were found
if [[ -z "$bash_history_files" ]]; then
    echo "No .bash_history files found in: $search_directory"
    exit 1
fi

# Write the content of each found .bash_history file to the output file
for bash_history_file in $bash_history_files; do
    echo "Contents of $bash_history_file:" >> "$output_file"
    cat "$bash_history_file" >> "$output_file"
    echo -e "\n" >> "$output_file"  # Add a newline for separation
done

echo "Contents of .bash_history files have been written to: $output_file"
