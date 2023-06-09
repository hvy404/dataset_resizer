#!/bin/bash

# Function to display folder selection dialog
select_folder() {
    local folder_path
    folder_path=$(osascript -e 'tell application "SystemUIServer" to activate' -e 'POSIX path of (choose folder)')
    echo "$folder_path"
}

# Prompt the user to select the source folder
echo "Select the source folder:"
input_folder=$(select_folder)

# Check if the source folder was selected
if [[ -z "$input_folder" ]]; then
    echo "No source folder selected!"
    exit 1
fi

# Prompt the user to select the output folder
echo "Select the output folder:"
output_folder=$(select_folder)

# Check if the output folder was selected
if [[ -z "$output_folder" ]]; then
    echo "No output folder selected!"
    exit 1
fi

# Create the output folder if it doesn't exist
mkdir -p "$output_folder"

# Get the total number of image files in the input folder
total_files=$(find "$input_folder" -type f -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" | wc -l)
processed_files=0

# Loop through all image files in the input folder
for file in "$input_folder"/*; do
    # Check if the file is an image
    if [[ -f "$file" && $(file -b --mime-type "$file") =~ ^image/ ]]; then
        # Get the original dimensions of the image
        dimensions=$(identify -format "%wx%h" "$file")
        width=$(echo "$dimensions" | cut -d'x' -f1)
        height=$(echo "$dimensions" | cut -d'x' -f2)
        
        # Calculate the new dimensions while maintaining the aspect ratio
        if (( width > height )); then
            new_width=640
            new_height=$(( height * new_width / width ))
        else
            new_height=640
            new_width=$(( width * new_height / height ))
        fi
        
        # Generate the output file path
        output_file="${output_folder}/resized_${file##*/}"
        
        # Resize the image and add a black background if necessary
        convert "$file" -resize "${new_width}x${new_height}" -background black -gravity center -extent 640x640 "$output_file"
        
        echo "Resized: ${file##*/}"
        echo "Saved as: ${output_file##*/}"
        
        processed_files=$((processed_files + 1))
        percentage=$((processed_files * 100 / total_files))
        echo "Progress: ${processed_files}/${total_files} (${percentage}%)"
        echo
    fi
done

echo "Image resizing complete!"
