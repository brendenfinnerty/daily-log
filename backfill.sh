#!/bin/bash

# Start and end dates (YYYY-MM-DD format)
START_DATE="2025-01-01"
END_DATE="2025-12-31"

current="$START_DATE"

while [[ "$current" < "$END_DATE" || "$current" == "$END_DATE" ]]; do
  # Random number of commits per day (0-3, so some days are blank)
  num_commits=$((RANDOM % 4))

  for ((i=0; i<num_commits; i++)); do
    # Random hour so they're not all at midnight
    hour=$((RANDOM % 14 + 8))
    date_str="${current}T${hour}:00:00"

    GIT_AUTHOR_DATE="$date_str" GIT_COMMITTER_DATE="$date_str" \
      git commit --allow-empty -m "update $current" --quiet
  done

  # Advance to next day (works on macOS)
  current=$(date -j -v+1d -f "%Y-%m-%d" "$current" "+%Y-%m-%d")
done