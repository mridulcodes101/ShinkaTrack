# Database Schema Document - ShinkaTrack

This document details the database schema configuration, tables, fields, types, and primary/foreign key relationships implemented within the offline-first Drift SQLite storage.

---

## 1. Architectural Strategy: Split Database Tables
The application splits its storage into two logical database sections:
1. **Master Catalog Tables**: Read-only tables containing JLPT N3 dictionary entities seeded on database creation. Users never edit these records directly.
2. **User Collection & Progress Tables**: Mutable user collections, custom mnemonics, statistics, daily goals, scheduler schedules, and achievements.

---

## 2. Table Schemas

### 2.1 Master Tables

#### `master_kanjis`
Stores the static offline Kanji dictionary.
* `id` (TEXT, Primary Key): Unique alphanumeric ID (usually UUID or index code).
* `kanji` (TEXT, Unique, Indexed): The literal kanji character (e.g., "諦").
* `unicode` (TEXT): The standard Unicode representation (e.g., "U+8AE6").
* `jlpt_level` (INTEGER, Indexed): The target JLPT level (defaults to 3).
* `grade_level` (INTEGER, Nullable): Japanese school system grade level.
* `meaning` (TEXT): Core English translation/meaning definitions.
* `kun_yomi` (TEXT): Stringified JSON array of Japanese Kunyomi readings (hiragana).
* `on_yomi` (TEXT): Stringified JSON array of Japanese Onyomi readings (katakana).
* `stroke_count` (INTEGER): Number of strokes required to write the character.
* `radicals` (TEXT): Radical elements associated with the character.
* `stroke_order_diagram` (TEXT, Nullable): Local asset file path to stroke order diagrams.
* `example_words` (TEXT): Stringified JSON array of example words and compounds.
* `example_sentences` (TEXT): Stringified JSON array of example sentences.
* `notes` (TEXT, Nullable): Core administrative editor notes.
* `tags` (TEXT): Stringified JSON array of indexing tags (e.g., ["RTK", "common"]).
* `created_at` (INTEGER): Milliseconds since epoch.
* `updated_at` (INTEGER): Milliseconds since epoch.

#### `vocabularies`
Stores the static vocabulary dictionary.
* `id` (TEXT, Primary Key): Unique vocabulary identifier.
* `word` (TEXT, Indexed): Written vocabulary form (kanji/kana).
* `reading` (TEXT): Reading in Hiragana.
* `meaning` (TEXT): English translation.
* `status` (TEXT): Study status state ("unlearned", "learning", "learned").

#### `grammars`
Stores grammar points and explanation rules.
* `id` (TEXT, Primary Key): Unique identifier.
* `title` (TEXT): Grammar point title (e.g., "に対して").
* `explanation` (TEXT): Explanation of meaning, usage, and nuance.
* `structure` (TEXT): Sentence structure pattern guidelines.
* `examples_json` (TEXT): Stringified JSON array of example sentences and translations.
* `status` (TEXT): Study status state.

#### `readings`
Stores comprehension reading passages.
* `id` (TEXT, Primary Key): Unique identifier.
* `title` (TEXT): Title of the reading passage.
* `passage` (TEXT): Full Japanese passage text.
* `question` (TEXT): Comprehension question.
* `answer` (TEXT): Correct multiple-choice answer.
* `explanation` (TEXT): Explanation of correct answer mapping.
* `status` (TEXT): Study status state.

#### `listenings`
Stores listening comprehension materials.
* `id` (TEXT, Primary Key): Unique identifier.
* `title` (TEXT): Title of the listening track.
* `audio_script` (TEXT): Transcript of the spoken audio dialogue.
* `question` (TEXT): Spoken question definition.
* `answer` (TEXT): Correct answer choice.
* `explanation` (TEXT): Explanation of context.
* `status` (TEXT): Study status state.

---

### 2.2 User Progress & Collection Tables

