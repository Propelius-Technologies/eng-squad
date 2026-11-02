#!/usr/bin/env bash
# Installs the eng-squad skill for Claude Code, Cursor and Codex.
#   ./install.sh                     -> global install (home directory)
#   ./install.sh --project <path>    -> install into a single repository
set -euo pipefail

SKILL_NAME="eng-squad"
SRC="$(cd "$(dirname "$0")" && pwd)/skills/$SKILL_NAME"

if [[ ! -f "$SRC/SKILL.md" ]]; then
  echo "error: $SRC/SKILL.md not found. Run this from the repo root." >&2
  exit 1
fi

if [[ "${1:-}" == "--project" ]]; then
  BASE="${2:?usage: ./install.sh --project <path>}"
  BASE="$(cd "$BASE" && pwd)"
  echo "Installing into project: $BASE"
else
  BASE="$HOME"
  echo "Installing globally into: $BASE"
fi

# Claude Code and Codex. Cursor also reads both of these folders.
TARGETS=("$BASE/.claude/skills" "$BASE/.codex/skills")

for dir in "${TARGETS[@]}"; do
  dest="$dir/$SKILL_NAME"
  if [[ -e "$dest" ]]; then
    echo "  updating  $dest"
    rm -rf "$dest"
  else
    echo "  installing $dest"
  fi
  mkdir -p "$dir"
  cp -R "$SRC" "$dest"
done

echo "Done. Restart Claude Code / Cursor / Codex to load the skill."
