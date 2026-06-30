# Product Development Roadmap - ShinkaTrack

This roadmap outlines the milestones, feature goals, and target dates leading to the full production launch and subsequent iterations of ShinkaTrack.

---

## Milestone 1: v0.1 - Core Database & Search (Completed)
**Focus**: Establish database architecture and basic navigation.
* [x] Design split database schema layout separating Master database from User collection data.
* [x] Implement Drift migrations logic from v3 to v4.
* [x] Construct Main Study search page with pagination and lazy-loaded items (60 FPS scrolling).
* [x] Refactor domain entities mapping Left Outer Joins into single cohesive models.

---

## Milestone 2: v0.2 - Developer Mode & Security Gate (Current)
**Focus**: Secure administrative access controls and offline synchronization tools.
* [x] Implement the hidden Developer Mode tapping entry trigger (7 taps in Settings).
* [x] Create `AdminService` with secure FNV-1a passcode hashing.
* [x] Build Password creation setup forms and login validation check sheets.
* [x] Protect administrative screens (/admin, /add_kanji) from unauthorized routing.
* [x] Implement JSON/CSV dictionary data parsing and backup utilities.

---

## Milestone 3: v0.5 - Review Queue & Smart Study Planner
**Focus**: Integrate study progression engine and spaced repetition controls.
* [ ] Implement Leitner-based Review Queue scheduler utilizing ease factors and review counts.
* [ ] Build active daily and weekly study targets widgets.
* [ ] Design the automated daily planner algorithm that distributes pending items across planned hours.
* [ ] Integrate visual SRS progress charts on study overview sheets.

---

## Milestone 4: v1.0 - Gamification & Core Release (Production Gold)
**Focus**: Complete gamification ecosystem, perform full manual validation, and package the initial public release.
* [ ] Enable Leveling systems, experience point calculations, and automated achievement criteria checks.
* [ ] Verify app accessibility contrast guidelines and Dynamic Type sizing.
* [ ] Implement full widget/integration test coverage (targeting >85% code coverage).
* [ ] Release production builds on Google Play Store and iOS App Store.

---

## Milestone 5: v2.0 - Handwriting Recognition & Audio Synthesis
**Focus**: Integrate interactive learning capabilities and advanced offline intelligence.
* [ ] Add offline handwritten Kanji drawing recognition service.
* [ ] Incorporate text-to-speech (TTS) audio pronunciation and offline pitch accent visual markers.
* [ ] Add animated stroke order diagram assets.

---

## Milestone 6: v3.0 - Cloud Sync & Multi-Platform Backup
**Focus**: Secure cloud backup systems and community resource sharing.
* [ ] Build optional end-to-end encrypted cloud backup capabilities (Firebase / cloud service integrations).
* [ ] Enable conflict resolution algorithms for multi-device login sessions.
* [ ] Create shared study decks sharing platform for custom JSON import configurations.
