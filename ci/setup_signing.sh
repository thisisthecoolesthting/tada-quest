#!/usr/bin/env bash
# Sets up release signing for the Flutter Android build in CI.
# Expects these env vars (from GitHub Actions secrets):
#   KEYSTORE_B64, STORE_PASSWORD, KEY_PASSWORD, KEY_ALIAS
# Run from the app_flutter/ directory AFTER `flutter create .`.
set -euo pipefail

if [ -z "${KEYSTORE_B64:-}" ]; then
  echo "ERROR: KEYSTORE_B64 not set"; exit 1
fi

echo "$KEYSTORE_B64" | base64 -d > android/app/upload-keystore.jks
echo "Wrote keystore ($(wc -c < android/app/upload-keystore.jks) bytes)"

cat > android/key.properties <<EOF
storePassword=${STORE_PASSWORD}
keyPassword=${KEY_PASSWORD}
keyAlias=${KEY_ALIAS}
storeFile=upload-keystore.jks
EOF
echo "Wrote android/key.properties"

# Patch app/build.gradle (Groovy) or build.gradle.kts (Kotlin DSL).
# This script's own directory (repo-root/ci), regardless of caller cwd.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
python3 "$SCRIPT_DIR/patch_gradle_signing.py"
