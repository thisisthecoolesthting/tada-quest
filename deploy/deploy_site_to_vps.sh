#!/usr/bin/env bash
# Deploy the Tada Quest static site to the VPS behind Caddy.
#
# Host:   187.124.246.154 (root)  — see CREDENTIALS/CREDENTIALS-VAULT.txt
# Target: /var/www/tadaquest  (served by the tadaquest.caddy block)
#
# Usage:  ./deploy_site_to_vps.sh
# Requires: rsync + ssh access to the box.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VPS="root@187.124.246.154"
REMOTE="/var/www/tadaquest"

echo "→ Ensuring remote dir exists"
ssh "$VPS" "mkdir -p $REMOTE && mkdir -p /var/log/caddy"

echo "→ Uploading site/"
rsync -az --delete "$ROOT/site/" "$VPS:$REMOTE/"

echo "→ Installing Caddy block (idempotent)"
# Append the block only if the domain isn't already present.
ssh "$VPS" '
  if ! grep -q "tadaquest" /etc/caddy/Caddyfile; then
    cp /etc/caddy/Caddyfile /etc/caddy/Caddyfile.backup.$(date +%s)
    cat >> /etc/caddy/Caddyfile <<"EOF"

# --- Tada Quest (static) ---
tadaquest.app, www.tadaquest.app {
    encode gzip zstd
    root * /var/www/tadaquest
    file_server
    try_files {path} {path}.html {path}/ =404
    header { X-Content-Type-Options nosniff; Referrer-Policy no-referrer; -Server }
    log { output file /var/log/caddy/tadaquest.log }
}
EOF
    echo "  added tadaquest block"
  else
    echo "  tadaquest block already present — skipping"
  fi
'

echo "→ Validating + reloading Caddy"
ssh "$VPS" 'caddy validate --config /etc/caddy/Caddyfile --adapter caddyfile && caddy reload --config /etc/caddy/Caddyfile --adapter caddyfile'

echo "✓ Deployed. Privacy URL for Play Console: https://tadaquest.app/privacy.html"
echo "  (Point the domain's DNS A record at 187.124.246.154 first, then Caddy auto-issues TLS.)"
