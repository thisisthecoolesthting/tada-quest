# Tada Quest 🦉✨

**Safe home magic missions for kids.** Free, offline, no ads, no accounts, no tracking.

A Flutter Android app + static website teaching kids (6–8, 9–12; 4–6 with a
grown-up) twelve safe household magic tricks. Built from one shared content
source (`content/missions.json`).

This was adapted from a Codex build kit into a real, buildable project wired to
Ricky's system: Windows host for the Flutter build, Ubuntu VPS (Caddy) for the
website + privacy-policy URL, and the existing Google Play API deploy pipeline.

## Quick start (Flutter app)

> The Flutter app source lives in `app_flutter/lib`. The `android/` host project
> is partially scaffolded (custom `AndroidManifest.xml` with **no permissions**).
> To generate the remaining native host files the first time:

```bash
cd app_flutter
flutter create . --platforms=android,web --org com.tadaquest   # fills android/, web/, etc.
#   ^ keep the existing lib/, pubspec.yaml, and android/app/src/main/AndroidManifest.xml
flutter pub get
flutter test                      # JSON parse + age filter + safety checks
flutter run -d chrome             # web preview
flutter build appbundle --release # produces the .aab for Play
```

`flutter create .` will not overwrite your existing `lib/` or `pubspec.yaml`.
After it runs, re-apply the no-permission `AndroidManifest.xml` if Flutter
replaced it.

## Quick start (website)

```bash
cd site
python3 -m http.server 8080   # open http://localhost:8080
```

Deploy to the VPS: see `deploy/README.md`.

## Compliance highlights
- **No INTERNET permission** → Play Data Safety = "no data collected".
- All progress stored locally via `shared_preferences`.
- Grown-up gate (3-second hold) in front of the grown-up area.
- Banned-item safety test enforces no fire/knife/glass/chemical content.

## Repo map
| Path | What |
|---|---|
| `app_flutter/` | Flutter app (12 screens, age filter, local progress) |
| `site/` | Static no-tracking website |
| `content/missions.json` | 12 missions — single source of truth |
| `assets/` | SVG + Play Store PNGs (icon, feature graphic, screenshots) |
| `docs/` | Privacy policy, store listing, Play checklist, test plan |
| `deploy/` | Caddy config, VPS deploy + content sync, Play upload notes |

## Before publishing
1. Pick final name + package (`com.tadaquest.app` placeholder) — verify trademark.
2. Replace `hello@tadaquest.example` and privacy effective date.
3. Confirm the privacy URL is live on the VPS.
4. Build signed `.aab`, upload to internal track first.
