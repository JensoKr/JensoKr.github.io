#!/bin/bash

directory="/Users/jens/Library/Mobile Documents/com~apple~CloudDocs/Privates/GitPages/imgs/fotography_stack"
cd "$directory" || exit

counter=1

file_exists() {
  local file="$1"
  [ -e "$file" ]
}

# Loop through each file in the directory
for file in *; do
  # Check if it's a regular file (not a directory)
  if [ -f "$file" ]; then
    if [ "$file" != "rename.sh" ]; then
        # Get the file extension (e.g., .jpg)
        extension="${file##*.}"
        
        # Rename the file to the desired format
        new_name=$(printf "%03d.$extension" "$counter")
        if [ "$file" != "$new_name" ]; then
            while file_exists "$new_name"; do
                ((counter++))
                new_name=$(printf "%03d.$extension" "$counter")
            done
            echo " renamed $file to $new_name      counter at $counter" 
            mv "$file" "$new_name"
        fi
        ((counter++))

    fi
  fi
done

echo "Files renamed successfully."
