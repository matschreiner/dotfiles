#!/bin/bash
# Swap current workspace with target workspace number
# Usage: swap-workspace.sh <target_number>

TARGET="$1"
[ -z "$TARGET" ] && exit 1

# Get current workspace name
CURRENT=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused) | .name')

# Don't swap with self
[ "$CURRENT" = "$TARGET" ] && exit 0

# Check if target workspace exists
TARGET_EXISTS=$(i3-msg -t get_workspaces | jq -r ".[] | select(.name == \"$TARGET\") | .name")

if [ -n "$TARGET_EXISTS" ]; then
    # Target exists - do a swap using temp name (can't use __ prefix - reserved by i3)
    i3-msg "rename workspace \"$TARGET\" to \"SWAP_TEMP\""
    i3-msg "rename workspace \"$CURRENT\" to \"$TARGET\""
    i3-msg "rename workspace \"SWAP_TEMP\" to \"$CURRENT\""
else
    # Target doesn't exist - just rename
    i3-msg "rename workspace \"$CURRENT\" to \"$TARGET\""
fi
