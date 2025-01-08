---
title: README
created: 2025-01-08 15:16
modified: 2025-01-08 15:09
type: wiki
---
# Obsidian Task Emoji to Dataview Migration Script

Since the Obsidian-Tasks plugin does not have support for transforming between the two formats I created a script that does it for you.

This repository contains a Bash script that automates the migration of task formatting in an Obsidian vault from emoji-based syntax to a format compatible with the **Dataview** plugin. 

## Features

- Transforms common task metadata represented by emojis into Dataview field syntax.
- Supports creation dates, scheduling, priorities, completion dates, and more.
- Works on all markdown (`.md`) files within the specified Obsidian vault.
- Efficient single-pass processing for better performance.

### Supported Transformations

| Emoji Symbol | Field Converted To          | Example Transformation |
|--------------|-----------------------------|-----------------------|
| ➕ `YYYY-MM-DD`  | `[created:: YYYY-MM-DD]`    | `➕ 2025-01-08` → `[created:: 2025-01-08]` |
| ⏳ `YYYY-MM-DD`  | `[scheduled:: YYYY-MM-DD]`  | `⏳ 2025-01-08` → `[scheduled:: 2025-01-08]` |
| 🛫 `YYYY-MM-DD`  | `[start:: YYYY-MM-DD]`      | `🛫 2025-01-08` → `[start:: 2025-01-08]` |
| 📅 `YYYY-MM-DD`  | `[due:: YYYY-MM-DD]`        | `📅 2025-01-08` → `[due:: 2025-01-08]` |
| ✅ `YYYY-MM-DD`  | `[completion:: YYYY-MM-DD]` | `✅ 2025-01-08` → `[completion:: 2025-01-08]` |
| ❌ `YYYY-MM-DD`  | `[cancelled:: YYYY-MM-DD]`  | `❌ 2025-01-08` → `[cancelled:: 2025-01-08]` |
| ⏬              | `[priority:: lowest]`       | ⏬ → `[priority:: lowest]` |
| 🔽              | `[priority:: low]`          | 🔽 → `[priority:: low]` |
| 🔼              | `[priority:: medium]`       | 🔼 → `[priority:: medium]` |
| ⏫              | `[priority:: high]`         | ⏫ → `[priority:: high]` |
| 🔺              | `[priority:: highest]`      | 🔺 → `[priority:: highest]` |
| 🏁 keep         | `[onCompletion:: keep]`    | 🏁 keep → `[onCompletion:: keep]` |
| 🏁 delete       | `[onCompletion:: delete]`  | 🏁 delete → `[onCompletion:: delete]` |
| 🔁 `repeat` 🏁 delete | `[repeat:: repeat] [onCompletion:: delete]` | 🔁 weekly 🏁 delete → `[repeat:: weekly] [onCompletion:: delete]` |
| 🆔 `id`         | `[id:: id]`                | 🆔 1234 → `[id:: 1234]` |
| ⛔ `dependencies` | `[dependsOn:: dependencies]` | ⛔ 5678 → `[dependsOn:: 5678]` |

### Usage


> [!warning] Warning
> Please, back up your files before doing this, just in case something would break =).


1. Clone this repository.
2. Place the script in your system.
3. Edit the script and replace `/path/to/your/vault` with the path to your Obsidian vault.
4. Make the script executable:
```bash
   chmod +x migrate_tasks.sh
```

Run the script:

```bash
./migrate_tasks.sh
```

## Notes
Ensure you have a backup of your vault before running this script.
The script processes all .md files and performs inline transformations.

## Contributing
Feel free to open an issue or submit a pull request if you find any bugs or want to suggest improvements.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

