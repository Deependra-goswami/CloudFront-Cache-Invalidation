#!/bin/bash

# File containing CloudFront Distribution IDs, one per line
distribution_ids_file="distribution_ids.txt"

# Check if the file exists
if [ ! -f "$distribution_ids_file" ]; then
    echo "Distribution IDs file not found: $distribution_ids_file"
    exit 1
fi

# Read distribution IDs from the file into an array
IFS=$'\n' read -d '' -r -a distribution_ids < "$distribution_ids_file"

# Loop through each distribution ID and perform cache invalidation
for distribution_id in "${distribution_ids[@]}"
do
    # Create a unique invalidation path (you can customize this as needed)
    invalidation_path="/path/to/invalidate/$(date +'%Y%m%d%H%M%S')"

    # Perform cache invalidation for the specified distribution ID
    aws cloudfront create-invalidation \
        --distribution-id "$distribution_id" \
        --paths "$invalidation_path"

    echo "Cache invalidation initiated for Distribution ID: $distribution_id"
done
