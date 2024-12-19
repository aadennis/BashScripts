#!/bin/bash
# sudo apt install jq

get_config_value() {
    local config_file="$1"
    local config_value="$2"
    json=$(cat $config_file | jq -r $config_value)
    echo $json
}

config_file="backup_config.json"
node=".outlook.dest"
node_value=$(get_config_value $config_file $node)
echo "Value found for  [$node_value]"


