#!/bin/bash

# Prompt the user for the directory to search for files
read -p "Enter the directory to search for files: " search_directory

# Check if the search directory exists
if [[ ! -d "$search_directory" ]]; then
    echo "Search directory not found: $search_directory"
    exit 1
fi

# Prompt the user for the full file path containing malicious IP addresses
read -p "Enter the file path containing malicious IP addresses: " ip_file

# Check if the IP address file exists
if [[ ! -f "$ip_file" ]]; then
    echo "IP address file not found: $ip_file"
    exit 1
fi

# Create an output file to store the results in the search directory
output_file="$search_directory/malicious_ip_search_results.txt"
echo "Summary of malicious IP address matches:" > "$output_file"

# Declare an associative array to hold counts
declare -A ip_counts

# Read each IP address from the file and search in the specified directory
while IFS= read -r ip_address; do
    echo "Searching for IP: $ip_address"
    # Use grep to find the IP address and count occurrences
    while IFS=: read -r file line; do
        # Increment the count for this IP address and file
        ((ip_counts["$ip_address:$file"]++))
    done < <(grep -rH "$ip_address" "$search_directory")
done < "$ip_file"

# Write the summary counts to the output file
for key in "${!ip_counts[@]}"; do
    IFS=':' read -r ip file <<< "$key"
    echo "Found IP: $ip in file: $file, Count: ${ip_counts[$key]}" >> "$output_file"
done

echo "Search completed. Results are stored in: $output_file"