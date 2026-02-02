#!/bin/bash
# Auto Deploy Script
set -e  # Exit on error

echo "🚀 Starting Auto Deployment..."
echo "================================"

# Configuration
BACKUP_DIR="backups/$(date +%Y%m%d_%H%M%S)"
REMOTE_SERVER="user@example.com:/var/www/projects/"

# Create backup
mkdir -p "$BACKUP_DIR"
cp *.sh "$BACKUP_DIR/" 2>/dev/null || true
cp *.prog "$BACKUP_DIR/" 2>/dev/null || true
echo "✓ Backup created: $BACKUP_DIR"

# Run tests
echo "Running tests..."
for test_file in test_*.sh; do
    if [ -f "$test_file" ]; then
        echo "Testing with $test_file..."
        bash "$test_file"
    fi
done

# Deploy (example - customize this)
echo "Deploying..."
# scp -r *.sh "$REMOTE_SERVER"  # Uncomment for real deployment

echo "✅ Deployment completed successfully!"
echo "Time: $(date)"
