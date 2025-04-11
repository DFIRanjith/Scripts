#!/bin/bash

# Prompt the user for the path to the text file containing hash values
read -p "Enter the path to the hash values file: " hash_file

# Check if the hash file exists
if [[ ! -f "$hash_file" ]]; then
    echo "Hash values file not found: $hash_file"
    exit 1
fi

# Prompt the user for the directory to search for hash_executables.sha1 files
read -p "Enter the directory to search for hash_executables.sha1 files: " search_directory

# Check if the search directory exists
if [[ ! -d "$search_directory" ]]; then
    echo "Search directory not found: $search_directory"
    exit 1
fi

# Prompt the user for the output file name
read -p "Enter the output file name (without path): " output_file_name

# Define the full path for the output file
output_file="$search_directory/$output_file_name"

# Find all hash_executables.sha1 files in the specified directory and its subdirectories
hash_executables_files=$(find "$search_directory" -type f -name "hash_executables.sha1")

# Check if any hash_executables.sha1 files were found
if [[ -z "$hash_executables_files" ]]; then
    echo "No hash_executables.sha1 files found in: $search_directory"
    exit 1
fi

# Clear the output file if it exists
> "$output_file"

# Read each hash value from the hash file
while IFS= read -r hash_value; do
    # Check each found hash_executables.sha1 file
    while IFS= read -r hash_executables_file; do
        # Use grep to find the hash value in the file and output the matched line
        if grep -q "$hash_value" "$hash_executables_file"; then
            # Output the matched hash value and the file name to the output file
            echo "Match found: $hash_value in $hash_executables_file" >> "$output_file"
        fi
    done <<< "$hash_executables_files"
done < "$hash_file"

echo "Output written to: $output_file"