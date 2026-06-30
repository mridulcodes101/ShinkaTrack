# ShinkaTrack Content Standards Specification (SPEC-004)

This document establishes the centralized data quality and format standards for all learning objects in ShinkaTrack (Kanji, Vocabulary, Grammar, Reading, and Listening lessons).

---

## 1. Core Principles

1. **Logical Separation (Master vs. User)**:
   - **Master Database**: Read-only core content. This document defines the exact schema rules for all Master database imports.
   - **User Database**: Stores progress history, streaks, and bookmarks. Master items must never house user progress states directly.
2. **Knowledge Graph Connectivity**:
   - Items should aggressively cross-reference other content elements using strict ID fields instead of duplicate text properties.
3. **Validation Enforcement**:
   - Imports must run through the `ContentValidator` presence, uniqueness, and reference integrity checks. Any broken reference or schema violation rejects the import batch.

---

## 2. Learning Object Schemas

### 2.1 Kanji Content Schema

| Field Name | Type | Description | Mandatory |
| :--- | :--- | :--- | :--- |
| `id` | String | Unique item identifier | Yes |
| `character` | String | Single kanji character | Yes |
| `unicode` | String | Unicode hex value (e.g. `U+66F8`) | Yes |
| `meaning` | String | Primary English translation | Yes |
| `onyomi` | List<String> | Chinese readings (Katana representation) | Yes |
| `kunyomi` | List<String> | Japanese readings (Hiragana representation) | Yes |
| `jlptLevel` | int | JLPT level (3 for N3) | Yes |
| `gradeLevel` | int | Japanese school grade level | Yes |
| `strokeCount` | int | Standard stroke count | Yes |
| `radicals` | String | Associated radicals | Yes |
| `primaryRadical` | String | Core classification radical | Yes |
| `frequencyRank` | int | Frequency rank in public corpora | Yes |
| `joyoStatus` | String | Joyo classification | Yes |
| `exampleWords` | List<String> | List of words utilizing this kanji | Yes |
| `exampleSentences` | List<String> | Sentences featuring usage | Yes |
| `relatedKanji` | List<String> | IDs of closely linked kanji | Yes |
| `tags` | List<String> | User/system labels | Yes |
| `difficulty` | double | Estimated learning difficulty weight | Yes |
| `createdAt` | DateTime | System generation timestamp | Yes |
| `updatedAt` | DateTime | Last edit timestamp | Yes |
| `schemaVersion` | int | Schema structure version | Yes |
| `contentVersion` | int | Content revision count | Yes |
| `lastUpdated` | DateTime | Last content updated timestamp | Yes |
| `mnemonic` | String | Learning memory helper text | No |
| `personalNotes` | String | Teacher/editorial annotations | No |
| `image` | String | File URL/path to visual helper | No |
| `svgStrokeOrder` | String | Raw SVG path coordinates for drawing | No |
| `animatedStrokeData` | String | Drawing coordinates for stroke animation | No |
| `audio` | String | File path to reading audio | No |
| `pitchAccentExamples` | List<String> | Pitch accent pronunciation guides | No |
| `writingPracticeData` | String | Drawing guidelines for handwriting | Future |
| `handwritingRecognition` | String | Neural grid descriptors | Future |
| `aiExplanation` | String | AI-generated semantic explanation | Future |

---

### 2.2 Vocabulary Content Schema

| Field Name | Type | Description | Mandatory |
| :--- | :--- | :--- | :--- |
| `id` | String | Unique item identifier | Yes |
| `word` | String | Word kanji representation (or kana) | Yes |
| `kana` | String | Kana reading representation | Yes |
| `meaning` | String | English translations | Yes |
| `jlpt` | int | Target JLPT level | Yes |
| `partOfSpeech` | String | Noun, verb classification, etc. | Yes |
| `frequency` | int | Usage frequency rank | Yes |
| `kanjiUsed` | List<String> | List of Kanji IDs composing the word | Yes |
| `relatedGrammar` | List<String> | IDs of grammar rules featuring this vocab | Yes |
| `synonyms` | List<String> | Equivalent vocabulary | Yes |
| `antonyms` | List<String> | Opposite vocabulary | Yes |
| `exampleSentences` | List<String> | Example sentences | Yes |
| `tags` | List<String> | Metadata tags | Yes |
| `difficulty` | double | Difficulty weight | Yes |
| `createdAt` | DateTime | Timestamp of creation | Yes |
| `updatedAt` | DateTime | Timestamp of update | Yes |
| `schemaVersion` | int | Schema version | Yes |
| `contentVersion` | int | Content version | Yes |
| `lastUpdated` | DateTime | Last updated timestamp | Yes |
| `pitchAccent` | String | Accent pattern representation | No |
| `audio` | String | Pronunciation audio file path | No |
| `image` | String | Visual depiction file path | No |
| `mnemonic` | String | Memory aid text | No |
| `personalNotes` | String | Instructor/editorial notes | No |
| `aiNotes` | String | Generated semantic details | Future |

---

### 2.3 Grammar Content Schema

