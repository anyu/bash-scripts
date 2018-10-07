#!/usr/bin/env bash
# Script for batch organizing photos
set -euo pipefail

NAME=${1:-img}

cd "$HOME"/Downloads
initial_item_count=$(find . -maxdepth 1 -mindepth 1 -not -path '*/\.*' | wc -l)
num_modified=0
new_dir=$(date +"%Y%m%d")
mkdir $new_dir

echo "Number of items in Downloads: $initial_item_count"

for file in *; do
  file_type=$(file -b "$file")

  if [[ $file_type == 'JPEG '* ]]; then
    date_modified=$(date -r "$file" +%Y%m%d)
    new_name=${date_modified}_${NAME}-$RANDOM.jpg

    if [[ ! -e ~/Downloads/$new_dir/$new_name ]]; then
      ((num_modified++))
      echo "Renaming $file to $new_name..."
      mv -i "$file" "$new_dir"/"$new_name"  # -i prompt as a redundant safety check
    else
      echo "$new_name already exists. Skipping rename."
    fi
  else
    echo "$file is not a JPEG. Skipping rename."
  fi
done

echo -e "\\nModified $num_modified files\\n"


# Considered commands:

# ls | sort -n        Sort numerically
# mv -vn              Move with no-clobber + verbose; exits 0
