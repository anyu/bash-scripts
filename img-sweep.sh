#!/usr/bin/env bash
# Script for batch organizing photos
set -euo pipefail

cd ~/Downloads

mkdir -p "renamed"

for file in *; do
  file_type=$(file -b "$file")

  if [[ $file_type == 'JPEG '* ]]; then
    date_modified=$(date -r "$file" +%Y%m%d)
    new_name=${date_modified}_img-$RANDOM.jpg

    if [[ ! -e ~/Downloads/renamed/$new_name ]]; then
      echo "Renaming $file to $new_name..."
      mv -i "$file" renamed/"$new_name"  # -i prompt as a redundant safety check
    else
      echo "$new_name already exists. Skipping rename."
    fi
  else
    echo "$file is not a JPEG. Skipping rename."
  fi
done


# Considered commands:

# ls | sort -n        Sort numerically
# mv -vn              Move with no-clobber + verbose; exits 0
