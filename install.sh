#!/usr/bin/env bash
# Install footage-tools for the current user (symlinks, so `git pull` updates it in place).
#   ./install.sh            install the new "Footage tools…" right-click entry
#   ./install.sh --replace-legacy
#                           also point ~/.local/bin/level-dialogue at this repo's copy and
#                           remove the old "Level dialogue" submenu (backed up first)
set -euo pipefail
REPO=$(cd "$(dirname "$0")" && pwd)
BIN="$HOME/.local/bin"
MENUS="${XDG_DATA_HOME:-$HOME/.local/share}/kio/servicemenus"
BACKUP="${XDG_DATA_HOME:-$HOME/.local/share}/footage-tools-backup"
mkdir -p "$BIN" "$MENUS" "$BACKUP"

ln -sfn "$REPO/bin/footage-tools" "$BIN/footage-tools"
install -m 755 "$REPO/servicemenus/footage-tools.desktop" "$MENUS/footage-tools.desktop"
echo "Installed: right-click video/audio in Dolphin → Footage tools…"

if [[ "${1:-}" == "--replace-legacy" ]]; then
  for f in "$BIN/level-dialogue" "$MENUS/level-dialogue.desktop"; do
    [[ -e "$f" && ! -L "$f" ]] && cp -a "$f" "$BACKUP/$(basename "$f").$(date +%Y%m%d-%H%M%S)"
  done
  ln -sfn "$REPO/bin/level-dialogue" "$BIN/level-dialogue"
  rm -f "$MENUS/level-dialogue.desktop"
  echo "Old 'Level dialogue' submenu removed; backups are in $BACKUP"
fi
