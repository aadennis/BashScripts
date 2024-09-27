#!/bin/bash
# requires sudo apt install jq

config_file="backup_config.cfg"
json_file="backup_config.json"

if [ ! -f "$config_file" ]; then
    echo "Config file not found!"
    exit 1
fi

# Function to extract value using jq
extract_value() {
  local json="$1"
  cat "$json" | jq -r '.onedrive.src'
}

# Call the function and capture the output
value=$(extract_value "$json_file")

# Print the extracted value
echo "The value of foo.bar.baz is: $value"
exit 1

echo "Please choose an option:"
echo "a) onedrive"
echo "b) outlook"
read -p "Enter your choice (a/b): " choice

# Function to read values from the config file using awk (debug messages separate)
get_config_value() {
    local section=$1
    local key=$2
    awk -F '=' -v section="[$section]" -v key="$key" '
    $0 == section { found_section=1; next }
    found_section && $1 == key { print $2; exit }
    ' "$config_file"
}

get_config_value_2() {

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
