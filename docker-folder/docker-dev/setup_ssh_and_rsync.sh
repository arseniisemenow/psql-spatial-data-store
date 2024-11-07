#!/bin/bash

# Variables
CONTAINER_USER="user"
CONTAINER_HOST="localhost"
CONTAINER_PORT="2222"
RSYNC_SOURCE="db_data"
RSYNC_DESTINATION="/tmp/tmp.2S9t9vjknZ/docker-folder/docker-dev/db_data"
SSH_KEY="$HOME/.ssh/id_ed25519"
RSYNC_FILELIST="/private/var/folders/zz/zyxvpxvq6csfxvn_n003wj0400z481/T/fileList.txt"

# Generate SSH key if it doesn't already exist
if [ ! -f "$SSH_KEY" ]; then
  echo "Generating SSH key..."
  ssh-keygen -t ed25519 -f "$SSH_KEY" -N "" -C "generated_key"
fi

# Remove old host key from known_hosts to avoid "REMOTE HOST IDENTIFICATION HAS CHANGED" error
echo "Clearing old host key entry..."
ssh-keygen -R "[$CONTAINER_HOST]:$CONTAINER_PORT"

# Copy SSH public key to the container
echo "Copying SSH public key to container..."
ssh-copy-id -i "$SSH_KEY.pub" -p "$CONTAINER_PORT" "$CONTAINER_USER@$CONTAINER_HOST"

# Run rsync command
echo "Starting rsync..."
rsync -zar -v -e "ssh -p $CONTAINER_PORT" --files-from="$RSYNC_FILELIST" \
  --exclude=.svn --exclude=.cvs --exclude=.idea --exclude=.DS_Store \
  --exclude=.git --exclude=.hg --exclude=*.hprof --exclude=*.pyc \
  --exclude=../../../cmake-build-debug-remote-host "$RSYNC_SOURCE" \
  "$CONTAINER_USER@$CONTAINER_HOST:$RSYNC_DESTINATION"

echo "Rsync completed successfully."