| Field Name | Type | Description | Mandatory |
| :--- | :--- | :--- | :--- |
| `id` | String | Unique item identifier | Yes |
| `grammarPattern` | String | Pattern string (e.g. `〜に対して`) | Yes |
| `meaning` | String | Explanation | Yes |
| `formation` | String | Construction rules | Yes |
| `usage` | String | Structural usage details | Yes |
| `nuance` | String | Subtle meaning nuances | Yes |
| `formalLevel` | String | Formality level classification | Yes |
| `jlpt` | int | Target JLPT level | Yes |
| `examples` | List<Example> | List of JSON Example objects | Yes |
| `commonMistakes` | List<Mistake> | List of JSON Mistake objects | Yes |
| `relatedGrammar` | List<String> | IDs of contrasting/similar grammar rules | Yes |
| `relatedVocabulary` | List<String> | Vocabulary IDs typically used with it | Yes |
| `relatedKanji` | List<String> | Kanji IDs linked to the grammar | Yes |
| `difficulty` | double | Difficulty rating | Yes |
| `tags` | List<String> | Metadata labels | Yes |
| `createdAt` | DateTime | Created timestamp | Yes |
| `updatedAt` | DateTime | Updated timestamp | Yes |
| `schemaVersion` | int | Schema structure version | Yes |
| `contentVersion` | int | Content version | Yes |
| `lastUpdated` | DateTime | Last updated timestamp | Yes |
| `memoryTips` | String | Mnemonic tips | No |
| `audio` | String | Pattern pronunciation path | No |
| `video` | String | Explanatory video file path | No |
| `aiExplanation` | String | Semantic details generated by AI | Future |

---

### 2.4 Reading Content Schema

| Field Name | Type | Description | Mandatory |
| :--- | :--- | :--- | :--- |
| `id` | String | Unique reading lesson ID | Yes |
| `title` | String | Lesson Title | Yes |
| `jlpt` | int | JLPT level | Yes |
| `difficulty` | double | Reading complexity rating | Yes |
| `estimatedReadingTime`| int | Target reading speed duration (minutes) | Yes |
| `passage` | String | Raw Japanese reading passage | Yes |
| `translation` | String | English translation of the passage | Yes |
| `vocabularyReferences`| List<String> | Vocabulary IDs featured in text | Yes |
| `grammarReferences` | List<String> | Grammar pattern IDs featured in text | Yes |
| `kanjiReferences` | List<String> | Kanji IDs featured in text | Yes |
| `questions` | List<Question> | List of JSON Question objects | Yes |
| `answers` | List<String> | Correct answer options/indexes | Yes |
| `createdAt` | DateTime | Creation timestamp | Yes |
| `updatedAt` | DateTime | Update timestamp | Yes |
| `schemaVersion` | int | Schema version | Yes |
| `contentVersion` | int | Content version | Yes |
| `lastUpdated` | DateTime | Last updated timestamp | Yes |
| `audio` | String | Audiobook file path | No |
| `images` | List<String> | Illustration assets | No |
| `notes` | String | Additional vocabulary guides | No |

---

### 2.5 Listening Content Schema

| Field Name | Type | Description | Mandatory |
| :--- | :--- | :--- | :--- |
| `id` | String | Unique listening lesson ID | Yes |
| `title` | String | Lesson Title | Yes |
| `jlpt` | int | JLPT level | Yes |
| `difficulty` | double | Audio speed/vocab difficulty rating | Yes |
| `transcript` | String | Dialogue/text script | Yes |
| `translation` | String | English transcript translation | Yes |
| `vocabularyReferences`| List<String> | Vocabulary IDs referenced in script | Yes |
| `grammarReferences` | List<String> | Grammar IDs referenced in script | Yes |
| `kanjiReferences` | List<String> | Kanji IDs referenced in script | Yes |
| `duration` | double | Audio duration in seconds | Yes |
| `createdAt` | DateTime | Creation timestamp | Yes |
| `updatedAt` | DateTime | Update timestamp | Yes |
| `schemaVersion` | int | Schema version | Yes |
| `contentVersion` | int | Content version | Yes |
| `lastUpdated` | DateTime | Last updated timestamp | Yes |
| `audio` | String | Dialogue audio file path | No |
| `playbackSpeedMetadata`| String | Custom pitch/speed adjustment metadata | No |
| `notes` | String | Contextual notes | No |

---

## 3. Formatting Standards

### 3.1 JSON Formatting
JSON fields must adhere strictly to camelCase naming keys. List items can be standard JSON arrays:
```json
{
  "id": "k10",
  "character": "書",
  "unicode": "U+66F8",
  "meaning": "write, book",
  "onyomi": ["ショ"],
  "kunyomi": ["か.く", "が.き"],
  "jlptLevel": 3,
  "strokeCount": 10,
  "radicals": "曰",
  "primaryRadical": "曰"
}
```

### 3.2 CSV Formatting
- **Delimiter**: Standard comma (`,`) or semicolon (`;`) splitting.
- **Lists Representation**: List items (e.g. `onyomi`, `kunyomi`) are written in a single field separated by semicolons (`ショ;ショウ`).
- **Complex Objects Representation**: Structured object properties (e.g. `examples` or `questions`) must be escaped JSON strings inside the target cell:
  `"[{\"japanese\":\"本を書きます。\",\"english\":\"I write a book.\"}]"`

### 3.3 `.shinka` Archive Formatting
A `.shinka` file represents a standardized learning pack zipped containing:
- `pack.json`: Content pack metadata.
- `kanji.json`: Array of KanjiSpec JSON objects.
- `vocabulary.json`: Array of VocabularySpec JSON objects.
- `grammar.json`: Array of GrammarSpec JSON objects.
- `reading.json`: Array of ReadingSpec JSON objects.
- `listening.json`: Array of ListeningSpec JSON objects.
- `assets/`: Media subdirectory for audio clips (`.mp3`) and diagram files (`.svg`, `.png`).