#### `user_kanjis`
Stores user-specific stats, favorites, and notes, linking back to the master dictionary.
* `id` (TEXT, Primary Key): Equal to `master_kanji_id`.
* `master_kanji_id` (TEXT, Foreign Key): References `master_kanjis(id)` with `ON DELETE CASCADE`.
* `is_added` (BOOLEAN): True if added to the user's active study collection.
* `is_learned` (BOOLEAN, Indexed): True if marked as fully memorized.
* `is_favorite` (BOOLEAN, Indexed): True if starred by the user.
* `review_count` (INTEGER): Number of times reviewed.
* `ease_factor` (REAL): Spaced Repetition multiplier factor (starts at 2.5).
* `next_review` (INTEGER, Nullable): Epoch milliseconds of the next review date.
* `last_reviewed` (INTEGER, Nullable): Epoch milliseconds of last review session.
* `custom_notes` (TEXT): User's custom mnemonics or personal notes.
* `created_at` (INTEGER): Creation timestamp.
* `updated_at` (INTEGER): Last modification timestamp.

#### `study_sessions`
Logs user study duration and completed items per day.
* `id` (TEXT, Primary Key): Unique session ID.
* `start_time` (INTEGER): Start epoch timestamp.
* `duration_seconds` (INTEGER): Total time spent studying.
* `xp_earned` (INTEGER): Total XP rewarded.
* `coins_earned` (INTEGER): Total coins rewarded.
* `items_studied` (INTEGER): Number of cards/elements processed.

#### `daily_goals`
Tracks daily completion targets.
* `id` (TEXT, Primary Key): Date key formatted as "yyyy-MM-dd".
* `target_seconds` (INTEGER): Daily goal study time (seconds).
* `completed_seconds` (INTEGER): Active study time accumulated.
* `target_items` (INTEGER): Target cards to review.
* `completed_items` (INTEGER): Cards successfully reviewed.

#### `weekly_goals`
Tracks longer-term completion targets.
* `id` (TEXT, Primary Key): Weekly format key (e.g., "yyyy-Www").
* `target_seconds` (INTEGER): Weekly target seconds.
* `completed_seconds` (INTEGER): Accumulated seconds.
* `target_items` (INTEGER): Target items.
* `completed_items` (INTEGER): Completed items.
* `is_claimed` (BOOLEAN): True if weekly coin bonus has been claimed.

#### `planner_tasks`
Tracks scheduled daily study plan items.
* `id` (TEXT, Primary Key): Unique task ID.
* `scheduled_date` (INTEGER, Indexed): Date on which the task is scheduled.
* `kanji_ids` (TEXT): JSON array of master kanji IDs scheduled for study.
* `is_completed` (BOOLEAN): Status of task completion.

#### `review_items` (Review Queue)
Active items currently scheduled in the active queue for spaced repetition.
* `id` (TEXT, Primary Key): Unique queue entry ID.
* `item_type` (TEXT): Enum key indicating item module ("kanji", "vocab", "grammar").
* `item_id` (TEXT, Indexed): Target ID of the item inside its master table.
* `stage` (INTEGER): Current Leitner box stage index (e.g., 0-5).
* `next_review_date` (INTEGER): Target epoch for review expiration.
* `last_review_date` (INTEGER): Timestamp of previous attempt.

#### `user_stats`
Tracks levels and economy metrics.
* `id` (TEXT, Primary Key): Unique user ID (typically "default_user").
* `xp` (INTEGER): Total experience points.
* `coins` (INTEGER): Total currency coins.

#### `achievements`
Gamified achievements checklist.
* `id` (TEXT, Primary Key): Achievement unique ID.
* `title` (TEXT): Display name.
* `description` (TEXT): Requirements text.
* `xp_reward` (INTEGER): XP rewarded.
* `coin_reward` (INTEGER): Coins rewarded.
* `is_unlocked` (BOOLEAN): Status flag.
* `unlocked_at` (INTEGER, Nullable): Unlock timestamp.

---

## 3. Relationships & ERD Outline
* **`master_kanjis` (1) <---> (0..1) `user_kanjis`**: A one-to-optional-one relation. An entry inside `user_kanjis` is created only when a user starts interacting with a kanji (adding to collection, writing notes, or reviewing it).
* **`master_kanjis` (1) <---> (0..*) `planner_tasks`**: A task references multiple master kanji IDs serialized as a JSON string inside the `kanji_ids` column.
* **`review_items` (1) <---> (1) `master_kanjis`/`vocabularies`/`grammars`**: A polymorphic link mapping `item_id` to its master entity based on `item_type` metadata.
