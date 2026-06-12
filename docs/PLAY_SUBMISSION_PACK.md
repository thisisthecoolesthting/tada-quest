# Tada Quest — Play Console Submission Pack

Everything you need to create the app, upload the signed AAB, and get to a live
listing. Fields are paste-ready. Account: **reasner196@gmail.com** (verified).

---

## ⚠️ Read first: the 2026 timeline for personal accounts

Google now requires **personal developer accounts** (created after 13 Nov 2023) to
run a **closed test with ≥12 testers opted in for 14 continuous days** before the
app can be promoted to **Production**.

What that means for us:
- **Internal testing** (what we're doing first) is **instant** and lets you and up
  to 100 testers install the app today. It does NOT count toward the 14 days.
- To reach the **public Production** listing, you'll later run a **Closed test**
  with 12 testers for 14 days. We can start that clock anytime.
- So: install + test today via internal track → start the 12-tester closed test →
  14 days later, request production access → public listing.

(If your account is actually an **organization** account, the 12-tester/14-day rule
does not apply and you can go to production after review. Check Play Console →
Setup → "Account type".)

---

## Core identity (paste into Play Console)

| Field | Value |
|---|---|
| App name | **Tada Quest** |
| Package name | **com.tada.quest** (permanent) |
| Default language | English (United States) – en-US |
| App or game | **App** |
| Category | **Education** |
| Free or paid | **Free** |
| Contact email | **reasner196@gmail.com** |
| Privacy policy URL | **https://thisisthecoolesthting.github.io/tada-quest/privacy.html** |

---

## Store listing text

**Short description (≤80 chars):**
```
Safe, simple magic missions using everyday household items. No ads, no tracking.
```

**Full description:**
```
Tada Quest helps kids learn playful magic tricks with things they can find around
the house: paper, pencils, shadows, water, crayons, numbers, and more.

Each mission teaches:
- What the audience sees
- What items are needed
- Step-by-step setup
- A kid-friendly secret
- A short showtime script
- Safety and cleanup reminders

Made for curious kids and families:
- No ads
- No accounts
- No tracking
- Works offline
- No camera, microphone, or location
- Grown-up help labels for water or small-object missions

Tada Quest is about confidence, creativity, science, and performance — not scary
magic or unsafe stunts.
```

---

## Graphics (already in the repo at assets/png)

| Asset | Spec | File |
|---|---|---|
| App icon | 512×512 PNG | `assets/png/play_store/icon_512.png` |
| Feature graphic | 1024×500 PNG | `assets/png/play_store/feature_graphic_1024x500.png` |
| Phone screenshots ×3 | 1080×1920 PNG | `assets/png/mockups/screenshot_*.png` |

> These are clean placeholder assets. Fine for internal/closed testing; consider
> polished art before public production launch.

---

## Data Safety form answers

- Does your app collect or share any required user data types? → **No**
- (All categories: personal info, location, photos, audio, files, etc.) → **None**
- Is all data encrypted in transit? → N/A (no data leaves the device)
- Do you provide a way for users to request data deletion? → N/A; in-app
  "Reset progress" clears local data.

## Content rating questionnaire (IARC)

- Category: **Reference, education, or information / Utility**
- Violence, sexual content, profanity, controlled substances, gambling → **None**
- User-generated content / sharing / chat → **None**
- Expected result: **Everyone / PEGI 3 / ESRB Everyone**

## Target audience & content (Families)

- Target age groups: **Ages 6–8 and 9–12** (you may also include 5 & under only if
  you intend to; spec recommends 6+ as primary).
- Is the app designed for children? → **Yes** → places it under the **Google Play
  Families policy / Designed for Families** requirements.
- Ads present? → **No**.
- Contains a privacy policy? → **Yes** (URL above).

## App access
- All functionality is available without special access, login, or location.
  → Select **"All functionality is available without special access."**

## Ads declaration
- Does your app contain ads? → **No**.

---

## Click-by-click: create app + upload to Internal testing

1. Go to **play.google.com/console** → sign in as reasner196@gmail.com.
2. **Create app**:
   - App name: `Tada Quest`
   - Default language: English (US)
   - App or game: **App**
   - Free or paid: **Free**
   - Accept declarations → **Create app**.
3. Left nav → **Test → Internal testing** → **Create new release**.
4. **App signing**: when prompted, choose **"Use Google-generated key"**
   (Play App Signing). Our AAB is signed with the *upload* key; Google manages the
   real signing key. ✅
5. **Upload** `app-release.aab` (from the GitHub Actions artifact — see below).
6. Release name auto-fills (e.g. `1 (1.0.0)`). Add release notes: `First test build.`
   → **Next** → **Save** → **Review release** → **Start rollout to Internal testing**.
7. **Testers tab** → create an email list → add your test emails (your own + any
   testers) → **Save**. Copy the **join link** and open it on an Android device to
   opt in, then install from the Play Store link.
8. Complete the dashboard tasks Play lists (Store listing, Data Safety, Content
   rating, Target audience, App access, Ads) using the answers above. These are
   required before the listing is complete, but internal testers can install once
   the release is rolled out.

## Then: path to Production (the 14-day part)
9. **Test → Closed testing** → create a track → upload the same AAB → add **≥12
   testers** → have all 12 opt in. Keep them opted in **14 days**.
10. After 14 days, Play Console shows **"Apply for production access"** → fill the
    short form → submit. Then create a **Production** release with the AAB and roll
    out. Google reviews (kids apps can take longer than 24h).

---

## Where to get the signed AAB
GitHub Actions builds it on every push. Latest:
`https://github.com/thisisthecoolesthting/tada-quest/actions` → newest
**Build Android (APK + AAB)** run → **Artifacts** → `tada-quest-release-aab`.
(Also downloaded locally to `tada_quest/artifacts/aab/app-release.aab`.)
