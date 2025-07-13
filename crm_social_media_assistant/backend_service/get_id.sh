#!/bin/bash

# A simple script to find the numeric ID for a given Twitter username.
# It loads the Bearer Token from the .env file in the same directory.

# --- Configuration ---
USERNAME_TO_FIND=$1
# --- End Configuration ---

# Check if a username was provided
if [ -z "$USERNAME_TO_FIND" ]; then
  echo "ERROR: You must provide a username to find."
  echo "Usage: ./get_id.sh <TwitterUsernameWithoutAt>"
  echo "Example: ./get_id.sh HackathonCrmT"
  exit 1
fi

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

echo "--- Looking up ID for user: $USERNAME_TO_FIND ---"
echo "--- Using Bearer Token starting with: ${TWITTER_BEARER_TOKEN:0:4}... ---"
echo ""

# Run the curl command
curl "https://api.twitter.com/2/users/by/username/$USERNAME_TO_FIND" -H "Authorization: Bearer $TWITTER_BEARER_TOKEN"

echo ""
echo ""
echo "--- Script finished. Copy the numeric 'id' from the JSON response above. ---"