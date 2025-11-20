#!/bin/bash
set -e

# Steamcmd intermittently throws a "Missing configuration" error when trying to update TF2.
# This retry mechanism is a temporary solution to try to workaround that problem.

max_retries=3
retry_count=0

while [ $retry_count -lt $max_retries ]; do
  if steamcmd +runscript "$HOME/tf2.txt"; then
    exit 0
  fi
  
  retry_count=$((retry_count + 1))
  if [ $retry_count -lt $max_retries ]; then
    echo "Steamcmd failed. Retrying ($retry_count/$max_retries)..."
    sleep 5
  fi
done

echo "Failed to install TF2 after $max_retries attempts"
exit 1
