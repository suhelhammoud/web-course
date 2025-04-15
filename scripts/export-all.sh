#!/bin/bash

# Check if exactly three arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <in_dir> <out_dir> <config_file>"
    exit 1
fi

# Assign arguments to variables
in_dir=$1
out_dir=$2
config_file=$3

# Check if in_dir exists and is a directory
if [ ! -d "$in_dir" ]; then
    echo "Error: Input directory '$in_dir' does not exist or is not a directory."
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

echo "enter loop"
# Loop through all .md files in in_dir
for doc_file in "$in_dir"/*.md; do
    
    echo "Processing '$doc_file'..."

    # Check if any .md files exist
    if [ ! -f "$doc_file" ]; then
        echo "No .md files found in '$in_dir'."
        exit 0
    fi

    # Get the base name of the file (without path)
    base_name=$(basename "$doc_file" .md)
    echo "base_name: $base_name"

    # Define the output file path
    output_file="$out_dir/$base_name.pdf"
    echo "output_file: $output_file"

    # Run the presenterm command
    echo "Processing '$doc_file' -> '$output_file'..."
    presenterm --config-file "$config_file" --export-pdf "$doc_file"

    # Check if the command succeeded
    if [ $? -eq 0 ]; then
        echo "Successfully created pdf of'$doc_file'."
    else
        echo "Error: Failed to create pdf for '$doc_file'."
    fi

    pdf_name=$in_dir/$base_name.pdf
    echo "pdf_name: $pdf_name"

    echo "Moving '$pdf_name' to '$output_file'..."
    mv "$pdf_name" "$output_file"

    # Check if the command succeeded
    if [ $? -eq 0 ]; then
        echo "Successfully moved '$pdf_name' to '$output_file'."
    fi
done


echo "All pdfs created successfully."