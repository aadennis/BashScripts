#!/bin/bash
# requires sudo apt install jq



echo "Please choose an option:"
echo "a) onedrive"
echo "b) outlook"
read -p "Enter your choice (a/b): " choice

# Function to read values from the config file using awk (debug messages separate)
get_config_value() {
    local config_file="backup_config.json"
    if [ ! -f "$config_file" ]; then
        echo "Config file not found!"
        exit 1
    fi
    local config_value="$1"
    json=$(cat $config_file | jq -r $config_value)
    echo $json
}

node=".outlook.dest"
# Set src and dest based on the user's choice
if [[ $choice == "a" || $choice == "A" ]]; then
    src=$(get_config_value ".onedrive.src")
    dest=$(get_config_value ".onedrive.dest")
elif [[ $choice == "b" || $choice == "B" ]]; then
    src=$(get_config_value ".outlook.src")
    dest=$(get_config_value ".outlook.dest")
else
    echo "Invalid choice. Exiting."
    exit 1
fi

# DEBUGGING: Output the values of src and dest for verification
echo "DEBUG: Source directory (src) = '$src'"
echo "DEBUG: Destination directory (dest) = '$dest'"

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
