#!/bin/bash
# set -euo pipefail
PG_CONN=postgres://${DB_USERNAME}:${PGPASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}

function jq_parent_json() {
   jq -rs 'map(select(.metadata.parent_hash != null and .metadata.parent_height != null)) | "\(.[0].metadata.parent_height)-\(.[0].metadata.parent_hash).json"'
}

function jq_parent_hash() {
   jq -rs 'map(select(.metadata.parent_hash != null and .metadata.parent_height != null)) | .[0].metadata.parent_hash'
}

function populate_db() {
   mina-archive-blocks --precomputed --archive-uri "$MINA_NETWORK" "$DB_NAME" | jq -rs '"[BOOTSTRAP] Populated database with block: \(.[-1].message)"'
   rm "$DB_NAME"
}

function download_block() {
    echo "Downloading $MINA_NETWORK block"
    curl -sO "${PRECOMPUTED_BLOCKS_URL}/${MINA_NETWORK}"
}

HASH='map(select(.metadata.parent_hash != null and .metadata.parent_height != null)) | .[0].metadata.parent_hash'
# Bootstrap finds every missing state hash in the database and imports them from the o1labs bucket of .json blocks
function bootstrap() {
  echo "[BOOTSTRAP] Top 10 blocks before bootstrapping the archiveDB:"
  psql "${PG_CONN}" -c "SELECT state_hash,height FROM blocks ORDER BY height DESC LIMIT 10"
  echo "[BOOTSTRAP] Restoring blocks individually from ${PRECOMPUTED_BLOCKS_URL}..."

  until [[ "$PARENT" == "null" ]] ; do
    PARENT_FILE="${MINA_NETWORK}-$(mina-missing-blocks-auditor --archive-uri $PG_CONN | jq_parent_json)"
    download_block "${PARENT_FILE}"
    populate_db "$PG_CONN" "$PARENT_FILE"
    PARENT="$(mina-missing-blocks-auditor --archive-uri $PG_CONN | jq_parent_hash)"
  done

  echo "[BOOTSTRAP] Top 10 blocks in bootstrapped archiveDB:"
  psql "${PG_CONN}" -c "SELECT state_hash,height FROM blocks ORDER BY height DESC LIMIT 10"
  echo "[BOOTSTRAP] This rosetta node is synced with no missing blocks back to genesis!"

  echo "[BOOTSTRAP] Checking again in 60 minutes..."
  sleep 3000
}

# Wait until there is a block missing
PARENT=null
while true; do # Test once every 10 minutes forever, take an hour off when bootstrap completes
  PARENT="$(mina-missing-blocks-auditor --archive-uri $PG_CONN | jq_parent_hash)"
  echo "[BOOTSTRAP] $(mina-missing-blocks-auditor --archive-uri $PG_CONN | jq -rs .[].message)"
  [[ "$PARENT" != "null" ]] && echo "[BOOSTRAP] Some blocks are missing, moving to recovery logic..." && bootstrap
  sleep 600 # Wait for the daemon to catchup and start downloading new blocks
done
echo "[BOOTSTRAP] This rosetta node is synced with no missing blocks back to genesis!"
