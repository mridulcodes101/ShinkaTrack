# Content Guidelines & Standards - ShinkaTrack

To maintain data integrity and keep search queries performing correctly, all dictionary content (Kanji, Vocabulary, Grammar, Readings, and Listening tracks) added via JSON, CSV, or the Admin panel must comply with these formatting rules.

---

## 1. General Formatting Rules

### 1.1 Japanese Character Standards
* **Kanji & Kana**: All Japanese content must be written in standard Japanese characters (Kanji, Hiragana, Katakana) using Unicode. Do not use romaji in Japanese text fields.
* **Punctuation**: Use full-width Japanese punctuation marks in sentences (e.g. `。` instead of `.`, `、` instead of `,`, `「` and `」` for quotations).

### 1.2 English Translation Standards
* Keep definitions clear and concise.
* Separate multiple meanings with semicolons (e.g., `To give up; abandon hope; resign`).

---

## 2. Module Guidelines

### 2.1 Kanji
* **Kanji Character**: Must be a single Kanji character (e.g. `諦`).
* **Unicode**: Hex code formatted as `U+XXXX` (e.g. `U+8AE6`).
* **Kun'yomi**: Must be a list of Hiragana strings. Use a dot `.` to separate the stem from okurigana if applicable (e.g. `["あきら.める"]`).
* **On'yomi**: Must be a list of Katakana strings (e.g. `["タイ"]`).
* **Stroke Count**: Integer value. Must match the standard stroke counts defined by the Japanese Ministry of Education.
* **Radical**: The primary radical character associated with the Kanji (e.g. `言`).

### 2.2 Vocabulary
* **Word**: Written form in Kanji/Kana (e.g. `諦める`).
* **Reading**: Reading in Hiragana (e.g. `あきらめる`).
* **Meaning**: English definition.

### 2.3 Grammar
* **Title**: The grammar token, followed by its romaji representation in parentheses (e.g. `に対して (ni taishite)`).
* **Explanation**: Detailed definition of nuance and meaning.
* **Structure**: Clear syntax mapping (e.g. `Noun + に対して / Verb + のに対して`).

### 2.4 Reading & Listening
* **Title**: Descriptive name of the lesson (e.g. `お茶の文化 (Tea Culture)`).
* **Passages & Scripts**: Written in natural, standard Japanese.
* **Comprehension Questions**: Concise questions in English, with accurate English answers.

---

## 3. Example Sentences & Translations
* All example sentence listings must be stored as serialized JSON arrays containing `jp` (Japanese text) and `en` (English translation) key mappings.
* Example structure:
  ```json
  [
    {
      "jp": "先生に対して失礼なことを言ってはいけません。",
      "en": "You must not speak rudely to the teacher."
    }
  ]
  ```

---

## 4. JLPT Tag Standards
To keep catalog queries unified, all indexing tags and level labels must use these strict conventions:
* **JLPT Level**: Integer value between `1` and `5` (e.g., `3` for N3).
* **Grade Level**: Integer value corresponding to Japanese Elementary/Junior High school grades (1-9).
* **Tags**: JSON array of lowercase strings (e.g., `["common", "sino-japanese", "wasei-eigo"]`).
