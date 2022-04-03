#!/usr/bin/env bash
# Script for batch organizing photos
set -euo pipefail

NAME=${1:-img}

main() {
  create_new_dir || true
  rename_files || true
}

create_new_dir() {
  cd "$HOME"/Downloads
  initial_item_count=$(find . -maxdepth 1 -mindepth 1 -not -path '*/\.*' | wc -l)
  num_modified=0
  new_dir=$(date +"%Y%m%d")
  mkdir $new_dir
}

rename_files() {
  echo -e "\nNumber of items in Downloads: $initial_item_count"

  for file in *; do

    file_type=${file##*.}

    shopt -s nocasematch
    if [[ $file_type == 'JPEG'* ]] || [[ $file_type == 'JPG'* ]] || [[ $file_type == 'HEIC'* ]] || [[ $file_type == 'MOV'* ]]; then
      date_modified=$(date -r "$file" +%Y%m%d)
      new_name=2022_02_26_${NAME}-$RANDOM.${file_type}

      if [[ ! -e ~/Downloads/$new_dir/$new_name ]]; then
        ((num_modified++))
        echo "Renaming $file to $new_name..."
        mv -i "$file" "$new_dir"/"$new_name"  # -i prompt as a redundant safety check
      else
        echo "$new_name already exists. Skipping rename."
      fi
    shopt -u nocasematch
    else
      echo "$file is not a JPEG, HEIC, or MOV. Skipping rename."
      continue
    fi
  done

  echo -e "\\nModified $num_modified files\\n"
}

main "${@}"

# Considered commands:

# ls | sort -n        Sort numerically
# mv -vn              Move with no-clobber + verbose; exits 0
