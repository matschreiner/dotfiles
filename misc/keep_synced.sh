#!/bin/bash

SRC_DIR="$1"
DEST_DIR="$2"
EXCLUDE_PATTERN="(\.git|\.swp$|~$|4913|\.dvc|venv)"
EXCLUDES="--exclude {venv,dvc/*,.dvc*,lightning_logs,__pycache__,cpython,storage,results,.pytest,cache,*.zarr,*.ckpt,*.pkl}"
REVERSE_TRIGGER_FILE="rs.flag"



LAST_SYNC=0
should_sync() {
    NOW=$(date +%s)
    (( NOW - LAST_SYNC >= 1 ))
}


sync_dirs() {
    local SRC="$1"
    local DST="$2"
    echo "↔ Syncing ($SRC → $DST)"
    rsync -avz --delete $EXCLUDES "$SRC"/ "$DST"/
    LAST_SYNC=$(date +%s)
}

check_reverse_trigger() {
    echo blabla
    echo $SRC_DIR/$REVERSE_TRIGGER_FILE
    if [[ -f $SRC_DIR/sync ]]; then
        echo "← Reverse sync triggered"
        sync_dirs "$DEST_DIR" "$SRC_DIR" &
        rm $SRC_DIR/$REVERSE_TRIGGER_FILE
        LAST_SYNC=$(date +%s)
    fi
}


main() {
    inotifywait -m -r -e modify,create,delete,move --exclude "$EXCLUDE_PATTERN" "$SRC_DIR" --format '%w%f' | while read FILE
    do
        check_reverse_trigger
        if should_sync; then
            sync_dirs "$SRC_DIR" "$DEST_DIR" &
        fi
    done
}


main "$@"
