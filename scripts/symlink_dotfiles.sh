#!/bin/bash

SRC_DIR="$HOME/dotfiles/dotfiles"
DEST_DIR="$HOME"

for FILE in "$SRC_DIR"/*; do
    BASENAME=$(basename "$FILE")
    ln -s "$FILE" "$DEST_DIR/.$BASENAME"
    echo "Created symlink: $DEST_DIR/$BASENAME -> $FILE"
done
