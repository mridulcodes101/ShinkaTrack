# Software Requirements Specification (SRS) - ShinkaTrack

---

## 1. Introduction
This document defines the functional requirements, non-functional requirements, security attributes, database synchronization architectures, and performance criteria for the **ShinkaTrack** application.

---

## 2. Functional Requirements

### 2.1 User Mode
* **FR-1.1**: The system must provide 5 distinct study tabs: Kanji, Vocabulary, Grammar, Reading, and Listening.
* **FR-1.2**: Users must be able to add/remove entries from the Master dictionary into their personal Study Collection.
* **FR-1.3**: The system must maintain study progress parameters (learned status, favorites, custom mnemonic notes, review history, and interval scheduling data).
* **FR-1.4**: Users must be able to set daily item study goals and weekly active study hour targets.
* **FR-1.5**: The system must automatically check for and unlock achievements, rewarding the user with XP and Coins upon completion.

### 2.2 Developer/Admin Mode
* **FR-2.1**: Developer Mode must remain hidden from standard users and be activated *only* by tapping the Version field in Settings 7 times.
* **FR-2.2**: The system must enforce passcode protection on developer settings. First launch requires passcode creation. Subsequent launches require passcode input.
* **FR-2.3**: Admins must be able to create, read, update, and delete (CRUD) entries inside the master databases.
* **FR-2.4**: The system must allow importing master data via raw JSON pasting, CSV file parsing, or local file system path parameters.
* **FR-2.5**: The system must support database-wide JSON backups, clipboard backup generation, and full configuration restorations.

---

## 3. Non-Functional Requirements

### 3.1 Performance Goals
* **NFR-1.1**: The application must load and render lists containing 2,500+ Kanji entries with zero frame drops (maintaining a constant 60 FPS scrolling experience).
* **NFR-1.2**: List rendering must utilize lazy-loading pagination (`ListView.builder`) and Riverpod selectors to avoid rebuilding items outside the viewport.
* **NFR-1.3**: Database queries must be compiled with indexes on search parameters (`kanji`, `meaning`, `onYomi`, `kunYomi`, `jlptLevel`).

### 3.2 Offline-First Strategy
* **NFR-2.1**: The app must operate entirely without internet connectivity. All assets, fonts, dictionary entries, and logic must reside locally on the device.
* **NFR-2.2**: The system database must use SQLite (via Drift/sqlite3_flutter_libs) for high-performance offline storage.
* **NFR-2.3**: Data backup and restore must be accomplished through local file serialization (JSON) and clipboard interactions, requiring no cloud endpoint.

### 3.3 Security & Hashing
* **NFR-3.1**: The administrator passcode must never be hardcoded in UI classes.
* **NFR-3.2**: The passcode must be stored securely using `SharedPreferences` as an encrypted hash. Plaintext passwords must never be stored.
* **NFR-3.3**: The hashing algorithm must use salted FNV-1a (or be compatible with future upgrades to SHA-256 / biometrics).
* **NFR-3.4**: Normal users must be barred from navigating to admin routes. Manually accessed admin screens must terminate immediately and display restricted access overlays.

### 3.4 Accessibility
* **NFR-4.1**: The UI must comply with Web Content Accessibility Guidelines (WCAG) 2.1 Level AA color contrast ratios for text components.
* **NFR-4.2**: Visual fonts must scale responsively in accordance with OS-level user font-size scales using relative text scale factors.
* **NFR-4.3**: All touch targets for interactive items (cards, buttons, icons) must have a minimum size of 48x48 logical pixels.

---

## 4. Error Handling & Fail-Safes
* **ERR-1**: If the JSON/CSV data import structure is malformed, the system must abort the import transaction, rollback database changes, and display a dialog detailing the parsing exception.
* **ERR-2**: If a user attempts to restore a corrupted backup payload, the system must validate the JSON keys before applying changes, preventing database state corruption.
* **ERR-3**: Drift migrations must wrap schema updates inside a non-destructive transaction, ensuring that database updates from older schema versions preserve all pre-existing user progress data.
