# Product Requirement Document (PRD) - ShinkaTrack

---

## 1. Product Vision
**ShinkaTrack** is a premium, offline-first Japanese language learning companion designed specifically for self-directed learners aiming to master the Japanese Language Proficiency Test (JLPT) N3 level. By combining spaced repetition systems (SRS), granular study planning, structured database curation, and beautiful Material 3 gamification, ShinkaTrack transforms the tedious process of cataloging study progress into a responsive and visually stunning journey of growth (進化 - *Shinka*).

---

## 2. Mission
To empower learners worldwide with a professional, distraction-free, offline-first utility that guarantees data ownership, absolute offline availability, and high-performance study tracking without reliance on cloud subscriptions or constant internet connectivity.

---

## 3. Target Audience
* **Self-Directed Japanese Learners**: Students studying for the JLPT N3 exam who prefer using structured, customizable dictionary resources.
* **Offline Learners**: Users in low-connectivity areas or individuals who intentionally study offline to eliminate notifications and distractions.
* **Progress-Driven Users**: Learners who thrive on gamified visual indicators, completion badges, and strict tracking of daily/weekly study goals.

---

## 4. User Personas

### Persona A: Sarah (The Commuting Professional)
* **Age**: 28
* **Profile**: Working in software sales; commutes 45 minutes on subways with spotty internet connectivity.
* **Goal**: Needs to study JLPT N3 vocabulary and kanji in bite-sized chunks during her daily commute.
* **Frustrations**: Standard language apps require logins, load slowly, drop sessions when internet drops, and spam notifications.
* **ShinkaTrack Value**: High-performance, offline-first database loads instantly. Can add Kanji cards to her collection and study with no lag.

### Persona B: Kenji (The University Student)
* **Age**: 21
* **Profile**: Double majoring in East Asian Studies and Computer Science. Very detail-oriented.
* **Goal**: Wants to curate a personal collection of kanji and vocabulary, add custom mnemonics, and review them using a structured Spaced Repetition Schedule (SRS).
* **Frustrations**: Lack of customization in proprietary dictionary apps; inability to backup and export notes/progress data.
* **ShinkaTrack Value**: Ability to write custom notes, export/restore full database backups, and access hidden developer options for database customization.

---

## 5. Core Features
* **Dual Database Split**: Segregated read-only Master dictionary from the user's mutable study collection state.
* **Hidden Developer Mode**: 7-tap activation mechanism in Settings unlocking passcode-protected developer options (databases CRUD, JSON/CSV imports, stats summary, and backups).
* **Granular Study Modules**: Kanji, Vocabulary, Grammar, Reading, and Listening.
* **Smart Study Planner**: Set weekly time targets and daily item lists to automatically schedule daily study loads.
* **Rich Gamification**: XP thresholds, levels, coin economy, and automated achievement checkmarks.
* **SRS Review Engine**: Dynamic interval card scheduler using ease factors and reviews queues.

---

## 6. Competitive Analysis

| Feature | ShinkaTrack | Anki | Duolingo | Wanikani |
| :--- | :--- | :--- | :--- | :--- |
| **Offline Capability** | 100% Offline-First | Partial / Setup needed | No | No |
| **Data Ownership** | JSON Export / Backup | Package Import / Sync | Lock-in | Subscription |
| **Gamification** | High (M3 & Coins) | None | High (Hearts/League) | Low |
| **Custom Dictionary Notes**| Yes | Yes | No | Yes |
| **UI Aesthetics** | Premium M3 Dark/Light | Legacy UI | Casual / Cartoonish | Web-based |

---

## 7. Success Metrics
* **Engagement**: Weekly Active Users (WAU) remaining active for more than 4 days/week.
* **Performance**: UI main thread rendering consistently at 60 FPS (or 120 FPS on supported displays) even with 2,500+ database rows.
* **Security & Reliability**: 100% data integrity during V3 to V4 migrations and zero data corruption on backup restorations.
* **Accessibility**: Full compliance with Material Design contrast ratios and platform-level dynamic text sizing.
