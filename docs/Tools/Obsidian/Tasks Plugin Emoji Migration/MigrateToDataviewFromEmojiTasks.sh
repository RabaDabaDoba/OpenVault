#!/bin/bash


# Obsidian Task Emoji to Dataview Migration Script
# Version: 1.0.0
# Author: Robin Dahlkvist (https://github.com/RabaDabaDoba)
# License: MIT
# 
# Description:
# This script migrates task metadata in Obsidian markdown files from emoji-based format to a structured Dataview-compatible format.
# It processes all .md files within the specified Obsidian vault directory and replaces emoji markers with Dataview field syntax.
# 
# Usage:
# 1. Edit the VAULT_PATH variable to point to your Obsidian vault.
# 2. Ensure you have a backup of your vault before running the script.
# 3. Make the script executable with `chmod +x migrate_tasks.sh`.
# 4. Run the script: `./migrate_tasks.sh`.
# 
# Version History:
# 1.0.0 - Initial release with support for all primary emoji to Dataview transformations.
# 
# Limitations:
# - This script assumes a standardized emoji-to-date or emoji-to-field syntax.
# - Irregular or nested task structures may require manual adjustments post-migration.
# 
# Known Issues:
# - None reported as of this release.


# Directory containing markdown files
vault_path=""  # Change this to your vault's path

find "$vault_path" -type f -name "*.md" -exec sed -i '
  s/➕ \([0-9-]*\)/[created:: \1]/g;
  s/⏳ \([0-9-]*\)/[scheduled:: \1]/g;
  s/🛫 \([0-9-]*\)/[start:: \1]/g;
  s/📅 \([0-9-]*\)/[due:: \1]/g;
  s/✅ \([0-9-]*\)/[completion:: \1]/g;
  s/❌ \([0-9-]*\)/[cancelled:: \1]/g;
  s/⏬/[priority:: lowest]/g;
  s/🔽/[priority:: low]/g;
  s/🔼/[priority:: medium]/g;
  s/⏫/[priority:: high]/g;
  s/🔺/[priority:: highest]/g;
  s/🏁 keep/[onCompletion:: keep]/g;
  s/🏁 delete/[onCompletion:: delete]/g;
  s/🔁 \(.*\) 🏁 delete/[repeat:: \1] [onCompletion:: delete]/g;
  s/🆔 \([a-zA-Z0-9]*\)/[id:: \1]/g;
  s/⛔ \([a-zA-Z0-9,]*\)/[dependsOn:: \1]/g
' {} +

echo "Task format migration complete!"
