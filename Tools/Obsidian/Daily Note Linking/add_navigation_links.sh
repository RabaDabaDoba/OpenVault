#!/bin/bash

# add_navigation_links.sh - Adds prevDay and nextDay YAML properties in markdown files
# Version: 1.0.0
# Author: Robin Dahlkvist 
# License: MIT

# Define the folder containing your markdown files
BLOG_FOLDER="/mnt/c/Users/robdah/Documents/Repository/obsidian-vault/700DagligaAnteckningar"

# Get the list of files in chronological order
FILES=($(ls "$BLOG_FOLDER"/*.md | sort))

for ((i = 0; i < ${#FILES[@]}; i++)); do
  FILE="${FILES[i]}"
  FILE_DATE=$(basename "$FILE" .md)

  PREV_DAY=""
  NEXT_DAY=""

  if [[ $i -gt 0 ]]; then
    PREV_DAY=$(basename "${FILES[i-1]}" .md)
  fi

  if [[ $i -lt $((${#FILES[@]}-1)) ]]; then
    NEXT_DAY=$(basename "${FILES[i+1]}" .md)
  fi

  # Define the YAML properties to add
  YAML_PREV="prevDay: \"[[${PREV_DAY}]]\""
  YAML_NEXT="nextDay: \"[[${NEXT_DAY}]]\""

  # Check if the file already has YAML front matter
  if grep -q "^---" "$FILE"; then
    # Insert the prevDay and nextDay properties before the last ---
    sed -i "/^---/ {h; r /dev/stdin
      g; }" "$FILE" <<< "${YAML_PREV}"$'\n'"${YAML_NEXT}"
  else
    # Add new YAML front matter
    echo -e "---\n${YAML_PREV}\n${YAML_NEXT}\n---\n$(cat "$FILE")" > "$FILE"
  fi
done

echo "Navigation links added to all files in $BLOG_FOLDER"
