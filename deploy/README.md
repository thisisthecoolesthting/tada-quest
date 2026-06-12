# Deploy — Tada Quest

## Website → VPS (Caddy)

The site is **static**, so it does NOT need a PM2 process or a port like the
Next.js storefronts. Caddy serves the files directly with `file_server`.

1. Register a domain (e.g. `tadaquest.app`) and point its A record at
   `187.124.246.154`.
2. From repo root:
   ```bash
   bash deploy/deploy_site_to_vps.sh
   ```
   This rsyncs `site/` to `/var/www/tadaquest`, appends the Caddy block (backing
   up the Caddyfile first), validates, and reloads. Caddy auto-issues TLS.
3. Verify: `https://tadaquest.app` and `https://tadaquest.app/privacy.html`.
   The privacy URL is what you paste into Google Play Console.

> Caddyfile lives at `/etc/caddy/Caddyfile` on the box. The deploy script is
> idempotent — it won't double-add the block. See `KNOWLEDGE/VPS-INFRASTRUCTURE.md`
> for the full Caddy + recovery notes.

## App → Google Play (.aab)

Your `PICKIT_KIDS_GAME_DEPLOYMENT_WORKFLOW.md` already documents the Play API
pipeline (verified account reasner196@gmail.com, `deploy_to_play_store.py`).
Tada Quest reuses it — only the package name and AAB path change.

1. Build the bundle:
   ```bash
   cd app_flutter
   flutter build appbundle --release
   # → build/app/outputs/bundle/release/app-release.aab
   ```
2. Configure signing (`android/key.properties` + `build.gradle`) per the PicKit
   workflow Phase 3. Keep `targetSdk 36` (Android 16) for 2026 compliance.
3. Upload to the **internal** track first:
   ```bash
   python deploy_to_play_store.py \
     app_flutter/build/app/outputs/bundle/release/app-release.aab
   ```
   (Set `PACKAGE_NAME = "com.tadaquest.app"` in the script.)
4. Complete Data Safety = "no data collected" and Target Audience = 6–8 / 9–12.
5. Test from the internal track, then promote to production.

## Content updates
Edit `content/missions.json`, then:
```bash
bash deploy/sync_content.sh        # mirror into app + site
bash deploy/deploy_site_to_vps.sh  # push site
# rebuild + re-upload the app for in-app changes
```
