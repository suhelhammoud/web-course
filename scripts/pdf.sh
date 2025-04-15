#!/bin/bash

# Check if exactly three arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <in_file> <out_dir> <config_file>"
    exit 1
fi

# Assign arguments to variables
in_file=$1
out_dir=$2
config_file=$3

# Check if in_file exists and is a file
if [ ! -f "$in_file" ]; then
    echo "Error: Input file '$in_file' does not exist or is not a file."
    exit 1
fi

# Check if the input file has .md extension
if [[ "$in_file" != *.md ]]; then
    echo "Error: Input file '$in_file' is not a Markdown (.md) file."
    exit 1
fi

# Check if out_dir exists, if not create it
if [ ! -d "$out_dir" ]; then
    echo "Output directory '$out_dir' does not exist. Creating it..."
    mkdir -p "$out_dir"
fi

# Check if config_file exists
if [ ! -f "$config_file" ]; then
    echo "Error: Config file '$config_file' does not exist."
    exit 1
fi

echo "Processing '$in_file'..."

# Get the base name of the file (without path)
base_name=$(basename "$in_file" .md)
echo "base_name: $base_name"

# Define the output file path
output_file="$out_dir/$base_name.pdf"
echo "output_file: $output_file"

# Run the presenterm command
echo "Processing '$in_file' -> '$output_file'..."
presenterm --config-file "$config_file" --export-pdf "$in_file"

# Check if the command succeeded
if [ $? -eq 0 ]; then
    echo "Successfully created pdf of '$in_file'."
else
    echo "Error: Failed to create pdf for '$in_file'."
    exit 1
fi

pdf_name=$(dirname "$in_file")/$base_name.pdf
echo "pdf_name: $pdf_name"

echo "Moving '$pdf_name' to '$output_file'..."
mv "$pdf_name" "$output_file"

# Check if the command succeeded
if [ $? -eq 0 ]; then
    echo "Successfully moved '$pdf_name' to '$output_file'."
else
    echo "Error: Failed to move '$pdf_name' to '$output_file'."
    exit 1
fi

echo "PDF created successfully at '$output_file'."