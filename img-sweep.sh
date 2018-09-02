#!/usr/bin/env bash
# Script for batch organizing photos
set -euo pipefail

cd "$HOME"/Downloads
initial_item_count=$(ls | wc -l)
num_modified=0

echo "Number of items in Downloads: $initial_item_count"
mkdir "_renamed"

for file in *; do
  file_type=$(file -b "$file")

  if [[ $file_type == 'JPEG '* ]]; then
    date_modified=$(date -r "$file" +%Y%m%d)
    new_name=${date_modified}_img-$RANDOM.jpg

    if [[ ! -e ~/Downloads/_renamed/$new_name ]]; then
      ((num_modified++))
      echo "Renaming $file to $new_name..."
      mv -i "$file" _renamed/"$new_name"  # -i prompt as a redundant safety check
    else
      echo "$new_name already exists. Skipping rename."
    fi
  else
    echo "$file is not a JPEG. Skipping rename."
  fi
done

echo -e "\nModified $num_modified files\n"


# Considered commands:

# ls | sort -n        Sort numerically
# mv -vn              Move with no-clobber + verbose; exits 0
