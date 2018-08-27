# Script for batch organizing photos

#!/usr/bin/env bash
set -euo pipefail

cd ~/Downloads

count=0;
for file in *; do
  new_name=img_$count.jpg
  mv $file $new_name
  echo "Renaming $file to $new_name..."
  ((count++))
done

