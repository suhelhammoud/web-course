#!/bin/bash

# Check if exactly two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <config_file> <doc_file>"
    exit 1
fi

# Assign arguments to variables
config_file=$1
doc_file=$2

# Call the presenterm command with the provided arguments
presenterm --config-file "$config_file" "$doc_file"