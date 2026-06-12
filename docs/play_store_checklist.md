# Tada Quest — Google Play Submission Checklist (2026)

Adapted to Ricky's existing pipeline (`PICKIT_KIDS_GAME_DEPLOYMENT_WORKFLOW.md`,
verified account reasner196@gmail.com).

## Build compliance
- [ ] `targetSdk 36` (Android 16) — 2026 requirement
- [ ] `minSdk 26` (Android 8)
- [ ] Android App Bundle (`.aab`), not APK
- [ ] Signed with upload key; Play App Signing enabled
- [ ] `versionCode` incremented each upload
- [ ] **No INTERNET permission** in merged manifest
      (`flutter build appbundle` then check `AndroidManifest.xml`)
- [ ] No ad/analytics/social/sign-in SDKs in the dependency tree

## Data Safety form
| Question | Answer |
|---|---|
| Does your app collect or share user data? | **No** |
| Personal info / location / photos / audio / files | None |
| Data encrypted in transit | N/A (nothing leaves device) |
| Users can request data deletion | N/A; in-app "Reset progress" clears local data |

## Target audience & content
- [ ] Target age groups: **6–8** and **9–12**
- [ ] App is part of the **Designed for Families** / Teacher-approved track? (optional)
- [ ] Content rating questionnaire (IARC) completed truthfully → expect Everyone
- [ ] Ads declaration: **No ads**
- [ ] Privacy policy URL set: `https://thisisthecoolesthting.github.io/tada-quest/privacy.html`

## Store listing
- [ ] Title, short + full description (see `store_listing.md`)
- [ ] Icon 512×512, feature graphic 1024×500, 3+ screenshots uploaded
- [ ] Category: Education · Free · All countries (or chosen set)

## Pre-publish replacements
- [ ] Final app name + package name (verify trademark/store conflict)
- [ ] Replace `hello@tadaquest.example` with a real contact email
- [ ] Replace privacy policy effective date
- [ ] Confirm privacy URL is live (HTTPS) on the VPS

## Release flow
1. `flutter build appbundle --release`
2. Upload to **internal testing** track (via `deploy_to_play_store.py` or Console)
3. Install from internal track on a real Android 8+ device; run the test plan
4. Complete Data Safety + Target Audience + content rating
5. Promote to production; Google reviews (kids apps often take longer than 24h)

## Manual QA gate (must all pass — see test_plan.md)
- [ ] App works in airplane mode
- [ ] No screen asks for name/email/birthday/photo/voice/location/open text
- [ ] 4–6 path shows only starter missions
- [ ] Reset progress only reachable behind the grown-up gate
- [ ] Progress persists after restart
