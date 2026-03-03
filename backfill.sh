#!/bin/bash

START_DATE="2024-01-01"
END_DATE="2024-12-31"

current="$START_DATE"

while [[ "$current" < "$END_DATE" || "$current" == "$END_DATE" ]]; do
  # 40% chance of skipping the day entirely
  if [ $((RANDOM % 10)) -lt 4 ]; then
    current=$(date -j -v+1d -f "%Y-%m-%d" "$current" "+%Y-%m-%d")
    continue
  fi

  # When active, usually just 1 commit
  num_commits=$((RANDOM % 2 + 1))

  for ((i=0; i<num_commits; i++)); do
    hour=$((RANDOM % 14 + 8))
    date_str="${current}T${hour}:00:00"

    GIT_AUTHOR_DATE="$date_str" GIT_COMMITTER_DATE="$date_str" \
      git commit --allow-empty -m "update $current" --quiet
  done

  current=$(date -j -v+1d -f "%Y-%m-%d" "$current" "+%Y-%m-%d")
done