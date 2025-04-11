#!/bin/bash

# Prompt the user for the directory to search
read -p "Enter the directory to search for 'btmp' and 'wtmp': " search_dir

# Check if the directory exists
if [ ! -d "$search_dir" ]; then
    echo "The directory '$search_dir' does not exist."
    exit 1
fi

# Define the output file in the search directory
output_file="$search_dir/last_output.txt"

# Clear the output file if it exists
> "$output_file"

# Find and process the files named "btmp" and "wtmp"
for file in $(find "$search_dir" -type f \( -name "btmp" -o -name "wtmp" \)); do
    echo "Processing file: $file" >> "$output_file"
    last -f "$file" >> "$output_file"
    echo -e "\n" >> "$output_file"  # Add a newline for better readability
done

echo "Output written to $output_file"