# Tada Quest — Manual QA Test Plan

Run on a real Android 8+ device before promoting past internal testing.

## Privacy & permissions (hard gate)
- [ ] App works fully in **airplane mode** (no network needed).
- [ ] System settings show the app has **no permissions** granted.
- [ ] No screen asks for name, email, birthday, photo, voice, location, or any
      open text input.
- [ ] No ads appear anywhere.

## Onboarding
- [ ] Splash → Start → Age path.
- [ ] Picking an age path goes to Safety promise (or grown-up gate for "Grown-up").
- [ ] Safety promise shows 4 icons; "I'm ready" → Mission home.

## Age filtering
- [ ] **4–6 with grown-up** path shows only starter missions (Flower, Bendy Pencil, Shadow Rabbit).
- [ ] **6–8** path hides medium/9–12-only missions (Coin Portal, Rising Ring, Static Can, Prediction Star).
- [ ] **9–12** path shows all 12 missions.

## Mission flow (test at least 3 missions)
- [ ] Prep shows items + safety + (if applicable) "Grown-up helps".
- [ ] Step runner: one step per screen, Back/Next work, "Need help" reveals a hint.
- [ ] Last step → Secret screen → Showtime script → Completion.
- [ ] Completion awards the badge; "Yes" → Badge book shows it.

## Progress persistence
- [ ] Complete a mission, force-close the app, reopen → badge still present,
      progress bar reflects completion.

## Grown-up gate
- [ ] Grown-up area requires a 3-second hold to open.
- [ ] Reset progress is only reachable inside the grown-up area.
- [ ] Reset clears completed missions + badges.
- [ ] Links shown as plain text (no tap-to-open), so no browser launches.

## UI / accessibility
- [ ] Text readable on small and large phones.
- [ ] Tap targets large (buttons ≥ 56–64 dp).
- [ ] No scary imagery, punishments, or failure shame.

## Automated tests (run before build)
```bash
cd app_flutter && flutter test
```
Covers: JSON parses to 12 missions, required fields present, age-filter rules,
and the banned-item safety invariant.
