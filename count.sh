#!/usr/bin/env bash

# Usage: ./count.sh /path/to/folder
# Where /path/to/folder contains multiple .tfstate files

if [ -z "$1" ]; then
  echo "Usage: $0 <folder_with_tfstate_files>"
  exit 1
fi

FOLDER="$1"
TOTAL=0

for STATEFILE in "$FOLDER"/*.tfstate; do
  # Skip if no *.tfstate files exist
  [ -f "$STATEFILE" ] || continue
  
  COUNT=$(jq '[
    .resources[]?
    | select(.mode == "managed")
    | select(.type == "terraform_data" or .type == "null_resource" | not)
    | .instances
    | flatten[]
  ] | length' "$STATEFILE")
  
  TOTAL=$((TOTAL + COUNT))
done

echo "Total resources across all state files: $TOTAL"
