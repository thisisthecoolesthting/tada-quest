#!/usr/bin/env bash
# Sync the single source of truth (content/missions.json) into the app and site.
# Run from repo root after editing content/missions.json.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

cp "$ROOT/content/missions.json" "$ROOT/app_flutter/assets/content/missions.json"
cp "$ROOT/content/missions.json" "$ROOT/site/missions.json"

# Keep SVGs mirrored too (app + site both render them)
mkdir -p "$ROOT/app_flutter/assets/svg" "$ROOT/site/assets/svg"
cp -r "$ROOT/assets/svg/." "$ROOT/app_flutter/assets/svg/"
cp -r "$ROOT/assets/svg/." "$ROOT/site/assets/svg/"

echo "✓ Synced missions.json + svg into app_flutter/ and site/"
