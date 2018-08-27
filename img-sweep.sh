#!/usr/bin/env bash
# Script for batch organizing photos

set -euo pipefail

cd ~/Downloads

mkdir -p "renamed"

count=0;

for file in *; do
  file_type=$(file -b "$file")

  if [[ $file_type == 'JPEG '* ]]; then
    date_modified=$(date -r "$file" +%Y%m%d)
    new_name=${date_modified}_img-$count.jpg
    mv "$file" renamed/"$new_name"

    echo "Renaming $file to $new_name..."
    ((count++))
  else
    echo "$file is not a JPEG. Skipping rename."
  fi
done

# Sort numerically
# ls | sort -n
