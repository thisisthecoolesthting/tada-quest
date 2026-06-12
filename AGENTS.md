# AGENTS.md — Tada Quest

You are working on **Tada Quest**, a free, offline, privacy-first kids app for
safe home magic missions. This repo was adapted from a Codex build kit to fit
Ricky's build system (Windows host + Ubuntu VPS at 187.124.246.154, verified
Google Play account reasner196@gmail.com).

## Non-negotiable rules
- Protect children's privacy. No accounts, names, photos, mic, camera, location,
  contacts, or device identifiers.
- No ads, analytics, social sharing, open chat, uploads, or third-party SDKs.
- App works **fully offline** from `app_flutter/assets/content/missions.json`
  and bundled SVGs. **Do not add the INTERNET permission.**
- No tricks with fire, knives, glass, chemicals, medicine, or choking hazards.
- Small-object / water / soap missions are age-gated and labeled "Grown-up helps".
- External links live behind the grown-up gate and are shown as **plain text**
  (no link-opening), so no INTERNET permission is needed.
- Large, accessible, bright UI. Run `dart format`, `flutter analyze`, `flutter test`
  before declaring done.

## Tech
- **App:** Flutter (Android + web). go_router, flutter_riverpod,
  shared_preferences, flutter_svg. Content from JSON, art from SVG.
- **Site:** Static HTML/CSS/JS in `/site`, no tracking. Reads `missions.json`.
  Deploys to the VPS behind Caddy (see `deploy/`).

## Layout
```
tada_quest/
  app_flutter/   Flutter app (this is the real code, not a spec)
  site/          Static website (Home/Missions/Safety/Parents/Privacy/Contact)
  content/       missions.json (source of truth; copied into app + site)
  assets/        svg + png masters (icon, feature graphic, screenshots)
  docs/          privacy policy, store listing, Play checklist, test plan
  deploy/        Caddy block + VPS deploy script + Play upload notes
```

## Definition of done
- `flutter test` passes (JSON parse + age-filter + safety invariants).
- `flutter build appbundle --release` produces an `.aab`.
- Site opens locally and after VPS deploy; privacy URL is live (Play requires it).
- Play docs filled with real package name, contact email, privacy date.

## Content edits
`content/missions.json` is the single source. After editing it, re-run
`deploy/sync_content.sh` to copy it into `app_flutter/assets/content/` and
`site/` so app and website stay in sync.
