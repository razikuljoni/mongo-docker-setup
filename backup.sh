#!/bin/bash

# MongoDB Docker Backup Script
# Usage: ./backup.sh [backup-name]

BACKUP_DIR="./backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="${1:-mongodb_backup_${TIMESTAMP}}"

echo "================================================"
echo "MongoDB Backup Script"
echo "================================================"
echo ""

# Create backup directory
mkdir -p "$BACKUP_DIR"

echo "[1/3] Creating backup: $BACKUP_NAME"
echo ""

# Backup using mongodump
docker exec mongodb mongodump \
    --authenticationDatabase admin \
    --username admin \
    --password changeme123 \
    --out "/tmp/$BACKUP_NAME"

if [ $? -eq 0 ]; then
    echo "[2/3] Copying backup to host..."
    docker cp "mongodb:/tmp/$BACKUP_NAME" "$BACKUP_DIR/"

    echo "[3/3] Cleaning up temporary files..."
    docker exec mongodb rm -rf "/tmp/$BACKUP_NAME"

    echo ""
    echo "================================================"
    echo "✓ Backup completed successfully!"
    echo "================================================"
    echo ""
    echo "Location: $BACKUP_DIR/$BACKUP_NAME"
    echo ""
    ls -lh "$BACKUP_DIR/"
else
    echo ""
    echo "✗ Backup failed!"
    exit 1
fi
