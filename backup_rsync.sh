#!/bin/bash

# Path to the config file
config_file="backup_config.cfg"

# Check if the config file exists
if [ ! -f "$config_file" ]; then
    echo "Config file not found!"
    exit 1
fi

# Prompt the user to choose between "onedrive" or "outlook"
echo "Please choose an option:"
echo "a) onedrive"
echo "b) outlook"
read -p "Enter your choice (a/b): " choice

# Function to read values from the config file
function get_config_value {
    local section=$1
    local key=$2
    grep -A1 "^\[$section\]" "$config_file" | grep "^$key=" | cut -d'=' -f2
}

# Set src and dest based on the user's choice
if [[ $choice == "a" || $choice == "A" ]]; then
    src=$(get_config_value "onedrive" "src")
    dest=$(get_config_value "onedrive" "dest")
elif [[ $choice == "b" || $choice == "B" ]]; then
    src=$(get_config_value "outlook" "src")
    dest=$(get_config_value "outlook" "dest")
else
    echo "Invalid choice. Exiting."
    exit 1
fi

# Verify that src and dest are not empty
if [[ -z "$src" || -z "$dest" ]]; then
    echo "Source or destination is empty. Please check your config file."
    exit 1
fi

# Dry run to check what will be transferred or deleted
echo "Starting dry-run..."
rsync -avhziv --delete --dry-run "$src" "$dest" | more

# Ask the user to confirm if they want to proceed with the actual backup
read -p "Do you want to proceed with the actual backup? (y/n): " confirm

if [[ $confirm == "y" || $confirm == "Y" ]]; then
    # Actual rsync command without the --dry-run
    echo "Starting the actual backup..."
    rsync -avhziv --delete "$src" "$dest"
    echo "Backup completed."
else
    echo "Backup aborted."
fi
