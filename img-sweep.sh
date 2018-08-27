# Script for batch organizing photos

#!/usr/bin/env bash
set -euo pipefail

cd ~/Downloads

count=0;
for file in *; do
  date_modified=$(date -r $file +%Y%m%d)
  new_name=${date_modified}_img-$count.jpg
  mv $file $new_name

  echo "Renaming $file to $new_name..."
  ((count++))
done

# Sort numerically
# ls | sort -n
