#!/bin/bash

SRC_DIR="$1"
DEST_DIR="$2"
EXCLUDE_PATTERN="(\.git|\.swp$|~$|4913|\.dvc|venv)"
EXCLUDES=""
REVERSE_TRIGGER_FILE="rs.flag"



LAST_SYNC=0

should_sync() {
    NOW=$(date +%s) 
    (( NOW - LAST_SYNC >= 1 ))
}

should_reverse_sync() {
    local FLAG_PATH="$SRC_DIR/$REVERSE_TRIGGER_FILE"
    if [[ -f "$FLAG_PATH" ]]; then
        rm -f "$FLAG_PATH"
        LAST_SYNC=$NOW
        return 0
    fi
    return 1
}


sync_dirs() {
    local SRC="$1"
    local DST="$2"
    echo "↔ Syncing ($SRC → $DST)"
    rsync -avz --delete --exclude={venv,dvc/*,.dvc*,lightning_logs,__pycache__,cpython,storage,results,.pytest,cache,*.zarr,*.ckpt,*.pkl} "$SRC"/ "$DST"/
    LAST_SYNC=$(date +%s)
}


main() {
    inotifywait -m -r -e modify,create,delete,move --exclude "$EXCLUDE_PATTERN" "$SRC_DIR" --format '%w%f' | while read FILE
    do
        if should_reverse_sync; then
            sync_dirs "$DEST_DIR" "$SRC_DIR" 
        elif should_sync; then
            sync_dirs "$SRC_DIR" "$DEST_DIR" 
        fi
    done
}

main "$@"
