# Changelog - ShinkaTrack

All notable changes to the ShinkaTrack project are documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and adheres to Semantic Versioning.

---

## [0.2.0] - 2026-06-30
### Added
* Secure, hidden Developer Options portal at `/developer_options` activated via 7-tap gesture on Settings app version.
* Passcode Setup and access gate checks using `AdminService`.
* Salted FNV-1a password hashing for persistent SharedPreferences storage.
* Administrative database statistics counters showing total dictionary rows.
* Danger Zone operations allowing Master database reset and user collection wipes.
* CSV and JSON batch import/export parsers.
* Pinned collection FAB on details screens.

### Fixed
* Resolved `QueryRow.reads` compilation error on Drift v2.x.
* Fixed Drift `Migrator.dropTable` syntax errors using raw SQL `customStatement`.
* Fixed `use_build_context_synchronously` warnings across async gaps.

---

## [0.1.0] - 2026-06-27
### Added
* Split database configuration separating read-only `MasterKanjis` from mutable `UserKanjis`.
* Drift database migration setup (schema upgrade version 3 to 4) preserving progress.
* Left outer join queries linking master dictionary items to collection status.
* Lazy-loaded Kanji search screen with scrolling optimization support for 2,500+ rows.
* Redesigned Kanji Details screen showing example words, radicals, and mnemonics.
