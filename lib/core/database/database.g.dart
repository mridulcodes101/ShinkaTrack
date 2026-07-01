// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MasterKanjisTable extends MasterKanjis
    with TableInfo<$MasterKanjisTable, MasterKanji> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MasterKanjisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kanjiMeta = const VerificationMeta('kanji');
  @override
  late final GeneratedColumn<String> kanji = GeneratedColumn<String>(
    'kanji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unicodeMeta = const VerificationMeta(
    'unicode',
  );
  @override
  late final GeneratedColumn<String> unicode = GeneratedColumn<String>(
    'unicode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jlptLevelMeta = const VerificationMeta(
    'jlptLevel',
  );
  @override
  late final GeneratedColumn<int> jlptLevel = GeneratedColumn<int>(
    'jlpt_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gradeLevelMeta = const VerificationMeta(
    'gradeLevel',
  );
  @override
  late final GeneratedColumn<int> gradeLevel = GeneratedColumn<int>(
    'grade_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _meaningMeta = const VerificationMeta(
    'meaning',
  );
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
    'meaning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kunYomiMeta = const VerificationMeta(
    'kunYomi',
  );
  @override
  late final GeneratedColumn<String> kunYomi = GeneratedColumn<String>(
    'kun_yomi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _onYomiMeta = const VerificationMeta('onYomi');
  @override
  late final GeneratedColumn<String> onYomi = GeneratedColumn<String>(
    'on_yomi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strokeCountMeta = const VerificationMeta(
    'strokeCount',
  );
  @override
  late final GeneratedColumn<int> strokeCount = GeneratedColumn<int>(
    'stroke_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _radicalsMeta = const VerificationMeta(
    'radicals',
  );
  @override
  late final GeneratedColumn<String> radicals = GeneratedColumn<String>(
    'radicals',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strokeOrderDiagramMeta =
      const VerificationMeta('strokeOrderDiagram');
  @override
  late final GeneratedColumn<String> strokeOrderDiagram =
      GeneratedColumn<String>(
        'stroke_order_diagram',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _exampleWordsMeta = const VerificationMeta(
    'exampleWords',
  );
  @override
  late final GeneratedColumn<String> exampleWords = GeneratedColumn<String>(
    'example_words',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _exampleSentencesMeta = const VerificationMeta(
    'exampleSentences',
  );
  @override
  late final GeneratedColumn<String> exampleSentences = GeneratedColumn<String>(
    'example_sentences',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Published'),
  );
  static const VerificationMeta _rtkNumberMeta = const VerificationMeta(
    'rtkNumber',
  );
  @override
  late final GeneratedColumn<int> rtkNumber = GeneratedColumn<int>(
    'rtk_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _frequencyRankMeta = const VerificationMeta(
    'frequencyRank',
  );
  @override
  late final GeneratedColumn<int> frequencyRank = GeneratedColumn<int>(
    'frequency_rank',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pitchAccentMeta = const VerificationMeta(
    'pitchAccent',
  );
  @override
  late final GeneratedColumn<String> pitchAccent = GeneratedColumn<String>(
    'pitch_accent',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioPathMeta = const VerificationMeta(
    'audioPath',
  );
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
    'audio_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _animatedStrokeOrderPathMeta =
      const VerificationMeta('animatedStrokeOrderPath');
  @override
  late final GeneratedColumn<String> animatedStrokeOrderPath =
      GeneratedColumn<String>(
        'animated_stroke_order_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kanji,
    unicode,
    jlptLevel,
    gradeLevel,
    meaning,
    kunYomi,
    onYomi,
    strokeCount,
    radicals,
    strokeOrderDiagram,
    exampleWords,
    exampleSentences,
    notes,
    tags,
    createdAt,
    updatedAt,
    status,
    rtkNumber,
    frequencyRank,
    pitchAccent,
    audioPath,
    animatedStrokeOrderPath,
    syncStatus,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'master_kanjis';
  @override
  VerificationContext validateIntegrity(
    Insertable<MasterKanji> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('kanji')) {
      context.handle(
        _kanjiMeta,
        kanji.isAcceptableOrUnknown(data['kanji']!, _kanjiMeta),
      );
    } else if (isInserting) {
      context.missing(_kanjiMeta);
    }
    if (data.containsKey('unicode')) {
      context.handle(
        _unicodeMeta,
        unicode.isAcceptableOrUnknown(data['unicode']!, _unicodeMeta),
      );
    } else if (isInserting) {
      context.missing(_unicodeMeta);
    }
    if (data.containsKey('jlpt_level')) {
      context.handle(
        _jlptLevelMeta,
        jlptLevel.isAcceptableOrUnknown(data['jlpt_level']!, _jlptLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_jlptLevelMeta);
    }
    if (data.containsKey('grade_level')) {
      context.handle(
        _gradeLevelMeta,
        gradeLevel.isAcceptableOrUnknown(data['grade_level']!, _gradeLevelMeta),
      );
    }
    if (data.containsKey('meaning')) {
      context.handle(
        _meaningMeta,
        meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta),
      );
    } else if (isInserting) {
      context.missing(_meaningMeta);
    }
    if (data.containsKey('kun_yomi')) {
      context.handle(
        _kunYomiMeta,
        kunYomi.isAcceptableOrUnknown(data['kun_yomi']!, _kunYomiMeta),
      );
    } else if (isInserting) {
      context.missing(_kunYomiMeta);
    }
    if (data.containsKey('on_yomi')) {
      context.handle(
        _onYomiMeta,
        onYomi.isAcceptableOrUnknown(data['on_yomi']!, _onYomiMeta),
      );
    } else if (isInserting) {
      context.missing(_onYomiMeta);
    }
    if (data.containsKey('stroke_count')) {
      context.handle(
        _strokeCountMeta,
        strokeCount.isAcceptableOrUnknown(
          data['stroke_count']!,
          _strokeCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_strokeCountMeta);
    }
    if (data.containsKey('radicals')) {
      context.handle(
        _radicalsMeta,
        radicals.isAcceptableOrUnknown(data['radicals']!, _radicalsMeta),
      );
    } else if (isInserting) {
      context.missing(_radicalsMeta);
    }
    if (data.containsKey('stroke_order_diagram')) {
      context.handle(
        _strokeOrderDiagramMeta,
        strokeOrderDiagram.isAcceptableOrUnknown(
          data['stroke_order_diagram']!,
          _strokeOrderDiagramMeta,
        ),
      );
    }
    if (data.containsKey('example_words')) {
      context.handle(
        _exampleWordsMeta,
        exampleWords.isAcceptableOrUnknown(
          data['example_words']!,
          _exampleWordsMeta,
        ),
      );
    }
    if (data.containsKey('example_sentences')) {
      context.handle(
        _exampleSentencesMeta,
        exampleSentences.isAcceptableOrUnknown(
          data['example_sentences']!,
          _exampleSentencesMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('rtk_number')) {
      context.handle(
        _rtkNumberMeta,
        rtkNumber.isAcceptableOrUnknown(data['rtk_number']!, _rtkNumberMeta),
      );
    }
    if (data.containsKey('frequency_rank')) {
      context.handle(
        _frequencyRankMeta,
        frequencyRank.isAcceptableOrUnknown(
          data['frequency_rank']!,
          _frequencyRankMeta,
        ),
      );
    }
    if (data.containsKey('pitch_accent')) {
      context.handle(
        _pitchAccentMeta,
        pitchAccent.isAcceptableOrUnknown(
          data['pitch_accent']!,
          _pitchAccentMeta,
        ),
      );
    }
    if (data.containsKey('audio_path')) {
      context.handle(
        _audioPathMeta,
        audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta),
      );
    }
    if (data.containsKey('animated_stroke_order_path')) {
      context.handle(
        _animatedStrokeOrderPathMeta,
        animatedStrokeOrderPath.isAcceptableOrUnknown(
          data['animated_stroke_order_path']!,
          _animatedStrokeOrderPathMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MasterKanji map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MasterKanji(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      kanji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kanji'],
      )!,
      unicode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unicode'],
      )!,
      jlptLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jlpt_level'],
      )!,
      gradeLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grade_level'],
      ),
      meaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meaning'],
      )!,
      kunYomi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kun_yomi'],
      )!,
      onYomi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}on_yomi'],
      )!,
      strokeCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stroke_count'],
      )!,
      radicals: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}radicals'],
      )!,
      strokeOrderDiagram: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stroke_order_diagram'],
      ),
      exampleWords: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}example_words'],
      )!,
      exampleSentences: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}example_sentences'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      rtkNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rtk_number'],
      ),
      frequencyRank: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frequency_rank'],
      ),
      pitchAccent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pitch_accent'],
      ),
      audioPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_path'],
      ),
      animatedStrokeOrderPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animated_stroke_order_path'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $MasterKanjisTable createAlias(String alias) {
    return $MasterKanjisTable(attachedDatabase, alias);
  }
}

class MasterKanji extends DataClass implements Insertable<MasterKanji> {
  final String id;
  final String kanji;
  final String unicode;
  final int jlptLevel;
  final int? gradeLevel;
  final String meaning;
  final String kunYomi;
  final String onYomi;
  final int strokeCount;
  final String radicals;
  final String? strokeOrderDiagram;
  final String exampleWords;
  final String exampleSentences;
  final String notes;
  final String tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final int? rtkNumber;
  final int? frequencyRank;
  final String? pitchAccent;
  final String? audioPath;
  final String? animatedStrokeOrderPath;
  final String? syncStatus;
  final DateTime? lastSyncedAt;
  const MasterKanji({
    required this.id,
    required this.kanji,
    required this.unicode,
    required this.jlptLevel,
    this.gradeLevel,
    required this.meaning,
    required this.kunYomi,
    required this.onYomi,
    required this.strokeCount,
    required this.radicals,
    this.strokeOrderDiagram,
    required this.exampleWords,
    required this.exampleSentences,
    required this.notes,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.rtkNumber,
    this.frequencyRank,
    this.pitchAccent,
    this.audioPath,
    this.animatedStrokeOrderPath,
    this.syncStatus,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['kanji'] = Variable<String>(kanji);
    map['unicode'] = Variable<String>(unicode);
    map['jlpt_level'] = Variable<int>(jlptLevel);
    if (!nullToAbsent || gradeLevel != null) {
      map['grade_level'] = Variable<int>(gradeLevel);
    }
    map['meaning'] = Variable<String>(meaning);
    map['kun_yomi'] = Variable<String>(kunYomi);
    map['on_yomi'] = Variable<String>(onYomi);
    map['stroke_count'] = Variable<int>(strokeCount);
    map['radicals'] = Variable<String>(radicals);
    if (!nullToAbsent || strokeOrderDiagram != null) {
      map['stroke_order_diagram'] = Variable<String>(strokeOrderDiagram);
    }
    map['example_words'] = Variable<String>(exampleWords);
    map['example_sentences'] = Variable<String>(exampleSentences);
    map['notes'] = Variable<String>(notes);
    map['tags'] = Variable<String>(tags);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || rtkNumber != null) {
      map['rtk_number'] = Variable<int>(rtkNumber);
    }
    if (!nullToAbsent || frequencyRank != null) {
      map['frequency_rank'] = Variable<int>(frequencyRank);
    }
    if (!nullToAbsent || pitchAccent != null) {
      map['pitch_accent'] = Variable<String>(pitchAccent);
    }
    if (!nullToAbsent || audioPath != null) {
      map['audio_path'] = Variable<String>(audioPath);
    }
    if (!nullToAbsent || animatedStrokeOrderPath != null) {
      map['animated_stroke_order_path'] = Variable<String>(
        animatedStrokeOrderPath,
      );
    }
    if (!nullToAbsent || syncStatus != null) {
      map['sync_status'] = Variable<String>(syncStatus);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  MasterKanjisCompanion toCompanion(bool nullToAbsent) {
    return MasterKanjisCompanion(
      id: Value(id),
      kanji: Value(kanji),
      unicode: Value(unicode),
      jlptLevel: Value(jlptLevel),
      gradeLevel: gradeLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(gradeLevel),
      meaning: Value(meaning),
      kunYomi: Value(kunYomi),
      onYomi: Value(onYomi),
      strokeCount: Value(strokeCount),
      radicals: Value(radicals),
      strokeOrderDiagram: strokeOrderDiagram == null && nullToAbsent
          ? const Value.absent()
          : Value(strokeOrderDiagram),
      exampleWords: Value(exampleWords),
      exampleSentences: Value(exampleSentences),
      notes: Value(notes),
      tags: Value(tags),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      status: Value(status),
      rtkNumber: rtkNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(rtkNumber),
      frequencyRank: frequencyRank == null && nullToAbsent
          ? const Value.absent()
          : Value(frequencyRank),
      pitchAccent: pitchAccent == null && nullToAbsent
          ? const Value.absent()
          : Value(pitchAccent),
      audioPath: audioPath == null && nullToAbsent
          ? const Value.absent()
          : Value(audioPath),
      animatedStrokeOrderPath: animatedStrokeOrderPath == null && nullToAbsent
          ? const Value.absent()
          : Value(animatedStrokeOrderPath),
      syncStatus: syncStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory MasterKanji.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MasterKanji(
      id: serializer.fromJson<String>(json['id']),
      kanji: serializer.fromJson<String>(json['kanji']),
      unicode: serializer.fromJson<String>(json['unicode']),
      jlptLevel: serializer.fromJson<int>(json['jlptLevel']),
      gradeLevel: serializer.fromJson<int?>(json['gradeLevel']),
      meaning: serializer.fromJson<String>(json['meaning']),
      kunYomi: serializer.fromJson<String>(json['kunYomi']),
      onYomi: serializer.fromJson<String>(json['onYomi']),
      strokeCount: serializer.fromJson<int>(json['strokeCount']),
      radicals: serializer.fromJson<String>(json['radicals']),
      strokeOrderDiagram: serializer.fromJson<String?>(
        json['strokeOrderDiagram'],
      ),
      exampleWords: serializer.fromJson<String>(json['exampleWords']),
      exampleSentences: serializer.fromJson<String>(json['exampleSentences']),
      notes: serializer.fromJson<String>(json['notes']),
      tags: serializer.fromJson<String>(json['tags']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      status: serializer.fromJson<String>(json['status']),
      rtkNumber: serializer.fromJson<int?>(json['rtkNumber']),
      frequencyRank: serializer.fromJson<int?>(json['frequencyRank']),
      pitchAccent: serializer.fromJson<String?>(json['pitchAccent']),
      audioPath: serializer.fromJson<String?>(json['audioPath']),
      animatedStrokeOrderPath: serializer.fromJson<String?>(
        json['animatedStrokeOrderPath'],
      ),
      syncStatus: serializer.fromJson<String?>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'kanji': serializer.toJson<String>(kanji),
      'unicode': serializer.toJson<String>(unicode),
      'jlptLevel': serializer.toJson<int>(jlptLevel),
      'gradeLevel': serializer.toJson<int?>(gradeLevel),
      'meaning': serializer.toJson<String>(meaning),
      'kunYomi': serializer.toJson<String>(kunYomi),
      'onYomi': serializer.toJson<String>(onYomi),
      'strokeCount': serializer.toJson<int>(strokeCount),
      'radicals': serializer.toJson<String>(radicals),
      'strokeOrderDiagram': serializer.toJson<String?>(strokeOrderDiagram),
      'exampleWords': serializer.toJson<String>(exampleWords),
      'exampleSentences': serializer.toJson<String>(exampleSentences),
      'notes': serializer.toJson<String>(notes),
      'tags': serializer.toJson<String>(tags),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'status': serializer.toJson<String>(status),
      'rtkNumber': serializer.toJson<int?>(rtkNumber),
      'frequencyRank': serializer.toJson<int?>(frequencyRank),
      'pitchAccent': serializer.toJson<String?>(pitchAccent),
      'audioPath': serializer.toJson<String?>(audioPath),
      'animatedStrokeOrderPath': serializer.toJson<String?>(
        animatedStrokeOrderPath,
      ),
      'syncStatus': serializer.toJson<String?>(syncStatus),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  MasterKanji copyWith({
    String? id,
    String? kanji,
    String? unicode,
    int? jlptLevel,
    Value<int?> gradeLevel = const Value.absent(),
    String? meaning,
    String? kunYomi,
    String? onYomi,
    int? strokeCount,
    String? radicals,
    Value<String?> strokeOrderDiagram = const Value.absent(),
    String? exampleWords,
    String? exampleSentences,
    String? notes,
    String? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    Value<int?> rtkNumber = const Value.absent(),
    Value<int?> frequencyRank = const Value.absent(),
    Value<String?> pitchAccent = const Value.absent(),
    Value<String?> audioPath = const Value.absent(),
    Value<String?> animatedStrokeOrderPath = const Value.absent(),
    Value<String?> syncStatus = const Value.absent(),
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => MasterKanji(
    id: id ?? this.id,
    kanji: kanji ?? this.kanji,
    unicode: unicode ?? this.unicode,
    jlptLevel: jlptLevel ?? this.jlptLevel,
    gradeLevel: gradeLevel.present ? gradeLevel.value : this.gradeLevel,
    meaning: meaning ?? this.meaning,
    kunYomi: kunYomi ?? this.kunYomi,
    onYomi: onYomi ?? this.onYomi,
    strokeCount: strokeCount ?? this.strokeCount,
    radicals: radicals ?? this.radicals,
    strokeOrderDiagram: strokeOrderDiagram.present
        ? strokeOrderDiagram.value
        : this.strokeOrderDiagram,
    exampleWords: exampleWords ?? this.exampleWords,
    exampleSentences: exampleSentences ?? this.exampleSentences,
    notes: notes ?? this.notes,
    tags: tags ?? this.tags,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    status: status ?? this.status,
    rtkNumber: rtkNumber.present ? rtkNumber.value : this.rtkNumber,
    frequencyRank: frequencyRank.present
        ? frequencyRank.value
        : this.frequencyRank,
    pitchAccent: pitchAccent.present ? pitchAccent.value : this.pitchAccent,
    audioPath: audioPath.present ? audioPath.value : this.audioPath,
    animatedStrokeOrderPath: animatedStrokeOrderPath.present
        ? animatedStrokeOrderPath.value
        : this.animatedStrokeOrderPath,
    syncStatus: syncStatus.present ? syncStatus.value : this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  MasterKanji copyWithCompanion(MasterKanjisCompanion data) {
    return MasterKanji(
      id: data.id.present ? data.id.value : this.id,
      kanji: data.kanji.present ? data.kanji.value : this.kanji,
      unicode: data.unicode.present ? data.unicode.value : this.unicode,
      jlptLevel: data.jlptLevel.present ? data.jlptLevel.value : this.jlptLevel,
      gradeLevel: data.gradeLevel.present
          ? data.gradeLevel.value
          : this.gradeLevel,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
      kunYomi: data.kunYomi.present ? data.kunYomi.value : this.kunYomi,
      onYomi: data.onYomi.present ? data.onYomi.value : this.onYomi,
      strokeCount: data.strokeCount.present
          ? data.strokeCount.value
          : this.strokeCount,
      radicals: data.radicals.present ? data.radicals.value : this.radicals,
      strokeOrderDiagram: data.strokeOrderDiagram.present
          ? data.strokeOrderDiagram.value
          : this.strokeOrderDiagram,
      exampleWords: data.exampleWords.present
          ? data.exampleWords.value
          : this.exampleWords,
      exampleSentences: data.exampleSentences.present
          ? data.exampleSentences.value
          : this.exampleSentences,
      notes: data.notes.present ? data.notes.value : this.notes,
      tags: data.tags.present ? data.tags.value : this.tags,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      status: data.status.present ? data.status.value : this.status,
      rtkNumber: data.rtkNumber.present ? data.rtkNumber.value : this.rtkNumber,
      frequencyRank: data.frequencyRank.present
          ? data.frequencyRank.value
          : this.frequencyRank,
      pitchAccent: data.pitchAccent.present
          ? data.pitchAccent.value
          : this.pitchAccent,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
      animatedStrokeOrderPath: data.animatedStrokeOrderPath.present
          ? data.animatedStrokeOrderPath.value
          : this.animatedStrokeOrderPath,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MasterKanji(')
          ..write('id: $id, ')
          ..write('kanji: $kanji, ')
          ..write('unicode: $unicode, ')
          ..write('jlptLevel: $jlptLevel, ')
          ..write('gradeLevel: $gradeLevel, ')
          ..write('meaning: $meaning, ')
          ..write('kunYomi: $kunYomi, ')
          ..write('onYomi: $onYomi, ')
          ..write('strokeCount: $strokeCount, ')
          ..write('radicals: $radicals, ')
          ..write('strokeOrderDiagram: $strokeOrderDiagram, ')
          ..write('exampleWords: $exampleWords, ')
          ..write('exampleSentences: $exampleSentences, ')
          ..write('notes: $notes, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('rtkNumber: $rtkNumber, ')
          ..write('frequencyRank: $frequencyRank, ')
          ..write('pitchAccent: $pitchAccent, ')
          ..write('audioPath: $audioPath, ')
          ..write('animatedStrokeOrderPath: $animatedStrokeOrderPath, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    kanji,
    unicode,
    jlptLevel,
    gradeLevel,
    meaning,
    kunYomi,
    onYomi,
    strokeCount,
    radicals,
    strokeOrderDiagram,
    exampleWords,
    exampleSentences,
    notes,
    tags,
    createdAt,
    updatedAt,
    status,
    rtkNumber,
    frequencyRank,
    pitchAccent,
    audioPath,
    animatedStrokeOrderPath,
    syncStatus,
    lastSyncedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MasterKanji &&
          other.id == this.id &&
          other.kanji == this.kanji &&
          other.unicode == this.unicode &&
          other.jlptLevel == this.jlptLevel &&
          other.gradeLevel == this.gradeLevel &&
          other.meaning == this.meaning &&
          other.kunYomi == this.kunYomi &&
          other.onYomi == this.onYomi &&
          other.strokeCount == this.strokeCount &&
          other.radicals == this.radicals &&
          other.strokeOrderDiagram == this.strokeOrderDiagram &&
          other.exampleWords == this.exampleWords &&
          other.exampleSentences == this.exampleSentences &&
          other.notes == this.notes &&
          other.tags == this.tags &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.status == this.status &&
          other.rtkNumber == this.rtkNumber &&
          other.frequencyRank == this.frequencyRank &&
          other.pitchAccent == this.pitchAccent &&
          other.audioPath == this.audioPath &&
          other.animatedStrokeOrderPath == this.animatedStrokeOrderPath &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class MasterKanjisCompanion extends UpdateCompanion<MasterKanji> {
  final Value<String> id;
  final Value<String> kanji;
  final Value<String> unicode;
  final Value<int> jlptLevel;
  final Value<int?> gradeLevel;
  final Value<String> meaning;
  final Value<String> kunYomi;
  final Value<String> onYomi;
  final Value<int> strokeCount;
  final Value<String> radicals;
  final Value<String?> strokeOrderDiagram;
  final Value<String> exampleWords;
  final Value<String> exampleSentences;
  final Value<String> notes;
  final Value<String> tags;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> status;
  final Value<int?> rtkNumber;
  final Value<int?> frequencyRank;
  final Value<String?> pitchAccent;
  final Value<String?> audioPath;
  final Value<String?> animatedStrokeOrderPath;
  final Value<String?> syncStatus;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const MasterKanjisCompanion({
    this.id = const Value.absent(),
    this.kanji = const Value.absent(),
    this.unicode = const Value.absent(),
    this.jlptLevel = const Value.absent(),
    this.gradeLevel = const Value.absent(),
    this.meaning = const Value.absent(),
    this.kunYomi = const Value.absent(),
    this.onYomi = const Value.absent(),
    this.strokeCount = const Value.absent(),
    this.radicals = const Value.absent(),
    this.strokeOrderDiagram = const Value.absent(),
    this.exampleWords = const Value.absent(),
    this.exampleSentences = const Value.absent(),
    this.notes = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rtkNumber = const Value.absent(),
    this.frequencyRank = const Value.absent(),
    this.pitchAccent = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.animatedStrokeOrderPath = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MasterKanjisCompanion.insert({
    required String id,
    required String kanji,
    required String unicode,
    required int jlptLevel,
    this.gradeLevel = const Value.absent(),
    required String meaning,
    required String kunYomi,
    required String onYomi,
    required int strokeCount,
    required String radicals,
    this.strokeOrderDiagram = const Value.absent(),
    this.exampleWords = const Value.absent(),
    this.exampleSentences = const Value.absent(),
    this.notes = const Value.absent(),
    this.tags = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.status = const Value.absent(),
    this.rtkNumber = const Value.absent(),
    this.frequencyRank = const Value.absent(),
    this.pitchAccent = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.animatedStrokeOrderPath = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       kanji = Value(kanji),
       unicode = Value(unicode),
       jlptLevel = Value(jlptLevel),
       meaning = Value(meaning),
       kunYomi = Value(kunYomi),
       onYomi = Value(onYomi),
       strokeCount = Value(strokeCount),
       radicals = Value(radicals),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MasterKanji> custom({
    Expression<String>? id,
    Expression<String>? kanji,
    Expression<String>? unicode,
    Expression<int>? jlptLevel,
    Expression<int>? gradeLevel,
    Expression<String>? meaning,
    Expression<String>? kunYomi,
    Expression<String>? onYomi,
    Expression<int>? strokeCount,
    Expression<String>? radicals,
    Expression<String>? strokeOrderDiagram,
    Expression<String>? exampleWords,
    Expression<String>? exampleSentences,
    Expression<String>? notes,
    Expression<String>? tags,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? status,
    Expression<int>? rtkNumber,
    Expression<int>? frequencyRank,
    Expression<String>? pitchAccent,
    Expression<String>? audioPath,
    Expression<String>? animatedStrokeOrderPath,
    Expression<String>? syncStatus,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanji != null) 'kanji': kanji,
      if (unicode != null) 'unicode': unicode,
      if (jlptLevel != null) 'jlpt_level': jlptLevel,
      if (gradeLevel != null) 'grade_level': gradeLevel,
      if (meaning != null) 'meaning': meaning,
      if (kunYomi != null) 'kun_yomi': kunYomi,
      if (onYomi != null) 'on_yomi': onYomi,
      if (strokeCount != null) 'stroke_count': strokeCount,
      if (radicals != null) 'radicals': radicals,
      if (strokeOrderDiagram != null)
        'stroke_order_diagram': strokeOrderDiagram,
      if (exampleWords != null) 'example_words': exampleWords,
      if (exampleSentences != null) 'example_sentences': exampleSentences,
      if (notes != null) 'notes': notes,
      if (tags != null) 'tags': tags,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (status != null) 'status': status,
      if (rtkNumber != null) 'rtk_number': rtkNumber,
      if (frequencyRank != null) 'frequency_rank': frequencyRank,
      if (pitchAccent != null) 'pitch_accent': pitchAccent,
      if (audioPath != null) 'audio_path': audioPath,
      if (animatedStrokeOrderPath != null)
        'animated_stroke_order_path': animatedStrokeOrderPath,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MasterKanjisCompanion copyWith({
    Value<String>? id,
    Value<String>? kanji,
    Value<String>? unicode,
    Value<int>? jlptLevel,
    Value<int?>? gradeLevel,
    Value<String>? meaning,
    Value<String>? kunYomi,
    Value<String>? onYomi,
    Value<int>? strokeCount,
    Value<String>? radicals,
    Value<String?>? strokeOrderDiagram,
    Value<String>? exampleWords,
    Value<String>? exampleSentences,
    Value<String>? notes,
    Value<String>? tags,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? status,
    Value<int?>? rtkNumber,
    Value<int?>? frequencyRank,
    Value<String?>? pitchAccent,
    Value<String?>? audioPath,
    Value<String?>? animatedStrokeOrderPath,
    Value<String?>? syncStatus,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return MasterKanjisCompanion(
      id: id ?? this.id,
      kanji: kanji ?? this.kanji,
      unicode: unicode ?? this.unicode,
      jlptLevel: jlptLevel ?? this.jlptLevel,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      meaning: meaning ?? this.meaning,
      kunYomi: kunYomi ?? this.kunYomi,
      onYomi: onYomi ?? this.onYomi,
      strokeCount: strokeCount ?? this.strokeCount,
      radicals: radicals ?? this.radicals,
      strokeOrderDiagram: strokeOrderDiagram ?? this.strokeOrderDiagram,
      exampleWords: exampleWords ?? this.exampleWords,
      exampleSentences: exampleSentences ?? this.exampleSentences,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      rtkNumber: rtkNumber ?? this.rtkNumber,
      frequencyRank: frequencyRank ?? this.frequencyRank,
      pitchAccent: pitchAccent ?? this.pitchAccent,
      audioPath: audioPath ?? this.audioPath,
      animatedStrokeOrderPath:
          animatedStrokeOrderPath ?? this.animatedStrokeOrderPath,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kanji.present) {
      map['kanji'] = Variable<String>(kanji.value);
    }
    if (unicode.present) {
      map['unicode'] = Variable<String>(unicode.value);
    }
    if (jlptLevel.present) {
      map['jlpt_level'] = Variable<int>(jlptLevel.value);
    }
    if (gradeLevel.present) {
      map['grade_level'] = Variable<int>(gradeLevel.value);
    }
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    if (kunYomi.present) {
      map['kun_yomi'] = Variable<String>(kunYomi.value);
    }
    if (onYomi.present) {
      map['on_yomi'] = Variable<String>(onYomi.value);
    }
    if (strokeCount.present) {
      map['stroke_count'] = Variable<int>(strokeCount.value);
    }
    if (radicals.present) {
      map['radicals'] = Variable<String>(radicals.value);
    }
    if (strokeOrderDiagram.present) {
      map['stroke_order_diagram'] = Variable<String>(strokeOrderDiagram.value);
    }
    if (exampleWords.present) {
      map['example_words'] = Variable<String>(exampleWords.value);
    }
    if (exampleSentences.present) {
      map['example_sentences'] = Variable<String>(exampleSentences.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rtkNumber.present) {
      map['rtk_number'] = Variable<int>(rtkNumber.value);
    }
    if (frequencyRank.present) {
      map['frequency_rank'] = Variable<int>(frequencyRank.value);
    }
    if (pitchAccent.present) {
      map['pitch_accent'] = Variable<String>(pitchAccent.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    if (animatedStrokeOrderPath.present) {
      map['animated_stroke_order_path'] = Variable<String>(
        animatedStrokeOrderPath.value,
      );
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MasterKanjisCompanion(')
          ..write('id: $id, ')
          ..write('kanji: $kanji, ')
          ..write('unicode: $unicode, ')
          ..write('jlptLevel: $jlptLevel, ')
          ..write('gradeLevel: $gradeLevel, ')
          ..write('meaning: $meaning, ')
          ..write('kunYomi: $kunYomi, ')
          ..write('onYomi: $onYomi, ')
          ..write('strokeCount: $strokeCount, ')
          ..write('radicals: $radicals, ')
          ..write('strokeOrderDiagram: $strokeOrderDiagram, ')
          ..write('exampleWords: $exampleWords, ')
          ..write('exampleSentences: $exampleSentences, ')
          ..write('notes: $notes, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('rtkNumber: $rtkNumber, ')
          ..write('frequencyRank: $frequencyRank, ')
          ..write('pitchAccent: $pitchAccent, ')
          ..write('audioPath: $audioPath, ')
          ..write('animatedStrokeOrderPath: $animatedStrokeOrderPath, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserKanjisTable extends UserKanjis
    with TableInfo<$UserKanjisTable, UserKanji> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserKanjisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _masterKanjiIdMeta = const VerificationMeta(
    'masterKanjiId',
  );
  @override
  late final GeneratedColumn<String> masterKanjiId = GeneratedColumn<String>(
    'master_kanji_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_kanjis(id) ON DELETE CASCADE NOT NULL',
  );
  static const VerificationMeta _isAddedMeta = const VerificationMeta(
    'isAdded',
  );
  @override
  late final GeneratedColumn<bool> isAdded = GeneratedColumn<bool>(
    'is_added',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_added" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isLearnedMeta = const VerificationMeta(
    'isLearned',
  );
  @override
  late final GeneratedColumn<bool> isLearned = GeneratedColumn<bool>(
    'is_learned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_learned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _easeFactorMeta = const VerificationMeta(
    'easeFactor',
  );
  @override
  late final GeneratedColumn<double> easeFactor = GeneratedColumn<double>(
    'ease_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.5),
  );
  static const VerificationMeta _nextReviewMeta = const VerificationMeta(
    'nextReview',
  );
  @override
  late final GeneratedColumn<DateTime> nextReview = GeneratedColumn<DateTime>(
    'next_review',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastReviewedMeta = const VerificationMeta(
    'lastReviewed',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewed = GeneratedColumn<DateTime>(
    'last_reviewed',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customNotesMeta = const VerificationMeta(
    'customNotes',
  );
  @override
  late final GeneratedColumn<String> customNotes = GeneratedColumn<String>(
    'custom_notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    masterKanjiId,
    isAdded,
    isLearned,
    isFavorite,
    reviewCount,
    easeFactor,
    nextReview,
    lastReviewed,
    customNotes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_kanjis';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserKanji> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('master_kanji_id')) {
      context.handle(
        _masterKanjiIdMeta,
        masterKanjiId.isAcceptableOrUnknown(
          data['master_kanji_id']!,
          _masterKanjiIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_masterKanjiIdMeta);
    }
    if (data.containsKey('is_added')) {
      context.handle(
        _isAddedMeta,
        isAdded.isAcceptableOrUnknown(data['is_added']!, _isAddedMeta),
      );
    }
    if (data.containsKey('is_learned')) {
      context.handle(
        _isLearnedMeta,
        isLearned.isAcceptableOrUnknown(data['is_learned']!, _isLearnedMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    }
    if (data.containsKey('ease_factor')) {
      context.handle(
        _easeFactorMeta,
        easeFactor.isAcceptableOrUnknown(data['ease_factor']!, _easeFactorMeta),
      );
    }
    if (data.containsKey('next_review')) {
      context.handle(
        _nextReviewMeta,
        nextReview.isAcceptableOrUnknown(data['next_review']!, _nextReviewMeta),
      );
    }
    if (data.containsKey('last_reviewed')) {
      context.handle(
        _lastReviewedMeta,
        lastReviewed.isAcceptableOrUnknown(
          data['last_reviewed']!,
          _lastReviewedMeta,
        ),
      );
    }
    if (data.containsKey('custom_notes')) {
      context.handle(
        _customNotesMeta,
        customNotes.isAcceptableOrUnknown(
          data['custom_notes']!,
          _customNotesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserKanji map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserKanji(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      masterKanjiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}master_kanji_id'],
      )!,
      isAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_added'],
      )!,
      isLearned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_learned'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      reviewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_count'],
      )!,
      easeFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ease_factor'],
      )!,
      nextReview: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_review'],
      ),
      lastReviewed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reviewed'],
      ),
      customNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserKanjisTable createAlias(String alias) {
    return $UserKanjisTable(attachedDatabase, alias);
  }
}

class UserKanji extends DataClass implements Insertable<UserKanji> {
  final String id;
  final String masterKanjiId;
  final bool isAdded;
  final bool isLearned;
  final bool isFavorite;
  final int reviewCount;
  final double easeFactor;
  final DateTime? nextReview;
  final DateTime? lastReviewed;
  final String customNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserKanji({
    required this.id,
    required this.masterKanjiId,
    required this.isAdded,
    required this.isLearned,
    required this.isFavorite,
    required this.reviewCount,
    required this.easeFactor,
    this.nextReview,
    this.lastReviewed,
    required this.customNotes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['master_kanji_id'] = Variable<String>(masterKanjiId);
    map['is_added'] = Variable<bool>(isAdded);
    map['is_learned'] = Variable<bool>(isLearned);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['review_count'] = Variable<int>(reviewCount);
    map['ease_factor'] = Variable<double>(easeFactor);
    if (!nullToAbsent || nextReview != null) {
      map['next_review'] = Variable<DateTime>(nextReview);
    }
    if (!nullToAbsent || lastReviewed != null) {
      map['last_reviewed'] = Variable<DateTime>(lastReviewed);
    }
    map['custom_notes'] = Variable<String>(customNotes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserKanjisCompanion toCompanion(bool nullToAbsent) {
    return UserKanjisCompanion(
      id: Value(id),
      masterKanjiId: Value(masterKanjiId),
      isAdded: Value(isAdded),
      isLearned: Value(isLearned),
      isFavorite: Value(isFavorite),
      reviewCount: Value(reviewCount),
      easeFactor: Value(easeFactor),
      nextReview: nextReview == null && nullToAbsent
          ? const Value.absent()
          : Value(nextReview),
      lastReviewed: lastReviewed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewed),
      customNotes: Value(customNotes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserKanji.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserKanji(
      id: serializer.fromJson<String>(json['id']),
      masterKanjiId: serializer.fromJson<String>(json['masterKanjiId']),
      isAdded: serializer.fromJson<bool>(json['isAdded']),
      isLearned: serializer.fromJson<bool>(json['isLearned']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      easeFactor: serializer.fromJson<double>(json['easeFactor']),
      nextReview: serializer.fromJson<DateTime?>(json['nextReview']),
      lastReviewed: serializer.fromJson<DateTime?>(json['lastReviewed']),
      customNotes: serializer.fromJson<String>(json['customNotes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'masterKanjiId': serializer.toJson<String>(masterKanjiId),
      'isAdded': serializer.toJson<bool>(isAdded),
      'isLearned': serializer.toJson<bool>(isLearned),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'easeFactor': serializer.toJson<double>(easeFactor),
      'nextReview': serializer.toJson<DateTime?>(nextReview),
      'lastReviewed': serializer.toJson<DateTime?>(lastReviewed),
      'customNotes': serializer.toJson<String>(customNotes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserKanji copyWith({
    String? id,
    String? masterKanjiId,
    bool? isAdded,
    bool? isLearned,
    bool? isFavorite,
    int? reviewCount,
    double? easeFactor,
    Value<DateTime?> nextReview = const Value.absent(),
    Value<DateTime?> lastReviewed = const Value.absent(),
    String? customNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserKanji(
    id: id ?? this.id,
    masterKanjiId: masterKanjiId ?? this.masterKanjiId,
    isAdded: isAdded ?? this.isAdded,
    isLearned: isLearned ?? this.isLearned,
    isFavorite: isFavorite ?? this.isFavorite,
    reviewCount: reviewCount ?? this.reviewCount,
    easeFactor: easeFactor ?? this.easeFactor,
    nextReview: nextReview.present ? nextReview.value : this.nextReview,
    lastReviewed: lastReviewed.present ? lastReviewed.value : this.lastReviewed,
    customNotes: customNotes ?? this.customNotes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserKanji copyWithCompanion(UserKanjisCompanion data) {
    return UserKanji(
      id: data.id.present ? data.id.value : this.id,
      masterKanjiId: data.masterKanjiId.present
          ? data.masterKanjiId.value
          : this.masterKanjiId,
      isAdded: data.isAdded.present ? data.isAdded.value : this.isAdded,
      isLearned: data.isLearned.present ? data.isLearned.value : this.isLearned,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      reviewCount: data.reviewCount.present
          ? data.reviewCount.value
          : this.reviewCount,
      easeFactor: data.easeFactor.present
          ? data.easeFactor.value
          : this.easeFactor,
      nextReview: data.nextReview.present
          ? data.nextReview.value
          : this.nextReview,
      lastReviewed: data.lastReviewed.present
          ? data.lastReviewed.value
          : this.lastReviewed,
      customNotes: data.customNotes.present
          ? data.customNotes.value
          : this.customNotes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserKanji(')
          ..write('id: $id, ')
          ..write('masterKanjiId: $masterKanjiId, ')
          ..write('isAdded: $isAdded, ')
          ..write('isLearned: $isLearned, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('nextReview: $nextReview, ')
          ..write('lastReviewed: $lastReviewed, ')
          ..write('customNotes: $customNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    masterKanjiId,
    isAdded,
    isLearned,
    isFavorite,
    reviewCount,
    easeFactor,
    nextReview,
    lastReviewed,
    customNotes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserKanji &&
          other.id == this.id &&
          other.masterKanjiId == this.masterKanjiId &&
          other.isAdded == this.isAdded &&
          other.isLearned == this.isLearned &&
          other.isFavorite == this.isFavorite &&
          other.reviewCount == this.reviewCount &&
          other.easeFactor == this.easeFactor &&
          other.nextReview == this.nextReview &&
          other.lastReviewed == this.lastReviewed &&
          other.customNotes == this.customNotes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserKanjisCompanion extends UpdateCompanion<UserKanji> {
  final Value<String> id;
  final Value<String> masterKanjiId;
  final Value<bool> isAdded;
  final Value<bool> isLearned;
  final Value<bool> isFavorite;
  final Value<int> reviewCount;
  final Value<double> easeFactor;
  final Value<DateTime?> nextReview;
  final Value<DateTime?> lastReviewed;
  final Value<String> customNotes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserKanjisCompanion({
    this.id = const Value.absent(),
    this.masterKanjiId = const Value.absent(),
    this.isAdded = const Value.absent(),
    this.isLearned = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.nextReview = const Value.absent(),
    this.lastReviewed = const Value.absent(),
    this.customNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserKanjisCompanion.insert({
    required String id,
    required String masterKanjiId,
    this.isAdded = const Value.absent(),
    this.isLearned = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.nextReview = const Value.absent(),
    this.lastReviewed = const Value.absent(),
    this.customNotes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       masterKanjiId = Value(masterKanjiId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserKanji> custom({
    Expression<String>? id,
    Expression<String>? masterKanjiId,
    Expression<bool>? isAdded,
    Expression<bool>? isLearned,
    Expression<bool>? isFavorite,
    Expression<int>? reviewCount,
    Expression<double>? easeFactor,
    Expression<DateTime>? nextReview,
    Expression<DateTime>? lastReviewed,
    Expression<String>? customNotes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (masterKanjiId != null) 'master_kanji_id': masterKanjiId,
      if (isAdded != null) 'is_added': isAdded,
      if (isLearned != null) 'is_learned': isLearned,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (reviewCount != null) 'review_count': reviewCount,
      if (easeFactor != null) 'ease_factor': easeFactor,
      if (nextReview != null) 'next_review': nextReview,
      if (lastReviewed != null) 'last_reviewed': lastReviewed,
      if (customNotes != null) 'custom_notes': customNotes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserKanjisCompanion copyWith({
    Value<String>? id,
    Value<String>? masterKanjiId,
    Value<bool>? isAdded,
    Value<bool>? isLearned,
    Value<bool>? isFavorite,
    Value<int>? reviewCount,
    Value<double>? easeFactor,
    Value<DateTime?>? nextReview,
    Value<DateTime?>? lastReviewed,
    Value<String>? customNotes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserKanjisCompanion(
      id: id ?? this.id,
      masterKanjiId: masterKanjiId ?? this.masterKanjiId,
      isAdded: isAdded ?? this.isAdded,
      isLearned: isLearned ?? this.isLearned,
      isFavorite: isFavorite ?? this.isFavorite,
      reviewCount: reviewCount ?? this.reviewCount,
      easeFactor: easeFactor ?? this.easeFactor,
      nextReview: nextReview ?? this.nextReview,
      lastReviewed: lastReviewed ?? this.lastReviewed,
      customNotes: customNotes ?? this.customNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (masterKanjiId.present) {
      map['master_kanji_id'] = Variable<String>(masterKanjiId.value);
    }
    if (isAdded.present) {
      map['is_added'] = Variable<bool>(isAdded.value);
    }
    if (isLearned.present) {
      map['is_learned'] = Variable<bool>(isLearned.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (easeFactor.present) {
      map['ease_factor'] = Variable<double>(easeFactor.value);
    }
    if (nextReview.present) {
      map['next_review'] = Variable<DateTime>(nextReview.value);
    }
    if (lastReviewed.present) {
      map['last_reviewed'] = Variable<DateTime>(lastReviewed.value);
    }
    if (customNotes.present) {
      map['custom_notes'] = Variable<String>(customNotes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserKanjisCompanion(')
          ..write('id: $id, ')
          ..write('masterKanjiId: $masterKanjiId, ')
          ..write('isAdded: $isAdded, ')
          ..write('isLearned: $isLearned, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('nextReview: $nextReview, ')
          ..write('lastReviewed: $lastReviewed, ')
          ..write('customNotes: $customNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MasterVocabulariesTable extends MasterVocabularies
    with TableInfo<$MasterVocabulariesTable, MasterVocabulary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MasterVocabulariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kanaMeta = const VerificationMeta('kana');
  @override
  late final GeneratedColumn<String> kana = GeneratedColumn<String>(
    'kana',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meaningMeta = const VerificationMeta(
    'meaning',
  );
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
    'meaning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jlptLevelMeta = const VerificationMeta(
    'jlptLevel',
  );
  @override
  late final GeneratedColumn<int> jlptLevel = GeneratedColumn<int>(
    'jlpt_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<int> frequency = GeneratedColumn<int>(
    'frequency',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relatedKanjiMeta = const VerificationMeta(
    'relatedKanji',
  );
  @override
  late final GeneratedColumn<String> relatedKanji = GeneratedColumn<String>(
    'related_kanji',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exampleSentencesMeta = const VerificationMeta(
    'exampleSentences',
  );
  @override
  late final GeneratedColumn<String> exampleSentences = GeneratedColumn<String>(
    'example_sentences',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _synonymsMeta = const VerificationMeta(
    'synonyms',
  );
  @override
  late final GeneratedColumn<String> synonyms = GeneratedColumn<String>(
    'synonyms',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _antonymsMeta = const VerificationMeta(
    'antonyms',
  );
  @override
  late final GeneratedColumn<String> antonyms = GeneratedColumn<String>(
    'antonyms',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Published'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    word,
    kana,
    meaning,
    partOfSpeech,
    jlptLevel,
    frequency,
    relatedKanji,
    exampleSentences,
    synonyms,
    antonyms,
    tags,
    notes,
    createdAt,
    updatedAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'master_vocabularies';
  @override
  VerificationContext validateIntegrity(
    Insertable<MasterVocabulary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('kana')) {
      context.handle(
        _kanaMeta,
        kana.isAcceptableOrUnknown(data['kana']!, _kanaMeta),
      );
    } else if (isInserting) {
      context.missing(_kanaMeta);
    }
    if (data.containsKey('meaning')) {
      context.handle(
        _meaningMeta,
        meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta),
      );
    } else if (isInserting) {
      context.missing(_meaningMeta);
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    }
    if (data.containsKey('jlpt_level')) {
      context.handle(
        _jlptLevelMeta,
        jlptLevel.isAcceptableOrUnknown(data['jlpt_level']!, _jlptLevelMeta),
      );
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    }
    if (data.containsKey('related_kanji')) {
      context.handle(
        _relatedKanjiMeta,
        relatedKanji.isAcceptableOrUnknown(
          data['related_kanji']!,
          _relatedKanjiMeta,
        ),
      );
    }
    if (data.containsKey('example_sentences')) {
      context.handle(
        _exampleSentencesMeta,
        exampleSentences.isAcceptableOrUnknown(
          data['example_sentences']!,
          _exampleSentencesMeta,
        ),
      );
    }
    if (data.containsKey('synonyms')) {
      context.handle(
        _synonymsMeta,
        synonyms.isAcceptableOrUnknown(data['synonyms']!, _synonymsMeta),
      );
    }
    if (data.containsKey('antonyms')) {
      context.handle(
        _antonymsMeta,
        antonyms.isAcceptableOrUnknown(data['antonyms']!, _antonymsMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MasterVocabulary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MasterVocabulary(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      word: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word'],
      )!,
      kana: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kana'],
      )!,
      meaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meaning'],
      )!,
      partOfSpeech: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_of_speech'],
      ),
      jlptLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jlpt_level'],
      ),
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frequency'],
      ),
      relatedKanji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_kanji'],
      ),
      exampleSentences: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}example_sentences'],
      ),
      synonyms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}synonyms'],
      ),
      antonyms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}antonyms'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $MasterVocabulariesTable createAlias(String alias) {
    return $MasterVocabulariesTable(attachedDatabase, alias);
  }
}

class MasterVocabulary extends DataClass
    implements Insertable<MasterVocabulary> {
  final String id;
  final String word;
  final String kana;
  final String meaning;
  final String? partOfSpeech;
  final int? jlptLevel;
  final int? frequency;
  final String? relatedKanji;
  final String? exampleSentences;
  final String? synonyms;
  final String? antonyms;
  final String? tags;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  const MasterVocabulary({
    required this.id,
    required this.word,
    required this.kana,
    required this.meaning,
    this.partOfSpeech,
    this.jlptLevel,
    this.frequency,
    this.relatedKanji,
    this.exampleSentences,
    this.synonyms,
    this.antonyms,
    this.tags,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['word'] = Variable<String>(word);
    map['kana'] = Variable<String>(kana);
    map['meaning'] = Variable<String>(meaning);
    if (!nullToAbsent || partOfSpeech != null) {
      map['part_of_speech'] = Variable<String>(partOfSpeech);
    }
    if (!nullToAbsent || jlptLevel != null) {
      map['jlpt_level'] = Variable<int>(jlptLevel);
    }
    if (!nullToAbsent || frequency != null) {
      map['frequency'] = Variable<int>(frequency);
    }
    if (!nullToAbsent || relatedKanji != null) {
      map['related_kanji'] = Variable<String>(relatedKanji);
    }
    if (!nullToAbsent || exampleSentences != null) {
      map['example_sentences'] = Variable<String>(exampleSentences);
    }
    if (!nullToAbsent || synonyms != null) {
      map['synonyms'] = Variable<String>(synonyms);
    }
    if (!nullToAbsent || antonyms != null) {
      map['antonyms'] = Variable<String>(antonyms);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['status'] = Variable<String>(status);
    return map;
  }

  MasterVocabulariesCompanion toCompanion(bool nullToAbsent) {
    return MasterVocabulariesCompanion(
      id: Value(id),
      word: Value(word),
      kana: Value(kana),
      meaning: Value(meaning),
      partOfSpeech: partOfSpeech == null && nullToAbsent
          ? const Value.absent()
          : Value(partOfSpeech),
      jlptLevel: jlptLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(jlptLevel),
      frequency: frequency == null && nullToAbsent
          ? const Value.absent()
          : Value(frequency),
      relatedKanji: relatedKanji == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedKanji),
      exampleSentences: exampleSentences == null && nullToAbsent
          ? const Value.absent()
          : Value(exampleSentences),
      synonyms: synonyms == null && nullToAbsent
          ? const Value.absent()
          : Value(synonyms),
      antonyms: antonyms == null && nullToAbsent
          ? const Value.absent()
          : Value(antonyms),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      status: Value(status),
    );
  }

  factory MasterVocabulary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MasterVocabulary(
      id: serializer.fromJson<String>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      kana: serializer.fromJson<String>(json['kana']),
      meaning: serializer.fromJson<String>(json['meaning']),
      partOfSpeech: serializer.fromJson<String?>(json['partOfSpeech']),
      jlptLevel: serializer.fromJson<int?>(json['jlptLevel']),
      frequency: serializer.fromJson<int?>(json['frequency']),
      relatedKanji: serializer.fromJson<String?>(json['relatedKanji']),
      exampleSentences: serializer.fromJson<String?>(json['exampleSentences']),
      synonyms: serializer.fromJson<String?>(json['synonyms']),
      antonyms: serializer.fromJson<String?>(json['antonyms']),
      tags: serializer.fromJson<String?>(json['tags']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'word': serializer.toJson<String>(word),
      'kana': serializer.toJson<String>(kana),
      'meaning': serializer.toJson<String>(meaning),
      'partOfSpeech': serializer.toJson<String?>(partOfSpeech),
      'jlptLevel': serializer.toJson<int?>(jlptLevel),
      'frequency': serializer.toJson<int?>(frequency),
      'relatedKanji': serializer.toJson<String?>(relatedKanji),
      'exampleSentences': serializer.toJson<String?>(exampleSentences),
      'synonyms': serializer.toJson<String?>(synonyms),
      'antonyms': serializer.toJson<String?>(antonyms),
      'tags': serializer.toJson<String?>(tags),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'status': serializer.toJson<String>(status),
    };
  }

  MasterVocabulary copyWith({
    String? id,
    String? word,
    String? kana,
    String? meaning,
    Value<String?> partOfSpeech = const Value.absent(),
    Value<int?> jlptLevel = const Value.absent(),
    Value<int?> frequency = const Value.absent(),
    Value<String?> relatedKanji = const Value.absent(),
    Value<String?> exampleSentences = const Value.absent(),
    Value<String?> synonyms = const Value.absent(),
    Value<String?> antonyms = const Value.absent(),
    Value<String?> tags = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
  }) => MasterVocabulary(
    id: id ?? this.id,
    word: word ?? this.word,
    kana: kana ?? this.kana,
    meaning: meaning ?? this.meaning,
    partOfSpeech: partOfSpeech.present ? partOfSpeech.value : this.partOfSpeech,
    jlptLevel: jlptLevel.present ? jlptLevel.value : this.jlptLevel,
    frequency: frequency.present ? frequency.value : this.frequency,
    relatedKanji: relatedKanji.present ? relatedKanji.value : this.relatedKanji,
    exampleSentences: exampleSentences.present
        ? exampleSentences.value
        : this.exampleSentences,
    synonyms: synonyms.present ? synonyms.value : this.synonyms,
    antonyms: antonyms.present ? antonyms.value : this.antonyms,
    tags: tags.present ? tags.value : this.tags,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    status: status ?? this.status,
  );
  MasterVocabulary copyWithCompanion(MasterVocabulariesCompanion data) {
    return MasterVocabulary(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      kana: data.kana.present ? data.kana.value : this.kana,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      jlptLevel: data.jlptLevel.present ? data.jlptLevel.value : this.jlptLevel,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      relatedKanji: data.relatedKanji.present
          ? data.relatedKanji.value
          : this.relatedKanji,
      exampleSentences: data.exampleSentences.present
          ? data.exampleSentences.value
          : this.exampleSentences,
      synonyms: data.synonyms.present ? data.synonyms.value : this.synonyms,
      antonyms: data.antonyms.present ? data.antonyms.value : this.antonyms,
      tags: data.tags.present ? data.tags.value : this.tags,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MasterVocabulary(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('kana: $kana, ')
          ..write('meaning: $meaning, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('jlptLevel: $jlptLevel, ')
          ..write('frequency: $frequency, ')
          ..write('relatedKanji: $relatedKanji, ')
          ..write('exampleSentences: $exampleSentences, ')
          ..write('synonyms: $synonyms, ')
          ..write('antonyms: $antonyms, ')
          ..write('tags: $tags, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    word,
    kana,
    meaning,
    partOfSpeech,
    jlptLevel,
    frequency,
    relatedKanji,
    exampleSentences,
    synonyms,
    antonyms,
    tags,
    notes,
    createdAt,
    updatedAt,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MasterVocabulary &&
          other.id == this.id &&
          other.word == this.word &&
          other.kana == this.kana &&
          other.meaning == this.meaning &&
          other.partOfSpeech == this.partOfSpeech &&
          other.jlptLevel == this.jlptLevel &&
          other.frequency == this.frequency &&
          other.relatedKanji == this.relatedKanji &&
          other.exampleSentences == this.exampleSentences &&
          other.synonyms == this.synonyms &&
          other.antonyms == this.antonyms &&
          other.tags == this.tags &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.status == this.status);
}

class MasterVocabulariesCompanion extends UpdateCompanion<MasterVocabulary> {
  final Value<String> id;
  final Value<String> word;
  final Value<String> kana;
  final Value<String> meaning;
  final Value<String?> partOfSpeech;
  final Value<int?> jlptLevel;
  final Value<int?> frequency;
  final Value<String?> relatedKanji;
  final Value<String?> exampleSentences;
  final Value<String?> synonyms;
  final Value<String?> antonyms;
  final Value<String?> tags;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> status;
  final Value<int> rowid;
  const MasterVocabulariesCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.kana = const Value.absent(),
    this.meaning = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.jlptLevel = const Value.absent(),
    this.frequency = const Value.absent(),
    this.relatedKanji = const Value.absent(),
    this.exampleSentences = const Value.absent(),
    this.synonyms = const Value.absent(),
    this.antonyms = const Value.absent(),
    this.tags = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MasterVocabulariesCompanion.insert({
    required String id,
    required String word,
    required String kana,
    required String meaning,
    this.partOfSpeech = const Value.absent(),
    this.jlptLevel = const Value.absent(),
    this.frequency = const Value.absent(),
    this.relatedKanji = const Value.absent(),
    this.exampleSentences = const Value.absent(),
    this.synonyms = const Value.absent(),
    this.antonyms = const Value.absent(),
    this.tags = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       word = Value(word),
       kana = Value(kana),
       meaning = Value(meaning),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MasterVocabulary> custom({
    Expression<String>? id,
    Expression<String>? word,
    Expression<String>? kana,
    Expression<String>? meaning,
    Expression<String>? partOfSpeech,
    Expression<int>? jlptLevel,
    Expression<int>? frequency,
    Expression<String>? relatedKanji,
    Expression<String>? exampleSentences,
    Expression<String>? synonyms,
    Expression<String>? antonyms,
    Expression<String>? tags,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (kana != null) 'kana': kana,
      if (meaning != null) 'meaning': meaning,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (jlptLevel != null) 'jlpt_level': jlptLevel,
      if (frequency != null) 'frequency': frequency,
      if (relatedKanji != null) 'related_kanji': relatedKanji,
      if (exampleSentences != null) 'example_sentences': exampleSentences,
      if (synonyms != null) 'synonyms': synonyms,
      if (antonyms != null) 'antonyms': antonyms,
      if (tags != null) 'tags': tags,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MasterVocabulariesCompanion copyWith({
    Value<String>? id,
    Value<String>? word,
    Value<String>? kana,
    Value<String>? meaning,
    Value<String?>? partOfSpeech,
    Value<int?>? jlptLevel,
    Value<int?>? frequency,
    Value<String?>? relatedKanji,
    Value<String?>? exampleSentences,
    Value<String?>? synonyms,
    Value<String?>? antonyms,
    Value<String?>? tags,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return MasterVocabulariesCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      kana: kana ?? this.kana,
      meaning: meaning ?? this.meaning,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      jlptLevel: jlptLevel ?? this.jlptLevel,
      frequency: frequency ?? this.frequency,
      relatedKanji: relatedKanji ?? this.relatedKanji,
      exampleSentences: exampleSentences ?? this.exampleSentences,
      synonyms: synonyms ?? this.synonyms,
      antonyms: antonyms ?? this.antonyms,
      tags: tags ?? this.tags,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (kana.present) {
      map['kana'] = Variable<String>(kana.value);
    }
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (jlptLevel.present) {
      map['jlpt_level'] = Variable<int>(jlptLevel.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<int>(frequency.value);
    }
    if (relatedKanji.present) {
      map['related_kanji'] = Variable<String>(relatedKanji.value);
    }
    if (exampleSentences.present) {
      map['example_sentences'] = Variable<String>(exampleSentences.value);
    }
    if (synonyms.present) {
      map['synonyms'] = Variable<String>(synonyms.value);
    }
    if (antonyms.present) {
      map['antonyms'] = Variable<String>(antonyms.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MasterVocabulariesCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('kana: $kana, ')
          ..write('meaning: $meaning, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('jlptLevel: $jlptLevel, ')
          ..write('frequency: $frequency, ')
          ..write('relatedKanji: $relatedKanji, ')
          ..write('exampleSentences: $exampleSentences, ')
          ..write('synonyms: $synonyms, ')
          ..write('antonyms: $antonyms, ')
          ..write('tags: $tags, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserVocabulariesTable extends UserVocabularies
    with TableInfo<$UserVocabulariesTable, UserVocabulary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserVocabulariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _masterVocabIdMeta = const VerificationMeta(
    'masterVocabId',
  );
  @override
  late final GeneratedColumn<String> masterVocabId = GeneratedColumn<String>(
    'master_vocab_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_vocabularies(id) ON DELETE CASCADE NOT NULL',
  );
  static const VerificationMeta _isAddedMeta = const VerificationMeta(
    'isAdded',
  );
  @override
  late final GeneratedColumn<bool> isAdded = GeneratedColumn<bool>(
    'is_added',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_added" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unlearned'),
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextReviewMeta = const VerificationMeta(
    'nextReview',
  );
  @override
  late final GeneratedColumn<DateTime> nextReview = GeneratedColumn<DateTime>(
    'next_review',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastReviewedMeta = const VerificationMeta(
    'lastReviewed',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewed = GeneratedColumn<DateTime>(
    'last_reviewed',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _easeFactorMeta = const VerificationMeta(
    'easeFactor',
  );
  @override
  late final GeneratedColumn<double> easeFactor = GeneratedColumn<double>(
    'ease_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.5),
  );
  static const VerificationMeta _customNotesMeta = const VerificationMeta(
    'customNotes',
  );
  @override
  late final GeneratedColumn<String> customNotes = GeneratedColumn<String>(
    'custom_notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    masterVocabId,
    isAdded,
    isFavorite,
    status,
    reviewCount,
    nextReview,
    lastReviewed,
    easeFactor,
    customNotes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_vocabularies';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserVocabulary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('master_vocab_id')) {
      context.handle(
        _masterVocabIdMeta,
        masterVocabId.isAcceptableOrUnknown(
          data['master_vocab_id']!,
          _masterVocabIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_masterVocabIdMeta);
    }
    if (data.containsKey('is_added')) {
      context.handle(
        _isAddedMeta,
        isAdded.isAcceptableOrUnknown(data['is_added']!, _isAddedMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    }
    if (data.containsKey('next_review')) {
      context.handle(
        _nextReviewMeta,
        nextReview.isAcceptableOrUnknown(data['next_review']!, _nextReviewMeta),
      );
    }
    if (data.containsKey('last_reviewed')) {
      context.handle(
        _lastReviewedMeta,
        lastReviewed.isAcceptableOrUnknown(
          data['last_reviewed']!,
          _lastReviewedMeta,
        ),
      );
    }
    if (data.containsKey('ease_factor')) {
      context.handle(
        _easeFactorMeta,
        easeFactor.isAcceptableOrUnknown(data['ease_factor']!, _easeFactorMeta),
      );
    }
    if (data.containsKey('custom_notes')) {
      context.handle(
        _customNotesMeta,
        customNotes.isAcceptableOrUnknown(
          data['custom_notes']!,
          _customNotesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserVocabulary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserVocabulary(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      masterVocabId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}master_vocab_id'],
      )!,
      isAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_added'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      reviewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_count'],
      )!,
      nextReview: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_review'],
      ),
      lastReviewed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reviewed'],
      ),
      easeFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ease_factor'],
      )!,
      customNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserVocabulariesTable createAlias(String alias) {
    return $UserVocabulariesTable(attachedDatabase, alias);
  }
}

class UserVocabulary extends DataClass implements Insertable<UserVocabulary> {
  final String id;
  final String masterVocabId;
  final bool isAdded;
  final bool isFavorite;
  final String status;
  final int reviewCount;
  final DateTime? nextReview;
  final DateTime? lastReviewed;
  final double easeFactor;
  final String customNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserVocabulary({
    required this.id,
    required this.masterVocabId,
    required this.isAdded,
    required this.isFavorite,
    required this.status,
    required this.reviewCount,
    this.nextReview,
    this.lastReviewed,
    required this.easeFactor,
    required this.customNotes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['master_vocab_id'] = Variable<String>(masterVocabId);
    map['is_added'] = Variable<bool>(isAdded);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['status'] = Variable<String>(status);
    map['review_count'] = Variable<int>(reviewCount);
    if (!nullToAbsent || nextReview != null) {
      map['next_review'] = Variable<DateTime>(nextReview);
    }
    if (!nullToAbsent || lastReviewed != null) {
      map['last_reviewed'] = Variable<DateTime>(lastReviewed);
    }
    map['ease_factor'] = Variable<double>(easeFactor);
    map['custom_notes'] = Variable<String>(customNotes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserVocabulariesCompanion toCompanion(bool nullToAbsent) {
    return UserVocabulariesCompanion(
      id: Value(id),
      masterVocabId: Value(masterVocabId),
      isAdded: Value(isAdded),
      isFavorite: Value(isFavorite),
      status: Value(status),
      reviewCount: Value(reviewCount),
      nextReview: nextReview == null && nullToAbsent
          ? const Value.absent()
          : Value(nextReview),
      lastReviewed: lastReviewed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewed),
      easeFactor: Value(easeFactor),
      customNotes: Value(customNotes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserVocabulary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserVocabulary(
      id: serializer.fromJson<String>(json['id']),
      masterVocabId: serializer.fromJson<String>(json['masterVocabId']),
      isAdded: serializer.fromJson<bool>(json['isAdded']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      status: serializer.fromJson<String>(json['status']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      nextReview: serializer.fromJson<DateTime?>(json['nextReview']),
      lastReviewed: serializer.fromJson<DateTime?>(json['lastReviewed']),
      easeFactor: serializer.fromJson<double>(json['easeFactor']),
      customNotes: serializer.fromJson<String>(json['customNotes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'masterVocabId': serializer.toJson<String>(masterVocabId),
      'isAdded': serializer.toJson<bool>(isAdded),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'status': serializer.toJson<String>(status),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'nextReview': serializer.toJson<DateTime?>(nextReview),
      'lastReviewed': serializer.toJson<DateTime?>(lastReviewed),
      'easeFactor': serializer.toJson<double>(easeFactor),
      'customNotes': serializer.toJson<String>(customNotes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserVocabulary copyWith({
    String? id,
    String? masterVocabId,
    bool? isAdded,
    bool? isFavorite,
    String? status,
    int? reviewCount,
    Value<DateTime?> nextReview = const Value.absent(),
    Value<DateTime?> lastReviewed = const Value.absent(),
    double? easeFactor,
    String? customNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserVocabulary(
    id: id ?? this.id,
    masterVocabId: masterVocabId ?? this.masterVocabId,
    isAdded: isAdded ?? this.isAdded,
    isFavorite: isFavorite ?? this.isFavorite,
    status: status ?? this.status,
    reviewCount: reviewCount ?? this.reviewCount,
    nextReview: nextReview.present ? nextReview.value : this.nextReview,
    lastReviewed: lastReviewed.present ? lastReviewed.value : this.lastReviewed,
    easeFactor: easeFactor ?? this.easeFactor,
    customNotes: customNotes ?? this.customNotes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserVocabulary copyWithCompanion(UserVocabulariesCompanion data) {
    return UserVocabulary(
      id: data.id.present ? data.id.value : this.id,
      masterVocabId: data.masterVocabId.present
          ? data.masterVocabId.value
          : this.masterVocabId,
      isAdded: data.isAdded.present ? data.isAdded.value : this.isAdded,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      status: data.status.present ? data.status.value : this.status,
      reviewCount: data.reviewCount.present
          ? data.reviewCount.value
          : this.reviewCount,
      nextReview: data.nextReview.present
          ? data.nextReview.value
          : this.nextReview,
      lastReviewed: data.lastReviewed.present
          ? data.lastReviewed.value
          : this.lastReviewed,
      easeFactor: data.easeFactor.present
          ? data.easeFactor.value
          : this.easeFactor,
      customNotes: data.customNotes.present
          ? data.customNotes.value
          : this.customNotes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserVocabulary(')
          ..write('id: $id, ')
          ..write('masterVocabId: $masterVocabId, ')
          ..write('isAdded: $isAdded, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('status: $status, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('nextReview: $nextReview, ')
          ..write('lastReviewed: $lastReviewed, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('customNotes: $customNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    masterVocabId,
    isAdded,
    isFavorite,
    status,
    reviewCount,
    nextReview,
    lastReviewed,
    easeFactor,
    customNotes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserVocabulary &&
          other.id == this.id &&
          other.masterVocabId == this.masterVocabId &&
          other.isAdded == this.isAdded &&
          other.isFavorite == this.isFavorite &&
          other.status == this.status &&
          other.reviewCount == this.reviewCount &&
          other.nextReview == this.nextReview &&
          other.lastReviewed == this.lastReviewed &&
          other.easeFactor == this.easeFactor &&
          other.customNotes == this.customNotes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserVocabulariesCompanion extends UpdateCompanion<UserVocabulary> {
  final Value<String> id;
  final Value<String> masterVocabId;
  final Value<bool> isAdded;
  final Value<bool> isFavorite;
  final Value<String> status;
  final Value<int> reviewCount;
  final Value<DateTime?> nextReview;
  final Value<DateTime?> lastReviewed;
  final Value<double> easeFactor;
  final Value<String> customNotes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserVocabulariesCompanion({
    this.id = const Value.absent(),
    this.masterVocabId = const Value.absent(),
    this.isAdded = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.status = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.nextReview = const Value.absent(),
    this.lastReviewed = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.customNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserVocabulariesCompanion.insert({
    required String id,
    required String masterVocabId,
    this.isAdded = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.status = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.nextReview = const Value.absent(),
    this.lastReviewed = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.customNotes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       masterVocabId = Value(masterVocabId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserVocabulary> custom({
    Expression<String>? id,
    Expression<String>? masterVocabId,
    Expression<bool>? isAdded,
    Expression<bool>? isFavorite,
    Expression<String>? status,
    Expression<int>? reviewCount,
    Expression<DateTime>? nextReview,
    Expression<DateTime>? lastReviewed,
    Expression<double>? easeFactor,
    Expression<String>? customNotes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (masterVocabId != null) 'master_vocab_id': masterVocabId,
      if (isAdded != null) 'is_added': isAdded,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (status != null) 'status': status,
      if (reviewCount != null) 'review_count': reviewCount,
      if (nextReview != null) 'next_review': nextReview,
      if (lastReviewed != null) 'last_reviewed': lastReviewed,
      if (easeFactor != null) 'ease_factor': easeFactor,
      if (customNotes != null) 'custom_notes': customNotes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserVocabulariesCompanion copyWith({
    Value<String>? id,
    Value<String>? masterVocabId,
    Value<bool>? isAdded,
    Value<bool>? isFavorite,
    Value<String>? status,
    Value<int>? reviewCount,
    Value<DateTime?>? nextReview,
    Value<DateTime?>? lastReviewed,
    Value<double>? easeFactor,
    Value<String>? customNotes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserVocabulariesCompanion(
      id: id ?? this.id,
      masterVocabId: masterVocabId ?? this.masterVocabId,
      isAdded: isAdded ?? this.isAdded,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
      reviewCount: reviewCount ?? this.reviewCount,
      nextReview: nextReview ?? this.nextReview,
      lastReviewed: lastReviewed ?? this.lastReviewed,
      easeFactor: easeFactor ?? this.easeFactor,
      customNotes: customNotes ?? this.customNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (masterVocabId.present) {
      map['master_vocab_id'] = Variable<String>(masterVocabId.value);
    }
    if (isAdded.present) {
      map['is_added'] = Variable<bool>(isAdded.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (nextReview.present) {
      map['next_review'] = Variable<DateTime>(nextReview.value);
    }
    if (lastReviewed.present) {
      map['last_reviewed'] = Variable<DateTime>(lastReviewed.value);
    }
    if (easeFactor.present) {
      map['ease_factor'] = Variable<double>(easeFactor.value);
    }
    if (customNotes.present) {
      map['custom_notes'] = Variable<String>(customNotes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserVocabulariesCompanion(')
          ..write('id: $id, ')
          ..write('masterVocabId: $masterVocabId, ')
          ..write('isAdded: $isAdded, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('status: $status, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('nextReview: $nextReview, ')
          ..write('lastReviewed: $lastReviewed, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('customNotes: $customNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MasterGrammarsTable extends MasterGrammars
    with TableInfo<$MasterGrammarsTable, MasterGrammar> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MasterGrammarsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patternMeta = const VerificationMeta(
    'pattern',
  );
  @override
  late final GeneratedColumn<String> pattern = GeneratedColumn<String>(
    'pattern',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meaningMeta = const VerificationMeta(
    'meaning',
  );
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
    'meaning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formationMeta = const VerificationMeta(
    'formation',
  );
  @override
  late final GeneratedColumn<String> formation = GeneratedColumn<String>(
    'formation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usageMeta = const VerificationMeta('usage');
  @override
  late final GeneratedColumn<String> usage = GeneratedColumn<String>(
    'usage',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _examplesMeta = const VerificationMeta(
    'examples',
  );
  @override
  late final GeneratedColumn<String> examples = GeneratedColumn<String>(
    'examples',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commonMistakesMeta = const VerificationMeta(
    'commonMistakes',
  );
  @override
  late final GeneratedColumn<String> commonMistakes = GeneratedColumn<String>(
    'common_mistakes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relatedGrammarMeta = const VerificationMeta(
    'relatedGrammar',
  );
  @override
  late final GeneratedColumn<String> relatedGrammar = GeneratedColumn<String>(
    'related_grammar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jlptLevelMeta = const VerificationMeta(
    'jlptLevel',
  );
  @override
  late final GeneratedColumn<int> jlptLevel = GeneratedColumn<int>(
    'jlpt_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Published'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pattern,
    meaning,
    formation,
    usage,
    examples,
    commonMistakes,
    relatedGrammar,
    jlptLevel,
    tags,
    notes,
    createdAt,
    updatedAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'master_grammars';
  @override
  VerificationContext validateIntegrity(
    Insertable<MasterGrammar> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pattern')) {
      context.handle(
        _patternMeta,
        pattern.isAcceptableOrUnknown(data['pattern']!, _patternMeta),
      );
    } else if (isInserting) {
      context.missing(_patternMeta);
    }
    if (data.containsKey('meaning')) {
      context.handle(
        _meaningMeta,
        meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta),
      );
    } else if (isInserting) {
      context.missing(_meaningMeta);
    }
    if (data.containsKey('formation')) {
      context.handle(
        _formationMeta,
        formation.isAcceptableOrUnknown(data['formation']!, _formationMeta),
      );
    }
    if (data.containsKey('usage')) {
      context.handle(
        _usageMeta,
        usage.isAcceptableOrUnknown(data['usage']!, _usageMeta),
      );
    }
    if (data.containsKey('examples')) {
      context.handle(
        _examplesMeta,
        examples.isAcceptableOrUnknown(data['examples']!, _examplesMeta),
      );
    }
    if (data.containsKey('common_mistakes')) {
      context.handle(
        _commonMistakesMeta,
        commonMistakes.isAcceptableOrUnknown(
          data['common_mistakes']!,
          _commonMistakesMeta,
        ),
      );
    }
    if (data.containsKey('related_grammar')) {
      context.handle(
        _relatedGrammarMeta,
        relatedGrammar.isAcceptableOrUnknown(
          data['related_grammar']!,
          _relatedGrammarMeta,
        ),
      );
    }
    if (data.containsKey('jlpt_level')) {
      context.handle(
        _jlptLevelMeta,
        jlptLevel.isAcceptableOrUnknown(data['jlpt_level']!, _jlptLevelMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MasterGrammar map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MasterGrammar(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pattern: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pattern'],
      )!,
      meaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meaning'],
      )!,
      formation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formation'],
      ),
      usage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usage'],
      ),
      examples: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}examples'],
      ),
      commonMistakes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}common_mistakes'],
      ),
      relatedGrammar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_grammar'],
      ),
      jlptLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jlpt_level'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $MasterGrammarsTable createAlias(String alias) {
    return $MasterGrammarsTable(attachedDatabase, alias);
  }
}

class MasterGrammar extends DataClass implements Insertable<MasterGrammar> {
  final String id;
  final String pattern;
  final String meaning;
  final String? formation;
  final String? usage;
  final String? examples;
  final String? commonMistakes;
  final String? relatedGrammar;
  final int? jlptLevel;
  final String? tags;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  const MasterGrammar({
    required this.id,
    required this.pattern,
    required this.meaning,
    this.formation,
    this.usage,
    this.examples,
    this.commonMistakes,
    this.relatedGrammar,
    this.jlptLevel,
    this.tags,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pattern'] = Variable<String>(pattern);
    map['meaning'] = Variable<String>(meaning);
    if (!nullToAbsent || formation != null) {
      map['formation'] = Variable<String>(formation);
    }
    if (!nullToAbsent || usage != null) {
      map['usage'] = Variable<String>(usage);
    }
    if (!nullToAbsent || examples != null) {
      map['examples'] = Variable<String>(examples);
    }
    if (!nullToAbsent || commonMistakes != null) {
      map['common_mistakes'] = Variable<String>(commonMistakes);
    }
    if (!nullToAbsent || relatedGrammar != null) {
      map['related_grammar'] = Variable<String>(relatedGrammar);
    }
    if (!nullToAbsent || jlptLevel != null) {
      map['jlpt_level'] = Variable<int>(jlptLevel);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['status'] = Variable<String>(status);
    return map;
  }

  MasterGrammarsCompanion toCompanion(bool nullToAbsent) {
    return MasterGrammarsCompanion(
      id: Value(id),
      pattern: Value(pattern),
      meaning: Value(meaning),
      formation: formation == null && nullToAbsent
          ? const Value.absent()
          : Value(formation),
      usage: usage == null && nullToAbsent
          ? const Value.absent()
          : Value(usage),
      examples: examples == null && nullToAbsent
          ? const Value.absent()
          : Value(examples),
      commonMistakes: commonMistakes == null && nullToAbsent
          ? const Value.absent()
          : Value(commonMistakes),
      relatedGrammar: relatedGrammar == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedGrammar),
      jlptLevel: jlptLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(jlptLevel),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      status: Value(status),
    );
  }

  factory MasterGrammar.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MasterGrammar(
      id: serializer.fromJson<String>(json['id']),
      pattern: serializer.fromJson<String>(json['pattern']),
      meaning: serializer.fromJson<String>(json['meaning']),
      formation: serializer.fromJson<String?>(json['formation']),
      usage: serializer.fromJson<String?>(json['usage']),
      examples: serializer.fromJson<String?>(json['examples']),
      commonMistakes: serializer.fromJson<String?>(json['commonMistakes']),
      relatedGrammar: serializer.fromJson<String?>(json['relatedGrammar']),
      jlptLevel: serializer.fromJson<int?>(json['jlptLevel']),
      tags: serializer.fromJson<String?>(json['tags']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pattern': serializer.toJson<String>(pattern),
      'meaning': serializer.toJson<String>(meaning),
      'formation': serializer.toJson<String?>(formation),
      'usage': serializer.toJson<String?>(usage),
      'examples': serializer.toJson<String?>(examples),
      'commonMistakes': serializer.toJson<String?>(commonMistakes),
      'relatedGrammar': serializer.toJson<String?>(relatedGrammar),
      'jlptLevel': serializer.toJson<int?>(jlptLevel),
      'tags': serializer.toJson<String?>(tags),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'status': serializer.toJson<String>(status),
    };
  }

  MasterGrammar copyWith({
    String? id,
    String? pattern,
    String? meaning,
    Value<String?> formation = const Value.absent(),
    Value<String?> usage = const Value.absent(),
    Value<String?> examples = const Value.absent(),
    Value<String?> commonMistakes = const Value.absent(),
    Value<String?> relatedGrammar = const Value.absent(),
    Value<int?> jlptLevel = const Value.absent(),
    Value<String?> tags = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
  }) => MasterGrammar(
    id: id ?? this.id,
    pattern: pattern ?? this.pattern,
    meaning: meaning ?? this.meaning,
    formation: formation.present ? formation.value : this.formation,
    usage: usage.present ? usage.value : this.usage,
    examples: examples.present ? examples.value : this.examples,
    commonMistakes: commonMistakes.present
        ? commonMistakes.value
        : this.commonMistakes,
    relatedGrammar: relatedGrammar.present
        ? relatedGrammar.value
        : this.relatedGrammar,
    jlptLevel: jlptLevel.present ? jlptLevel.value : this.jlptLevel,
    tags: tags.present ? tags.value : this.tags,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    status: status ?? this.status,
  );
  MasterGrammar copyWithCompanion(MasterGrammarsCompanion data) {
    return MasterGrammar(
      id: data.id.present ? data.id.value : this.id,
      pattern: data.pattern.present ? data.pattern.value : this.pattern,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
      formation: data.formation.present ? data.formation.value : this.formation,
      usage: data.usage.present ? data.usage.value : this.usage,
      examples: data.examples.present ? data.examples.value : this.examples,
      commonMistakes: data.commonMistakes.present
          ? data.commonMistakes.value
          : this.commonMistakes,
      relatedGrammar: data.relatedGrammar.present
          ? data.relatedGrammar.value
          : this.relatedGrammar,
      jlptLevel: data.jlptLevel.present ? data.jlptLevel.value : this.jlptLevel,
      tags: data.tags.present ? data.tags.value : this.tags,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MasterGrammar(')
          ..write('id: $id, ')
          ..write('pattern: $pattern, ')
          ..write('meaning: $meaning, ')
          ..write('formation: $formation, ')
          ..write('usage: $usage, ')
          ..write('examples: $examples, ')
          ..write('commonMistakes: $commonMistakes, ')
          ..write('relatedGrammar: $relatedGrammar, ')
          ..write('jlptLevel: $jlptLevel, ')
          ..write('tags: $tags, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pattern,
    meaning,
    formation,
    usage,
    examples,
    commonMistakes,
    relatedGrammar,
    jlptLevel,
    tags,
    notes,
    createdAt,
    updatedAt,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MasterGrammar &&
          other.id == this.id &&
          other.pattern == this.pattern &&
          other.meaning == this.meaning &&
          other.formation == this.formation &&
          other.usage == this.usage &&
          other.examples == this.examples &&
          other.commonMistakes == this.commonMistakes &&
          other.relatedGrammar == this.relatedGrammar &&
          other.jlptLevel == this.jlptLevel &&
          other.tags == this.tags &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.status == this.status);
}

class MasterGrammarsCompanion extends UpdateCompanion<MasterGrammar> {
  final Value<String> id;
  final Value<String> pattern;
  final Value<String> meaning;
  final Value<String?> formation;
  final Value<String?> usage;
  final Value<String?> examples;
  final Value<String?> commonMistakes;
  final Value<String?> relatedGrammar;
  final Value<int?> jlptLevel;
  final Value<String?> tags;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> status;
  final Value<int> rowid;
  const MasterGrammarsCompanion({
    this.id = const Value.absent(),
    this.pattern = const Value.absent(),
    this.meaning = const Value.absent(),
    this.formation = const Value.absent(),
    this.usage = const Value.absent(),
    this.examples = const Value.absent(),
    this.commonMistakes = const Value.absent(),
    this.relatedGrammar = const Value.absent(),
    this.jlptLevel = const Value.absent(),
    this.tags = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MasterGrammarsCompanion.insert({
    required String id,
    required String pattern,
    required String meaning,
    this.formation = const Value.absent(),
    this.usage = const Value.absent(),
    this.examples = const Value.absent(),
    this.commonMistakes = const Value.absent(),
    this.relatedGrammar = const Value.absent(),
    this.jlptLevel = const Value.absent(),
    this.tags = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pattern = Value(pattern),
       meaning = Value(meaning),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MasterGrammar> custom({
    Expression<String>? id,
    Expression<String>? pattern,
    Expression<String>? meaning,
    Expression<String>? formation,
    Expression<String>? usage,
    Expression<String>? examples,
    Expression<String>? commonMistakes,
    Expression<String>? relatedGrammar,
    Expression<int>? jlptLevel,
    Expression<String>? tags,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pattern != null) 'pattern': pattern,
      if (meaning != null) 'meaning': meaning,
      if (formation != null) 'formation': formation,
      if (usage != null) 'usage': usage,
      if (examples != null) 'examples': examples,
      if (commonMistakes != null) 'common_mistakes': commonMistakes,
      if (relatedGrammar != null) 'related_grammar': relatedGrammar,
      if (jlptLevel != null) 'jlpt_level': jlptLevel,
      if (tags != null) 'tags': tags,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MasterGrammarsCompanion copyWith({
    Value<String>? id,
    Value<String>? pattern,
    Value<String>? meaning,
    Value<String?>? formation,
    Value<String?>? usage,
    Value<String?>? examples,
    Value<String?>? commonMistakes,
    Value<String?>? relatedGrammar,
    Value<int?>? jlptLevel,
    Value<String?>? tags,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return MasterGrammarsCompanion(
      id: id ?? this.id,
      pattern: pattern ?? this.pattern,
      meaning: meaning ?? this.meaning,
      formation: formation ?? this.formation,
      usage: usage ?? this.usage,
      examples: examples ?? this.examples,
      commonMistakes: commonMistakes ?? this.commonMistakes,
      relatedGrammar: relatedGrammar ?? this.relatedGrammar,
      jlptLevel: jlptLevel ?? this.jlptLevel,
      tags: tags ?? this.tags,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pattern.present) {
      map['pattern'] = Variable<String>(pattern.value);
    }
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    if (formation.present) {
      map['formation'] = Variable<String>(formation.value);
    }
    if (usage.present) {
      map['usage'] = Variable<String>(usage.value);
    }
    if (examples.present) {
      map['examples'] = Variable<String>(examples.value);
    }
    if (commonMistakes.present) {
      map['common_mistakes'] = Variable<String>(commonMistakes.value);
    }
    if (relatedGrammar.present) {
      map['related_grammar'] = Variable<String>(relatedGrammar.value);
    }
    if (jlptLevel.present) {
      map['jlpt_level'] = Variable<int>(jlptLevel.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MasterGrammarsCompanion(')
          ..write('id: $id, ')
          ..write('pattern: $pattern, ')
          ..write('meaning: $meaning, ')
          ..write('formation: $formation, ')
          ..write('usage: $usage, ')
          ..write('examples: $examples, ')
          ..write('commonMistakes: $commonMistakes, ')
          ..write('relatedGrammar: $relatedGrammar, ')
          ..write('jlptLevel: $jlptLevel, ')
          ..write('tags: $tags, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserGrammarsTable extends UserGrammars
    with TableInfo<$UserGrammarsTable, UserGrammar> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserGrammarsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _masterGrammarIdMeta = const VerificationMeta(
    'masterGrammarId',
  );
  @override
  late final GeneratedColumn<String> masterGrammarId = GeneratedColumn<String>(
    'master_grammar_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_grammars(id) ON DELETE CASCADE NOT NULL',
  );
  static const VerificationMeta _isAddedMeta = const VerificationMeta(
    'isAdded',
  );
  @override
  late final GeneratedColumn<bool> isAdded = GeneratedColumn<bool>(
    'is_added',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_added" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unlearned'),
  );
  static const VerificationMeta _customNotesMeta = const VerificationMeta(
    'customNotes',
  );
  @override
  late final GeneratedColumn<String> customNotes = GeneratedColumn<String>(
    'custom_notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    masterGrammarId,
    isAdded,
    isFavorite,
    status,
    customNotes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_grammars';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserGrammar> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('master_grammar_id')) {
      context.handle(
        _masterGrammarIdMeta,
        masterGrammarId.isAcceptableOrUnknown(
          data['master_grammar_id']!,
          _masterGrammarIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_masterGrammarIdMeta);
    }
    if (data.containsKey('is_added')) {
      context.handle(
        _isAddedMeta,
        isAdded.isAcceptableOrUnknown(data['is_added']!, _isAddedMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('custom_notes')) {
      context.handle(
        _customNotesMeta,
        customNotes.isAcceptableOrUnknown(
          data['custom_notes']!,
          _customNotesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserGrammar map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserGrammar(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      masterGrammarId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}master_grammar_id'],
      )!,
      isAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_added'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      customNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserGrammarsTable createAlias(String alias) {
    return $UserGrammarsTable(attachedDatabase, alias);
  }
}

class UserGrammar extends DataClass implements Insertable<UserGrammar> {
  final String id;
  final String masterGrammarId;
  final bool isAdded;
  final bool isFavorite;
  final String status;
  final String customNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserGrammar({
    required this.id,
    required this.masterGrammarId,
    required this.isAdded,
    required this.isFavorite,
    required this.status,
    required this.customNotes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['master_grammar_id'] = Variable<String>(masterGrammarId);
    map['is_added'] = Variable<bool>(isAdded);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['status'] = Variable<String>(status);
    map['custom_notes'] = Variable<String>(customNotes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserGrammarsCompanion toCompanion(bool nullToAbsent) {
    return UserGrammarsCompanion(
      id: Value(id),
      masterGrammarId: Value(masterGrammarId),
      isAdded: Value(isAdded),
      isFavorite: Value(isFavorite),
      status: Value(status),
      customNotes: Value(customNotes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserGrammar.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserGrammar(
      id: serializer.fromJson<String>(json['id']),
      masterGrammarId: serializer.fromJson<String>(json['masterGrammarId']),
      isAdded: serializer.fromJson<bool>(json['isAdded']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      status: serializer.fromJson<String>(json['status']),
      customNotes: serializer.fromJson<String>(json['customNotes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'masterGrammarId': serializer.toJson<String>(masterGrammarId),
      'isAdded': serializer.toJson<bool>(isAdded),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'status': serializer.toJson<String>(status),
      'customNotes': serializer.toJson<String>(customNotes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserGrammar copyWith({
    String? id,
    String? masterGrammarId,
    bool? isAdded,
    bool? isFavorite,
    String? status,
    String? customNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserGrammar(
    id: id ?? this.id,
    masterGrammarId: masterGrammarId ?? this.masterGrammarId,
    isAdded: isAdded ?? this.isAdded,
    isFavorite: isFavorite ?? this.isFavorite,
    status: status ?? this.status,
    customNotes: customNotes ?? this.customNotes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserGrammar copyWithCompanion(UserGrammarsCompanion data) {
    return UserGrammar(
      id: data.id.present ? data.id.value : this.id,
      masterGrammarId: data.masterGrammarId.present
          ? data.masterGrammarId.value
          : this.masterGrammarId,
      isAdded: data.isAdded.present ? data.isAdded.value : this.isAdded,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      status: data.status.present ? data.status.value : this.status,
      customNotes: data.customNotes.present
          ? data.customNotes.value
          : this.customNotes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserGrammar(')
          ..write('id: $id, ')
          ..write('masterGrammarId: $masterGrammarId, ')
          ..write('isAdded: $isAdded, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('status: $status, ')
          ..write('customNotes: $customNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    masterGrammarId,
    isAdded,
    isFavorite,
    status,
    customNotes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserGrammar &&
          other.id == this.id &&
          other.masterGrammarId == this.masterGrammarId &&
          other.isAdded == this.isAdded &&
          other.isFavorite == this.isFavorite &&
          other.status == this.status &&
          other.customNotes == this.customNotes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserGrammarsCompanion extends UpdateCompanion<UserGrammar> {
  final Value<String> id;
  final Value<String> masterGrammarId;
  final Value<bool> isAdded;
  final Value<bool> isFavorite;
  final Value<String> status;
  final Value<String> customNotes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserGrammarsCompanion({
    this.id = const Value.absent(),
    this.masterGrammarId = const Value.absent(),
    this.isAdded = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.status = const Value.absent(),
    this.customNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserGrammarsCompanion.insert({
    required String id,
    required String masterGrammarId,
    this.isAdded = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.status = const Value.absent(),
    this.customNotes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       masterGrammarId = Value(masterGrammarId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserGrammar> custom({
    Expression<String>? id,
    Expression<String>? masterGrammarId,
    Expression<bool>? isAdded,
    Expression<bool>? isFavorite,
    Expression<String>? status,
    Expression<String>? customNotes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (masterGrammarId != null) 'master_grammar_id': masterGrammarId,
      if (isAdded != null) 'is_added': isAdded,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (status != null) 'status': status,
      if (customNotes != null) 'custom_notes': customNotes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserGrammarsCompanion copyWith({
    Value<String>? id,
    Value<String>? masterGrammarId,
    Value<bool>? isAdded,
    Value<bool>? isFavorite,
    Value<String>? status,
    Value<String>? customNotes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserGrammarsCompanion(
      id: id ?? this.id,
      masterGrammarId: masterGrammarId ?? this.masterGrammarId,
      isAdded: isAdded ?? this.isAdded,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
      customNotes: customNotes ?? this.customNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (masterGrammarId.present) {
      map['master_grammar_id'] = Variable<String>(masterGrammarId.value);
    }
    if (isAdded.present) {
      map['is_added'] = Variable<bool>(isAdded.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (customNotes.present) {
      map['custom_notes'] = Variable<String>(customNotes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserGrammarsCompanion(')
          ..write('id: $id, ')
          ..write('masterGrammarId: $masterGrammarId, ')
          ..write('isAdded: $isAdded, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('status: $status, ')
          ..write('customNotes: $customNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MasterReadingsTable extends MasterReadings
    with TableInfo<$MasterReadingsTable, MasterReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MasterReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passageMeta = const VerificationMeta(
    'passage',
  );
  @override
  late final GeneratedColumn<String> passage = GeneratedColumn<String>(
    'passage',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationMeta = const VerificationMeta(
    'translation',
  );
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kanjiIdsMeta = const VerificationMeta(
    'kanjiIds',
  );
  @override
  late final GeneratedColumn<String> kanjiIds = GeneratedColumn<String>(
    'kanji_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vocabularyIdsMeta = const VerificationMeta(
    'vocabularyIds',
  );
  @override
  late final GeneratedColumn<String> vocabularyIds = GeneratedColumn<String>(
    'vocabulary_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grammarIdsMeta = const VerificationMeta(
    'grammarIds',
  );
  @override
  late final GeneratedColumn<String> grammarIds = GeneratedColumn<String>(
    'grammar_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedReadingTimeMeta =
      const VerificationMeta('estimatedReadingTime');
  @override
  late final GeneratedColumn<int> estimatedReadingTime = GeneratedColumn<int>(
    'estimated_reading_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _questionMeta = const VerificationMeta(
    'question',
  );
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
    'answer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _explanationMeta = const VerificationMeta(
    'explanation',
  );
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Published'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    level,
    passage,
    translation,
    kanjiIds,
    vocabularyIds,
    grammarIds,
    estimatedReadingTime,
    difficulty,
    question,
    answer,
    explanation,
    createdAt,
    updatedAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'master_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<MasterReading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('passage')) {
      context.handle(
        _passageMeta,
        passage.isAcceptableOrUnknown(data['passage']!, _passageMeta),
      );
    } else if (isInserting) {
      context.missing(_passageMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    }
    if (data.containsKey('kanji_ids')) {
      context.handle(
        _kanjiIdsMeta,
        kanjiIds.isAcceptableOrUnknown(data['kanji_ids']!, _kanjiIdsMeta),
      );
    }
    if (data.containsKey('vocabulary_ids')) {
      context.handle(
        _vocabularyIdsMeta,
        vocabularyIds.isAcceptableOrUnknown(
          data['vocabulary_ids']!,
          _vocabularyIdsMeta,
        ),
      );
    }
    if (data.containsKey('grammar_ids')) {
      context.handle(
        _grammarIdsMeta,
        grammarIds.isAcceptableOrUnknown(data['grammar_ids']!, _grammarIdsMeta),
      );
    }
    if (data.containsKey('estimated_reading_time')) {
      context.handle(
        _estimatedReadingTimeMeta,
        estimatedReadingTime.isAcceptableOrUnknown(
          data['estimated_reading_time']!,
          _estimatedReadingTimeMeta,
        ),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('question')) {
      context.handle(
        _questionMeta,
        question.isAcceptableOrUnknown(data['question']!, _questionMeta),
      );
    }
    if (data.containsKey('answer')) {
      context.handle(
        _answerMeta,
        answer.isAcceptableOrUnknown(data['answer']!, _answerMeta),
      );
    }
    if (data.containsKey('explanation')) {
      context.handle(
        _explanationMeta,
        explanation.isAcceptableOrUnknown(
          data['explanation']!,
          _explanationMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MasterReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MasterReading(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      ),
      passage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}passage'],
      )!,
      translation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation'],
      ),
      kanjiIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kanji_ids'],
      ),
      vocabularyIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vocabulary_ids'],
      ),
      grammarIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grammar_ids'],
      ),
      estimatedReadingTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_reading_time'],
      ),
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      ),
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      ),
      answer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer'],
      ),
      explanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $MasterReadingsTable createAlias(String alias) {
    return $MasterReadingsTable(attachedDatabase, alias);
  }
}

class MasterReading extends DataClass implements Insertable<MasterReading> {
  final String id;
  final String title;
  final int? level;
  final String passage;
  final String? translation;
  final String? kanjiIds;
  final String? vocabularyIds;
  final String? grammarIds;
  final int? estimatedReadingTime;
  final String? difficulty;
  final String? question;
  final String? answer;
  final String? explanation;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  const MasterReading({
    required this.id,
    required this.title,
    this.level,
    required this.passage,
    this.translation,
    this.kanjiIds,
    this.vocabularyIds,
    this.grammarIds,
    this.estimatedReadingTime,
    this.difficulty,
    this.question,
    this.answer,
    this.explanation,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || level != null) {
      map['level'] = Variable<int>(level);
    }
    map['passage'] = Variable<String>(passage);
    if (!nullToAbsent || translation != null) {
      map['translation'] = Variable<String>(translation);
    }
    if (!nullToAbsent || kanjiIds != null) {
      map['kanji_ids'] = Variable<String>(kanjiIds);
    }
    if (!nullToAbsent || vocabularyIds != null) {
      map['vocabulary_ids'] = Variable<String>(vocabularyIds);
    }
    if (!nullToAbsent || grammarIds != null) {
      map['grammar_ids'] = Variable<String>(grammarIds);
    }
    if (!nullToAbsent || estimatedReadingTime != null) {
      map['estimated_reading_time'] = Variable<int>(estimatedReadingTime);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<String>(difficulty);
    }
    if (!nullToAbsent || question != null) {
      map['question'] = Variable<String>(question);
    }
    if (!nullToAbsent || answer != null) {
      map['answer'] = Variable<String>(answer);
    }
    if (!nullToAbsent || explanation != null) {
      map['explanation'] = Variable<String>(explanation);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['status'] = Variable<String>(status);
    return map;
  }

  MasterReadingsCompanion toCompanion(bool nullToAbsent) {
    return MasterReadingsCompanion(
      id: Value(id),
      title: Value(title),
      level: level == null && nullToAbsent
          ? const Value.absent()
          : Value(level),
      passage: Value(passage),
      translation: translation == null && nullToAbsent
          ? const Value.absent()
          : Value(translation),
      kanjiIds: kanjiIds == null && nullToAbsent
          ? const Value.absent()
          : Value(kanjiIds),
      vocabularyIds: vocabularyIds == null && nullToAbsent
          ? const Value.absent()
          : Value(vocabularyIds),
      grammarIds: grammarIds == null && nullToAbsent
          ? const Value.absent()
          : Value(grammarIds),
      estimatedReadingTime: estimatedReadingTime == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedReadingTime),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      question: question == null && nullToAbsent
          ? const Value.absent()
          : Value(question),
      answer: answer == null && nullToAbsent
          ? const Value.absent()
          : Value(answer),
      explanation: explanation == null && nullToAbsent
          ? const Value.absent()
          : Value(explanation),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      status: Value(status),
    );
  }

  factory MasterReading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MasterReading(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      level: serializer.fromJson<int?>(json['level']),
      passage: serializer.fromJson<String>(json['passage']),
      translation: serializer.fromJson<String?>(json['translation']),
      kanjiIds: serializer.fromJson<String?>(json['kanjiIds']),
      vocabularyIds: serializer.fromJson<String?>(json['vocabularyIds']),
      grammarIds: serializer.fromJson<String?>(json['grammarIds']),
      estimatedReadingTime: serializer.fromJson<int?>(
        json['estimatedReadingTime'],
      ),
      difficulty: serializer.fromJson<String?>(json['difficulty']),
      question: serializer.fromJson<String?>(json['question']),
      answer: serializer.fromJson<String?>(json['answer']),
      explanation: serializer.fromJson<String?>(json['explanation']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'level': serializer.toJson<int?>(level),
      'passage': serializer.toJson<String>(passage),
      'translation': serializer.toJson<String?>(translation),
      'kanjiIds': serializer.toJson<String?>(kanjiIds),
      'vocabularyIds': serializer.toJson<String?>(vocabularyIds),
      'grammarIds': serializer.toJson<String?>(grammarIds),
      'estimatedReadingTime': serializer.toJson<int?>(estimatedReadingTime),
      'difficulty': serializer.toJson<String?>(difficulty),
      'question': serializer.toJson<String?>(question),
      'answer': serializer.toJson<String?>(answer),
      'explanation': serializer.toJson<String?>(explanation),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'status': serializer.toJson<String>(status),
    };
  }

  MasterReading copyWith({
    String? id,
    String? title,
    Value<int?> level = const Value.absent(),
    String? passage,
    Value<String?> translation = const Value.absent(),
    Value<String?> kanjiIds = const Value.absent(),
    Value<String?> vocabularyIds = const Value.absent(),
    Value<String?> grammarIds = const Value.absent(),
    Value<int?> estimatedReadingTime = const Value.absent(),
    Value<String?> difficulty = const Value.absent(),
    Value<String?> question = const Value.absent(),
    Value<String?> answer = const Value.absent(),
    Value<String?> explanation = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
  }) => MasterReading(
    id: id ?? this.id,
    title: title ?? this.title,
    level: level.present ? level.value : this.level,
    passage: passage ?? this.passage,
    translation: translation.present ? translation.value : this.translation,
    kanjiIds: kanjiIds.present ? kanjiIds.value : this.kanjiIds,
    vocabularyIds: vocabularyIds.present
        ? vocabularyIds.value
        : this.vocabularyIds,
    grammarIds: grammarIds.present ? grammarIds.value : this.grammarIds,
    estimatedReadingTime: estimatedReadingTime.present
        ? estimatedReadingTime.value
        : this.estimatedReadingTime,
    difficulty: difficulty.present ? difficulty.value : this.difficulty,
    question: question.present ? question.value : this.question,
    answer: answer.present ? answer.value : this.answer,
    explanation: explanation.present ? explanation.value : this.explanation,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    status: status ?? this.status,
  );
  MasterReading copyWithCompanion(MasterReadingsCompanion data) {
    return MasterReading(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      level: data.level.present ? data.level.value : this.level,
      passage: data.passage.present ? data.passage.value : this.passage,
      translation: data.translation.present
          ? data.translation.value
          : this.translation,
      kanjiIds: data.kanjiIds.present ? data.kanjiIds.value : this.kanjiIds,
      vocabularyIds: data.vocabularyIds.present
          ? data.vocabularyIds.value
          : this.vocabularyIds,
      grammarIds: data.grammarIds.present
          ? data.grammarIds.value
          : this.grammarIds,
      estimatedReadingTime: data.estimatedReadingTime.present
          ? data.estimatedReadingTime.value
          : this.estimatedReadingTime,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      question: data.question.present ? data.question.value : this.question,
      answer: data.answer.present ? data.answer.value : this.answer,
      explanation: data.explanation.present
          ? data.explanation.value
          : this.explanation,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MasterReading(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('level: $level, ')
          ..write('passage: $passage, ')
          ..write('translation: $translation, ')
          ..write('kanjiIds: $kanjiIds, ')
          ..write('vocabularyIds: $vocabularyIds, ')
          ..write('grammarIds: $grammarIds, ')
          ..write('estimatedReadingTime: $estimatedReadingTime, ')
          ..write('difficulty: $difficulty, ')
          ..write('question: $question, ')
          ..write('answer: $answer, ')
          ..write('explanation: $explanation, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    level,
    passage,
    translation,
    kanjiIds,
    vocabularyIds,
    grammarIds,
    estimatedReadingTime,
    difficulty,
    question,
    answer,
    explanation,
    createdAt,
    updatedAt,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MasterReading &&
          other.id == this.id &&
          other.title == this.title &&
          other.level == this.level &&
          other.passage == this.passage &&
          other.translation == this.translation &&
          other.kanjiIds == this.kanjiIds &&
          other.vocabularyIds == this.vocabularyIds &&
          other.grammarIds == this.grammarIds &&
          other.estimatedReadingTime == this.estimatedReadingTime &&
          other.difficulty == this.difficulty &&
          other.question == this.question &&
          other.answer == this.answer &&
          other.explanation == this.explanation &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.status == this.status);
}

class MasterReadingsCompanion extends UpdateCompanion<MasterReading> {
  final Value<String> id;
  final Value<String> title;
  final Value<int?> level;
  final Value<String> passage;
  final Value<String?> translation;
  final Value<String?> kanjiIds;
  final Value<String?> vocabularyIds;
  final Value<String?> grammarIds;
  final Value<int?> estimatedReadingTime;
  final Value<String?> difficulty;
  final Value<String?> question;
  final Value<String?> answer;
  final Value<String?> explanation;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> status;
  final Value<int> rowid;
  const MasterReadingsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.level = const Value.absent(),
    this.passage = const Value.absent(),
    this.translation = const Value.absent(),
    this.kanjiIds = const Value.absent(),
    this.vocabularyIds = const Value.absent(),
    this.grammarIds = const Value.absent(),
    this.estimatedReadingTime = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.question = const Value.absent(),
    this.answer = const Value.absent(),
    this.explanation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MasterReadingsCompanion.insert({
    required String id,
    required String title,
    this.level = const Value.absent(),
    required String passage,
    this.translation = const Value.absent(),
    this.kanjiIds = const Value.absent(),
    this.vocabularyIds = const Value.absent(),
    this.grammarIds = const Value.absent(),
    this.estimatedReadingTime = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.question = const Value.absent(),
    this.answer = const Value.absent(),
    this.explanation = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       passage = Value(passage),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MasterReading> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? level,
    Expression<String>? passage,
    Expression<String>? translation,
    Expression<String>? kanjiIds,
    Expression<String>? vocabularyIds,
    Expression<String>? grammarIds,
    Expression<int>? estimatedReadingTime,
    Expression<String>? difficulty,
    Expression<String>? question,
    Expression<String>? answer,
    Expression<String>? explanation,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (level != null) 'level': level,
      if (passage != null) 'passage': passage,
      if (translation != null) 'translation': translation,
      if (kanjiIds != null) 'kanji_ids': kanjiIds,
      if (vocabularyIds != null) 'vocabulary_ids': vocabularyIds,
      if (grammarIds != null) 'grammar_ids': grammarIds,
      if (estimatedReadingTime != null)
        'estimated_reading_time': estimatedReadingTime,
      if (difficulty != null) 'difficulty': difficulty,
      if (question != null) 'question': question,
      if (answer != null) 'answer': answer,
      if (explanation != null) 'explanation': explanation,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MasterReadingsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int?>? level,
    Value<String>? passage,
    Value<String?>? translation,
    Value<String?>? kanjiIds,
    Value<String?>? vocabularyIds,
    Value<String?>? grammarIds,
    Value<int?>? estimatedReadingTime,
    Value<String?>? difficulty,
    Value<String?>? question,
    Value<String?>? answer,
    Value<String?>? explanation,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return MasterReadingsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      level: level ?? this.level,
      passage: passage ?? this.passage,
      translation: translation ?? this.translation,
      kanjiIds: kanjiIds ?? this.kanjiIds,
      vocabularyIds: vocabularyIds ?? this.vocabularyIds,
      grammarIds: grammarIds ?? this.grammarIds,
      estimatedReadingTime: estimatedReadingTime ?? this.estimatedReadingTime,
      difficulty: difficulty ?? this.difficulty,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      explanation: explanation ?? this.explanation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (passage.present) {
      map['passage'] = Variable<String>(passage.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (kanjiIds.present) {
      map['kanji_ids'] = Variable<String>(kanjiIds.value);
    }
    if (vocabularyIds.present) {
      map['vocabulary_ids'] = Variable<String>(vocabularyIds.value);
    }
    if (grammarIds.present) {
      map['grammar_ids'] = Variable<String>(grammarIds.value);
    }
    if (estimatedReadingTime.present) {
      map['estimated_reading_time'] = Variable<int>(estimatedReadingTime.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MasterReadingsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('level: $level, ')
          ..write('passage: $passage, ')
          ..write('translation: $translation, ')
          ..write('kanjiIds: $kanjiIds, ')
          ..write('vocabularyIds: $vocabularyIds, ')
          ..write('grammarIds: $grammarIds, ')
          ..write('estimatedReadingTime: $estimatedReadingTime, ')
          ..write('difficulty: $difficulty, ')
          ..write('question: $question, ')
          ..write('answer: $answer, ')
          ..write('explanation: $explanation, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserReadingsTable extends UserReadings
    with TableInfo<$UserReadingsTable, UserReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _masterReadingIdMeta = const VerificationMeta(
    'masterReadingId',
  );
  @override
  late final GeneratedColumn<String> masterReadingId = GeneratedColumn<String>(
    'master_reading_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_readings(id) ON DELETE CASCADE NOT NULL',
  );
  static const VerificationMeta _isAddedMeta = const VerificationMeta(
    'isAdded',
  );
  @override
  late final GeneratedColumn<bool> isAdded = GeneratedColumn<bool>(
    'is_added',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_added" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unlearned'),
  );
  static const VerificationMeta _customNotesMeta = const VerificationMeta(
    'customNotes',
  );
  @override
  late final GeneratedColumn<String> customNotes = GeneratedColumn<String>(
    'custom_notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    masterReadingId,
    isAdded,
    isFavorite,
    status,
    customNotes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserReading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('master_reading_id')) {
      context.handle(
        _masterReadingIdMeta,
        masterReadingId.isAcceptableOrUnknown(
          data['master_reading_id']!,
          _masterReadingIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_masterReadingIdMeta);
    }
    if (data.containsKey('is_added')) {
      context.handle(
        _isAddedMeta,
        isAdded.isAcceptableOrUnknown(data['is_added']!, _isAddedMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('custom_notes')) {
      context.handle(
        _customNotesMeta,
        customNotes.isAcceptableOrUnknown(
          data['custom_notes']!,
          _customNotesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserReading(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      masterReadingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}master_reading_id'],
      )!,
      isAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_added'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      customNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserReadingsTable createAlias(String alias) {
    return $UserReadingsTable(attachedDatabase, alias);
  }
}

class UserReading extends DataClass implements Insertable<UserReading> {
  final String id;
  final String masterReadingId;
  final bool isAdded;
  final bool isFavorite;
  final String status;
  final String customNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserReading({
    required this.id,
    required this.masterReadingId,
    required this.isAdded,
    required this.isFavorite,
    required this.status,
    required this.customNotes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['master_reading_id'] = Variable<String>(masterReadingId);
    map['is_added'] = Variable<bool>(isAdded);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['status'] = Variable<String>(status);
    map['custom_notes'] = Variable<String>(customNotes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserReadingsCompanion toCompanion(bool nullToAbsent) {
    return UserReadingsCompanion(
      id: Value(id),
      masterReadingId: Value(masterReadingId),
      isAdded: Value(isAdded),
      isFavorite: Value(isFavorite),
      status: Value(status),
      customNotes: Value(customNotes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserReading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserReading(
      id: serializer.fromJson<String>(json['id']),
      masterReadingId: serializer.fromJson<String>(json['masterReadingId']),
      isAdded: serializer.fromJson<bool>(json['isAdded']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      status: serializer.fromJson<String>(json['status']),
      customNotes: serializer.fromJson<String>(json['customNotes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'masterReadingId': serializer.toJson<String>(masterReadingId),
      'isAdded': serializer.toJson<bool>(isAdded),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'status': serializer.toJson<String>(status),
      'customNotes': serializer.toJson<String>(customNotes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserReading copyWith({
    String? id,
    String? masterReadingId,
    bool? isAdded,
    bool? isFavorite,
    String? status,
    String? customNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserReading(
    id: id ?? this.id,
    masterReadingId: masterReadingId ?? this.masterReadingId,
    isAdded: isAdded ?? this.isAdded,
    isFavorite: isFavorite ?? this.isFavorite,
    status: status ?? this.status,
    customNotes: customNotes ?? this.customNotes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserReading copyWithCompanion(UserReadingsCompanion data) {
    return UserReading(
      id: data.id.present ? data.id.value : this.id,
      masterReadingId: data.masterReadingId.present
          ? data.masterReadingId.value
          : this.masterReadingId,
      isAdded: data.isAdded.present ? data.isAdded.value : this.isAdded,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      status: data.status.present ? data.status.value : this.status,
      customNotes: data.customNotes.present
          ? data.customNotes.value
          : this.customNotes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserReading(')
          ..write('id: $id, ')
          ..write('masterReadingId: $masterReadingId, ')
          ..write('isAdded: $isAdded, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('status: $status, ')
          ..write('customNotes: $customNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    masterReadingId,
    isAdded,
    isFavorite,
    status,
    customNotes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserReading &&
          other.id == this.id &&
          other.masterReadingId == this.masterReadingId &&
          other.isAdded == this.isAdded &&
          other.isFavorite == this.isFavorite &&
          other.status == this.status &&
          other.customNotes == this.customNotes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserReadingsCompanion extends UpdateCompanion<UserReading> {
  final Value<String> id;
  final Value<String> masterReadingId;
  final Value<bool> isAdded;
  final Value<bool> isFavorite;
  final Value<String> status;
  final Value<String> customNotes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserReadingsCompanion({
    this.id = const Value.absent(),
    this.masterReadingId = const Value.absent(),
    this.isAdded = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.status = const Value.absent(),
    this.customNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserReadingsCompanion.insert({
    required String id,
    required String masterReadingId,
    this.isAdded = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.status = const Value.absent(),
    this.customNotes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       masterReadingId = Value(masterReadingId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserReading> custom({
    Expression<String>? id,
    Expression<String>? masterReadingId,
    Expression<bool>? isAdded,
    Expression<bool>? isFavorite,
    Expression<String>? status,
    Expression<String>? customNotes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (masterReadingId != null) 'master_reading_id': masterReadingId,
      if (isAdded != null) 'is_added': isAdded,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (status != null) 'status': status,
      if (customNotes != null) 'custom_notes': customNotes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserReadingsCompanion copyWith({
    Value<String>? id,
    Value<String>? masterReadingId,
    Value<bool>? isAdded,
    Value<bool>? isFavorite,
    Value<String>? status,
    Value<String>? customNotes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserReadingsCompanion(
      id: id ?? this.id,
      masterReadingId: masterReadingId ?? this.masterReadingId,
      isAdded: isAdded ?? this.isAdded,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
      customNotes: customNotes ?? this.customNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (masterReadingId.present) {
      map['master_reading_id'] = Variable<String>(masterReadingId.value);
    }
    if (isAdded.present) {
      map['is_added'] = Variable<bool>(isAdded.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (customNotes.present) {
      map['custom_notes'] = Variable<String>(customNotes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserReadingsCompanion(')
          ..write('id: $id, ')
          ..write('masterReadingId: $masterReadingId, ')
          ..write('isAdded: $isAdded, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('status: $status, ')
          ..write('customNotes: $customNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MasterListeningsTable extends MasterListenings
    with TableInfo<$MasterListeningsTable, MasterListening> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MasterListeningsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transcriptMeta = const VerificationMeta(
    'transcript',
  );
  @override
  late final GeneratedColumn<String> transcript = GeneratedColumn<String>(
    'transcript',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioPathMeta = const VerificationMeta(
    'audioPath',
  );
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
    'audio_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lengthMeta = const VerificationMeta('length');
  @override
  late final GeneratedColumn<int> length = GeneratedColumn<int>(
    'length',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kanjiIdsMeta = const VerificationMeta(
    'kanjiIds',
  );
  @override
  late final GeneratedColumn<String> kanjiIds = GeneratedColumn<String>(
    'kanji_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vocabularyIdsMeta = const VerificationMeta(
    'vocabularyIds',
  );
  @override
  late final GeneratedColumn<String> vocabularyIds = GeneratedColumn<String>(
    'vocabulary_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grammarIdsMeta = const VerificationMeta(
    'grammarIds',
  );
  @override
  late final GeneratedColumn<String> grammarIds = GeneratedColumn<String>(
    'grammar_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _questionMeta = const VerificationMeta(
    'question',
  );
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
    'answer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _explanationMeta = const VerificationMeta(
    'explanation',
  );
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Published'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    transcript,
    audioPath,
    length,
    difficulty,
    kanjiIds,
    vocabularyIds,
    grammarIds,
    question,
    answer,
    explanation,
    createdAt,
    updatedAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'master_listenings';
  @override
  VerificationContext validateIntegrity(
    Insertable<MasterListening> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('transcript')) {
      context.handle(
        _transcriptMeta,
        transcript.isAcceptableOrUnknown(data['transcript']!, _transcriptMeta),
      );
    } else if (isInserting) {
      context.missing(_transcriptMeta);
    }
    if (data.containsKey('audio_path')) {
      context.handle(
        _audioPathMeta,
        audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta),
      );
    }
    if (data.containsKey('length')) {
      context.handle(
        _lengthMeta,
        length.isAcceptableOrUnknown(data['length']!, _lengthMeta),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('kanji_ids')) {
      context.handle(
        _kanjiIdsMeta,
        kanjiIds.isAcceptableOrUnknown(data['kanji_ids']!, _kanjiIdsMeta),
      );
    }
    if (data.containsKey('vocabulary_ids')) {
      context.handle(
        _vocabularyIdsMeta,
        vocabularyIds.isAcceptableOrUnknown(
          data['vocabulary_ids']!,
          _vocabularyIdsMeta,
        ),
      );
    }
    if (data.containsKey('grammar_ids')) {
      context.handle(
        _grammarIdsMeta,
        grammarIds.isAcceptableOrUnknown(data['grammar_ids']!, _grammarIdsMeta),
      );
    }
    if (data.containsKey('question')) {
      context.handle(
        _questionMeta,
        question.isAcceptableOrUnknown(data['question']!, _questionMeta),
      );
    }
    if (data.containsKey('answer')) {
      context.handle(
        _answerMeta,
        answer.isAcceptableOrUnknown(data['answer']!, _answerMeta),
      );
    }
    if (data.containsKey('explanation')) {
      context.handle(
        _explanationMeta,
        explanation.isAcceptableOrUnknown(
          data['explanation']!,
          _explanationMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MasterListening map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MasterListening(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      transcript: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transcript'],
      )!,
      audioPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_path'],
      ),
      length: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}length'],
      ),
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      ),
      kanjiIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kanji_ids'],
      ),
      vocabularyIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vocabulary_ids'],
      ),
      grammarIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grammar_ids'],
      ),
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      ),
      answer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer'],
      ),
      explanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $MasterListeningsTable createAlias(String alias) {
    return $MasterListeningsTable(attachedDatabase, alias);
  }
}

class MasterListening extends DataClass implements Insertable<MasterListening> {
  final String id;
  final String title;
  final String transcript;
  final String? audioPath;
  final int? length;
  final String? difficulty;
  final String? kanjiIds;
  final String? vocabularyIds;
  final String? grammarIds;
  final String? question;
  final String? answer;
  final String? explanation;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  const MasterListening({
    required this.id,
    required this.title,
    required this.transcript,
    this.audioPath,
    this.length,
    this.difficulty,
    this.kanjiIds,
    this.vocabularyIds,
    this.grammarIds,
    this.question,
    this.answer,
    this.explanation,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['transcript'] = Variable<String>(transcript);
    if (!nullToAbsent || audioPath != null) {
      map['audio_path'] = Variable<String>(audioPath);
    }
    if (!nullToAbsent || length != null) {
      map['length'] = Variable<int>(length);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<String>(difficulty);
    }
    if (!nullToAbsent || kanjiIds != null) {
      map['kanji_ids'] = Variable<String>(kanjiIds);
    }
    if (!nullToAbsent || vocabularyIds != null) {
      map['vocabulary_ids'] = Variable<String>(vocabularyIds);
    }
    if (!nullToAbsent || grammarIds != null) {
      map['grammar_ids'] = Variable<String>(grammarIds);
    }
    if (!nullToAbsent || question != null) {
      map['question'] = Variable<String>(question);
    }
    if (!nullToAbsent || answer != null) {
      map['answer'] = Variable<String>(answer);
    }
    if (!nullToAbsent || explanation != null) {
      map['explanation'] = Variable<String>(explanation);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['status'] = Variable<String>(status);
    return map;
  }

  MasterListeningsCompanion toCompanion(bool nullToAbsent) {
    return MasterListeningsCompanion(
      id: Value(id),
      title: Value(title),
      transcript: Value(transcript),
      audioPath: audioPath == null && nullToAbsent
          ? const Value.absent()
          : Value(audioPath),
      length: length == null && nullToAbsent
          ? const Value.absent()
          : Value(length),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      kanjiIds: kanjiIds == null && nullToAbsent
          ? const Value.absent()
          : Value(kanjiIds),
      vocabularyIds: vocabularyIds == null && nullToAbsent
          ? const Value.absent()
          : Value(vocabularyIds),
      grammarIds: grammarIds == null && nullToAbsent
          ? const Value.absent()
          : Value(grammarIds),
      question: question == null && nullToAbsent
          ? const Value.absent()
          : Value(question),
      answer: answer == null && nullToAbsent
          ? const Value.absent()
          : Value(answer),
      explanation: explanation == null && nullToAbsent
          ? const Value.absent()
          : Value(explanation),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      status: Value(status),
    );
  }

  factory MasterListening.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MasterListening(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      transcript: serializer.fromJson<String>(json['transcript']),
      audioPath: serializer.fromJson<String?>(json['audioPath']),
      length: serializer.fromJson<int?>(json['length']),
      difficulty: serializer.fromJson<String?>(json['difficulty']),
      kanjiIds: serializer.fromJson<String?>(json['kanjiIds']),
      vocabularyIds: serializer.fromJson<String?>(json['vocabularyIds']),
      grammarIds: serializer.fromJson<String?>(json['grammarIds']),
      question: serializer.fromJson<String?>(json['question']),
      answer: serializer.fromJson<String?>(json['answer']),
      explanation: serializer.fromJson<String?>(json['explanation']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'transcript': serializer.toJson<String>(transcript),
      'audioPath': serializer.toJson<String?>(audioPath),
      'length': serializer.toJson<int?>(length),
      'difficulty': serializer.toJson<String?>(difficulty),
      'kanjiIds': serializer.toJson<String?>(kanjiIds),
      'vocabularyIds': serializer.toJson<String?>(vocabularyIds),
      'grammarIds': serializer.toJson<String?>(grammarIds),
      'question': serializer.toJson<String?>(question),
      'answer': serializer.toJson<String?>(answer),
      'explanation': serializer.toJson<String?>(explanation),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'status': serializer.toJson<String>(status),
    };
  }

  MasterListening copyWith({
    String? id,
    String? title,
    String? transcript,
    Value<String?> audioPath = const Value.absent(),
    Value<int?> length = const Value.absent(),
    Value<String?> difficulty = const Value.absent(),
    Value<String?> kanjiIds = const Value.absent(),
    Value<String?> vocabularyIds = const Value.absent(),
    Value<String?> grammarIds = const Value.absent(),
    Value<String?> question = const Value.absent(),
    Value<String?> answer = const Value.absent(),
    Value<String?> explanation = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
  }) => MasterListening(
    id: id ?? this.id,
    title: title ?? this.title,
    transcript: transcript ?? this.transcript,
    audioPath: audioPath.present ? audioPath.value : this.audioPath,
    length: length.present ? length.value : this.length,
    difficulty: difficulty.present ? difficulty.value : this.difficulty,
    kanjiIds: kanjiIds.present ? kanjiIds.value : this.kanjiIds,
    vocabularyIds: vocabularyIds.present
        ? vocabularyIds.value
        : this.vocabularyIds,
    grammarIds: grammarIds.present ? grammarIds.value : this.grammarIds,
    question: question.present ? question.value : this.question,
    answer: answer.present ? answer.value : this.answer,
    explanation: explanation.present ? explanation.value : this.explanation,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    status: status ?? this.status,
  );
  MasterListening copyWithCompanion(MasterListeningsCompanion data) {
    return MasterListening(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      transcript: data.transcript.present
          ? data.transcript.value
          : this.transcript,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
      length: data.length.present ? data.length.value : this.length,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      kanjiIds: data.kanjiIds.present ? data.kanjiIds.value : this.kanjiIds,
      vocabularyIds: data.vocabularyIds.present
          ? data.vocabularyIds.value
          : this.vocabularyIds,
      grammarIds: data.grammarIds.present
          ? data.grammarIds.value
          : this.grammarIds,
      question: data.question.present ? data.question.value : this.question,
      answer: data.answer.present ? data.answer.value : this.answer,
      explanation: data.explanation.present
          ? data.explanation.value
          : this.explanation,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MasterListening(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('transcript: $transcript, ')
          ..write('audioPath: $audioPath, ')
          ..write('length: $length, ')
          ..write('difficulty: $difficulty, ')
          ..write('kanjiIds: $kanjiIds, ')
          ..write('vocabularyIds: $vocabularyIds, ')
          ..write('grammarIds: $grammarIds, ')
          ..write('question: $question, ')
          ..write('answer: $answer, ')
          ..write('explanation: $explanation, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    transcript,
    audioPath,
    length,
    difficulty,
    kanjiIds,
    vocabularyIds,
    grammarIds,
    question,
    answer,
    explanation,
    createdAt,
    updatedAt,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MasterListening &&
          other.id == this.id &&
          other.title == this.title &&
          other.transcript == this.transcript &&
          other.audioPath == this.audioPath &&
          other.length == this.length &&
          other.difficulty == this.difficulty &&
          other.kanjiIds == this.kanjiIds &&
          other.vocabularyIds == this.vocabularyIds &&
          other.grammarIds == this.grammarIds &&
          other.question == this.question &&
          other.answer == this.answer &&
          other.explanation == this.explanation &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.status == this.status);
}

class MasterListeningsCompanion extends UpdateCompanion<MasterListening> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> transcript;
  final Value<String?> audioPath;
  final Value<int?> length;
  final Value<String?> difficulty;
  final Value<String?> kanjiIds;
  final Value<String?> vocabularyIds;
  final Value<String?> grammarIds;
  final Value<String?> question;
  final Value<String?> answer;
  final Value<String?> explanation;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> status;
  final Value<int> rowid;
  const MasterListeningsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.transcript = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.length = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.kanjiIds = const Value.absent(),
    this.vocabularyIds = const Value.absent(),
    this.grammarIds = const Value.absent(),
    this.question = const Value.absent(),
    this.answer = const Value.absent(),
    this.explanation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MasterListeningsCompanion.insert({
    required String id,
    required String title,
    required String transcript,
    this.audioPath = const Value.absent(),
    this.length = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.kanjiIds = const Value.absent(),
    this.vocabularyIds = const Value.absent(),
    this.grammarIds = const Value.absent(),
    this.question = const Value.absent(),
    this.answer = const Value.absent(),
    this.explanation = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       transcript = Value(transcript),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MasterListening> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? transcript,
    Expression<String>? audioPath,
    Expression<int>? length,
    Expression<String>? difficulty,
    Expression<String>? kanjiIds,
    Expression<String>? vocabularyIds,
    Expression<String>? grammarIds,
    Expression<String>? question,
    Expression<String>? answer,
    Expression<String>? explanation,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (transcript != null) 'transcript': transcript,
      if (audioPath != null) 'audio_path': audioPath,
      if (length != null) 'length': length,
      if (difficulty != null) 'difficulty': difficulty,
      if (kanjiIds != null) 'kanji_ids': kanjiIds,
      if (vocabularyIds != null) 'vocabulary_ids': vocabularyIds,
      if (grammarIds != null) 'grammar_ids': grammarIds,
      if (question != null) 'question': question,
      if (answer != null) 'answer': answer,
      if (explanation != null) 'explanation': explanation,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MasterListeningsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? transcript,
    Value<String?>? audioPath,
    Value<int?>? length,
    Value<String?>? difficulty,
    Value<String?>? kanjiIds,
    Value<String?>? vocabularyIds,
    Value<String?>? grammarIds,
    Value<String?>? question,
    Value<String?>? answer,
    Value<String?>? explanation,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return MasterListeningsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      transcript: transcript ?? this.transcript,
      audioPath: audioPath ?? this.audioPath,
      length: length ?? this.length,
      difficulty: difficulty ?? this.difficulty,
      kanjiIds: kanjiIds ?? this.kanjiIds,
      vocabularyIds: vocabularyIds ?? this.vocabularyIds,
      grammarIds: grammarIds ?? this.grammarIds,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      explanation: explanation ?? this.explanation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (transcript.present) {
      map['transcript'] = Variable<String>(transcript.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    if (length.present) {
      map['length'] = Variable<int>(length.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (kanjiIds.present) {
      map['kanji_ids'] = Variable<String>(kanjiIds.value);
    }
    if (vocabularyIds.present) {
      map['vocabulary_ids'] = Variable<String>(vocabularyIds.value);
    }
    if (grammarIds.present) {
      map['grammar_ids'] = Variable<String>(grammarIds.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MasterListeningsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('transcript: $transcript, ')
          ..write('audioPath: $audioPath, ')
          ..write('length: $length, ')
          ..write('difficulty: $difficulty, ')
          ..write('kanjiIds: $kanjiIds, ')
          ..write('vocabularyIds: $vocabularyIds, ')
          ..write('grammarIds: $grammarIds, ')
          ..write('question: $question, ')
          ..write('answer: $answer, ')
          ..write('explanation: $explanation, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserListeningsTable extends UserListenings
    with TableInfo<$UserListeningsTable, UserListening> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserListeningsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _masterListeningIdMeta = const VerificationMeta(
    'masterListeningId',
  );
  @override
  late final GeneratedColumn<String> masterListeningId =
      GeneratedColumn<String>(
        'master_listening_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints:
            'REFERENCES master_listenings(id) ON DELETE CASCADE NOT NULL',
      );
  static const VerificationMeta _isAddedMeta = const VerificationMeta(
    'isAdded',
  );
  @override
  late final GeneratedColumn<bool> isAdded = GeneratedColumn<bool>(
    'is_added',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_added" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unlearned'),
  );
  static const VerificationMeta _customNotesMeta = const VerificationMeta(
    'customNotes',
  );
  @override
  late final GeneratedColumn<String> customNotes = GeneratedColumn<String>(
    'custom_notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    masterListeningId,
    isAdded,
    isFavorite,
    status,
    customNotes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_listenings';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserListening> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('master_listening_id')) {
      context.handle(
        _masterListeningIdMeta,
        masterListeningId.isAcceptableOrUnknown(
          data['master_listening_id']!,
          _masterListeningIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_masterListeningIdMeta);
    }
    if (data.containsKey('is_added')) {
      context.handle(
        _isAddedMeta,
        isAdded.isAcceptableOrUnknown(data['is_added']!, _isAddedMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('custom_notes')) {
      context.handle(
        _customNotesMeta,
        customNotes.isAcceptableOrUnknown(
          data['custom_notes']!,
          _customNotesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserListening map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserListening(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      masterListeningId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}master_listening_id'],
      )!,
      isAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_added'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      customNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserListeningsTable createAlias(String alias) {
    return $UserListeningsTable(attachedDatabase, alias);
  }
}

class UserListening extends DataClass implements Insertable<UserListening> {
  final String id;
  final String masterListeningId;
  final bool isAdded;
  final bool isFavorite;
  final String status;
  final String customNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserListening({
    required this.id,
    required this.masterListeningId,
    required this.isAdded,
    required this.isFavorite,
    required this.status,
    required this.customNotes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['master_listening_id'] = Variable<String>(masterListeningId);
    map['is_added'] = Variable<bool>(isAdded);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['status'] = Variable<String>(status);
    map['custom_notes'] = Variable<String>(customNotes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserListeningsCompanion toCompanion(bool nullToAbsent) {
    return UserListeningsCompanion(
      id: Value(id),
      masterListeningId: Value(masterListeningId),
      isAdded: Value(isAdded),
      isFavorite: Value(isFavorite),
      status: Value(status),
      customNotes: Value(customNotes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserListening.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserListening(
      id: serializer.fromJson<String>(json['id']),
      masterListeningId: serializer.fromJson<String>(json['masterListeningId']),
      isAdded: serializer.fromJson<bool>(json['isAdded']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      status: serializer.fromJson<String>(json['status']),
      customNotes: serializer.fromJson<String>(json['customNotes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'masterListeningId': serializer.toJson<String>(masterListeningId),
      'isAdded': serializer.toJson<bool>(isAdded),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'status': serializer.toJson<String>(status),
      'customNotes': serializer.toJson<String>(customNotes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserListening copyWith({
    String? id,
    String? masterListeningId,
    bool? isAdded,
    bool? isFavorite,
    String? status,
    String? customNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserListening(
    id: id ?? this.id,
    masterListeningId: masterListeningId ?? this.masterListeningId,
    isAdded: isAdded ?? this.isAdded,
    isFavorite: isFavorite ?? this.isFavorite,
    status: status ?? this.status,
    customNotes: customNotes ?? this.customNotes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserListening copyWithCompanion(UserListeningsCompanion data) {
    return UserListening(
      id: data.id.present ? data.id.value : this.id,
      masterListeningId: data.masterListeningId.present
          ? data.masterListeningId.value
          : this.masterListeningId,
      isAdded: data.isAdded.present ? data.isAdded.value : this.isAdded,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      status: data.status.present ? data.status.value : this.status,
      customNotes: data.customNotes.present
          ? data.customNotes.value
          : this.customNotes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserListening(')
          ..write('id: $id, ')
          ..write('masterListeningId: $masterListeningId, ')
          ..write('isAdded: $isAdded, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('status: $status, ')
          ..write('customNotes: $customNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    masterListeningId,
    isAdded,
    isFavorite,
    status,
    customNotes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserListening &&
          other.id == this.id &&
          other.masterListeningId == this.masterListeningId &&
          other.isAdded == this.isAdded &&
          other.isFavorite == this.isFavorite &&
          other.status == this.status &&
          other.customNotes == this.customNotes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserListeningsCompanion extends UpdateCompanion<UserListening> {
  final Value<String> id;
  final Value<String> masterListeningId;
  final Value<bool> isAdded;
  final Value<bool> isFavorite;
  final Value<String> status;
  final Value<String> customNotes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserListeningsCompanion({
    this.id = const Value.absent(),
    this.masterListeningId = const Value.absent(),
    this.isAdded = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.status = const Value.absent(),
    this.customNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserListeningsCompanion.insert({
    required String id,
    required String masterListeningId,
    this.isAdded = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.status = const Value.absent(),
    this.customNotes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       masterListeningId = Value(masterListeningId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserListening> custom({
    Expression<String>? id,
    Expression<String>? masterListeningId,
    Expression<bool>? isAdded,
    Expression<bool>? isFavorite,
    Expression<String>? status,
    Expression<String>? customNotes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (masterListeningId != null) 'master_listening_id': masterListeningId,
      if (isAdded != null) 'is_added': isAdded,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (status != null) 'status': status,
      if (customNotes != null) 'custom_notes': customNotes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserListeningsCompanion copyWith({
    Value<String>? id,
    Value<String>? masterListeningId,
    Value<bool>? isAdded,
    Value<bool>? isFavorite,
    Value<String>? status,
    Value<String>? customNotes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserListeningsCompanion(
      id: id ?? this.id,
      masterListeningId: masterListeningId ?? this.masterListeningId,
      isAdded: isAdded ?? this.isAdded,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
      customNotes: customNotes ?? this.customNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (masterListeningId.present) {
      map['master_listening_id'] = Variable<String>(masterListeningId.value);
    }
    if (isAdded.present) {
      map['is_added'] = Variable<bool>(isAdded.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (customNotes.present) {
      map['custom_notes'] = Variable<String>(customNotes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserListeningsCompanion(')
          ..write('id: $id, ')
          ..write('masterListeningId: $masterListeningId, ')
          ..write('isAdded: $isAdded, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('status: $status, ')
          ..write('customNotes: $customNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KanjiVocabsTable extends KanjiVocabs
    with TableInfo<$KanjiVocabsTable, KanjiVocab> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiVocabsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kanjiIdMeta = const VerificationMeta(
    'kanjiId',
  );
  @override
  late final GeneratedColumn<String> kanjiId = GeneratedColumn<String>(
    'kanji_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_kanjis(id) ON DELETE CASCADE NOT NULL',
  );
  static const VerificationMeta _vocabIdMeta = const VerificationMeta(
    'vocabId',
  );
  @override
  late final GeneratedColumn<String> vocabId = GeneratedColumn<String>(
    'vocab_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_vocabularies(id) ON DELETE CASCADE NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [kanjiId, vocabId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_vocabs';
  @override
  VerificationContext validateIntegrity(
    Insertable<KanjiVocab> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('kanji_id')) {
      context.handle(
        _kanjiIdMeta,
        kanjiId.isAcceptableOrUnknown(data['kanji_id']!, _kanjiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kanjiIdMeta);
    }
    if (data.containsKey('vocab_id')) {
      context.handle(
        _vocabIdMeta,
        vocabId.isAcceptableOrUnknown(data['vocab_id']!, _vocabIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vocabIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {kanjiId, vocabId};
  @override
  KanjiVocab map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiVocab(
      kanjiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kanji_id'],
      )!,
      vocabId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vocab_id'],
      )!,
    );
  }

  @override
  $KanjiVocabsTable createAlias(String alias) {
    return $KanjiVocabsTable(attachedDatabase, alias);
  }
}

class KanjiVocab extends DataClass implements Insertable<KanjiVocab> {
  final String kanjiId;
  final String vocabId;
  const KanjiVocab({required this.kanjiId, required this.vocabId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['kanji_id'] = Variable<String>(kanjiId);
    map['vocab_id'] = Variable<String>(vocabId);
    return map;
  }

  KanjiVocabsCompanion toCompanion(bool nullToAbsent) {
    return KanjiVocabsCompanion(
      kanjiId: Value(kanjiId),
      vocabId: Value(vocabId),
    );
  }

  factory KanjiVocab.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiVocab(
      kanjiId: serializer.fromJson<String>(json['kanjiId']),
      vocabId: serializer.fromJson<String>(json['vocabId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'kanjiId': serializer.toJson<String>(kanjiId),
      'vocabId': serializer.toJson<String>(vocabId),
    };
  }

  KanjiVocab copyWith({String? kanjiId, String? vocabId}) => KanjiVocab(
    kanjiId: kanjiId ?? this.kanjiId,
    vocabId: vocabId ?? this.vocabId,
  );
  KanjiVocab copyWithCompanion(KanjiVocabsCompanion data) {
    return KanjiVocab(
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
      vocabId: data.vocabId.present ? data.vocabId.value : this.vocabId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiVocab(')
          ..write('kanjiId: $kanjiId, ')
          ..write('vocabId: $vocabId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(kanjiId, vocabId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiVocab &&
          other.kanjiId == this.kanjiId &&
          other.vocabId == this.vocabId);
}

class KanjiVocabsCompanion extends UpdateCompanion<KanjiVocab> {
  final Value<String> kanjiId;
  final Value<String> vocabId;
  final Value<int> rowid;
  const KanjiVocabsCompanion({
    this.kanjiId = const Value.absent(),
    this.vocabId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KanjiVocabsCompanion.insert({
    required String kanjiId,
    required String vocabId,
    this.rowid = const Value.absent(),
  }) : kanjiId = Value(kanjiId),
       vocabId = Value(vocabId);
  static Insertable<KanjiVocab> custom({
    Expression<String>? kanjiId,
    Expression<String>? vocabId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (kanjiId != null) 'kanji_id': kanjiId,
      if (vocabId != null) 'vocab_id': vocabId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KanjiVocabsCompanion copyWith({
    Value<String>? kanjiId,
    Value<String>? vocabId,
    Value<int>? rowid,
  }) {
    return KanjiVocabsCompanion(
      kanjiId: kanjiId ?? this.kanjiId,
      vocabId: vocabId ?? this.vocabId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (kanjiId.present) {
      map['kanji_id'] = Variable<String>(kanjiId.value);
    }
    if (vocabId.present) {
      map['vocab_id'] = Variable<String>(vocabId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiVocabsCompanion(')
          ..write('kanjiId: $kanjiId, ')
          ..write('vocabId: $vocabId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VocabGrammarsTable extends VocabGrammars
    with TableInfo<$VocabGrammarsTable, VocabGrammar> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabGrammarsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _vocabIdMeta = const VerificationMeta(
    'vocabId',
  );
  @override
  late final GeneratedColumn<String> vocabId = GeneratedColumn<String>(
    'vocab_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_vocabularies(id) ON DELETE CASCADE NOT NULL',
  );
  static const VerificationMeta _grammarIdMeta = const VerificationMeta(
    'grammarId',
  );
  @override
  late final GeneratedColumn<String> grammarId = GeneratedColumn<String>(
    'grammar_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_grammars(id) ON DELETE CASCADE NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [vocabId, grammarId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocab_grammars';
  @override
  VerificationContext validateIntegrity(
    Insertable<VocabGrammar> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vocab_id')) {
      context.handle(
        _vocabIdMeta,
        vocabId.isAcceptableOrUnknown(data['vocab_id']!, _vocabIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vocabIdMeta);
    }
    if (data.containsKey('grammar_id')) {
      context.handle(
        _grammarIdMeta,
        grammarId.isAcceptableOrUnknown(data['grammar_id']!, _grammarIdMeta),
      );
    } else if (isInserting) {
      context.missing(_grammarIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vocabId, grammarId};
  @override
  VocabGrammar map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabGrammar(
      vocabId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vocab_id'],
      )!,
      grammarId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grammar_id'],
      )!,
    );
  }

  @override
  $VocabGrammarsTable createAlias(String alias) {
    return $VocabGrammarsTable(attachedDatabase, alias);
  }
}

class VocabGrammar extends DataClass implements Insertable<VocabGrammar> {
  final String vocabId;
  final String grammarId;
  const VocabGrammar({required this.vocabId, required this.grammarId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vocab_id'] = Variable<String>(vocabId);
    map['grammar_id'] = Variable<String>(grammarId);
    return map;
  }

  VocabGrammarsCompanion toCompanion(bool nullToAbsent) {
    return VocabGrammarsCompanion(
      vocabId: Value(vocabId),
      grammarId: Value(grammarId),
    );
  }

  factory VocabGrammar.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabGrammar(
      vocabId: serializer.fromJson<String>(json['vocabId']),
      grammarId: serializer.fromJson<String>(json['grammarId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vocabId': serializer.toJson<String>(vocabId),
      'grammarId': serializer.toJson<String>(grammarId),
    };
  }

  VocabGrammar copyWith({String? vocabId, String? grammarId}) => VocabGrammar(
    vocabId: vocabId ?? this.vocabId,
    grammarId: grammarId ?? this.grammarId,
  );
  VocabGrammar copyWithCompanion(VocabGrammarsCompanion data) {
    return VocabGrammar(
      vocabId: data.vocabId.present ? data.vocabId.value : this.vocabId,
      grammarId: data.grammarId.present ? data.grammarId.value : this.grammarId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabGrammar(')
          ..write('vocabId: $vocabId, ')
          ..write('grammarId: $grammarId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(vocabId, grammarId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabGrammar &&
          other.vocabId == this.vocabId &&
          other.grammarId == this.grammarId);
}

class VocabGrammarsCompanion extends UpdateCompanion<VocabGrammar> {
  final Value<String> vocabId;
  final Value<String> grammarId;
  final Value<int> rowid;
  const VocabGrammarsCompanion({
    this.vocabId = const Value.absent(),
    this.grammarId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VocabGrammarsCompanion.insert({
    required String vocabId,
    required String grammarId,
    this.rowid = const Value.absent(),
  }) : vocabId = Value(vocabId),
       grammarId = Value(grammarId);
  static Insertable<VocabGrammar> custom({
    Expression<String>? vocabId,
    Expression<String>? grammarId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (vocabId != null) 'vocab_id': vocabId,
      if (grammarId != null) 'grammar_id': grammarId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VocabGrammarsCompanion copyWith({
    Value<String>? vocabId,
    Value<String>? grammarId,
    Value<int>? rowid,
  }) {
    return VocabGrammarsCompanion(
      vocabId: vocabId ?? this.vocabId,
      grammarId: grammarId ?? this.grammarId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vocabId.present) {
      map['vocab_id'] = Variable<String>(vocabId.value);
    }
    if (grammarId.present) {
      map['grammar_id'] = Variable<String>(grammarId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabGrammarsCompanion(')
          ..write('vocabId: $vocabId, ')
          ..write('grammarId: $grammarId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GrammarReadingsTable extends GrammarReadings
    with TableInfo<$GrammarReadingsTable, GrammarReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrammarReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _grammarIdMeta = const VerificationMeta(
    'grammarId',
  );
  @override
  late final GeneratedColumn<String> grammarId = GeneratedColumn<String>(
    'grammar_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_grammars(id) ON DELETE CASCADE NOT NULL',
  );
  static const VerificationMeta _readingIdMeta = const VerificationMeta(
    'readingId',
  );
  @override
  late final GeneratedColumn<String> readingId = GeneratedColumn<String>(
    'reading_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_readings(id) ON DELETE CASCADE NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [grammarId, readingId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grammar_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<GrammarReading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('grammar_id')) {
      context.handle(
        _grammarIdMeta,
        grammarId.isAcceptableOrUnknown(data['grammar_id']!, _grammarIdMeta),
      );
    } else if (isInserting) {
      context.missing(_grammarIdMeta);
    }
    if (data.containsKey('reading_id')) {
      context.handle(
        _readingIdMeta,
        readingId.isAcceptableOrUnknown(data['reading_id']!, _readingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_readingIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {grammarId, readingId};
  @override
  GrammarReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrammarReading(
      grammarId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grammar_id'],
      )!,
      readingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_id'],
      )!,
    );
  }

  @override
  $GrammarReadingsTable createAlias(String alias) {
    return $GrammarReadingsTable(attachedDatabase, alias);
  }
}

class GrammarReading extends DataClass implements Insertable<GrammarReading> {
  final String grammarId;
  final String readingId;
  const GrammarReading({required this.grammarId, required this.readingId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['grammar_id'] = Variable<String>(grammarId);
    map['reading_id'] = Variable<String>(readingId);
    return map;
  }

  GrammarReadingsCompanion toCompanion(bool nullToAbsent) {
    return GrammarReadingsCompanion(
      grammarId: Value(grammarId),
      readingId: Value(readingId),
    );
  }

  factory GrammarReading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrammarReading(
      grammarId: serializer.fromJson<String>(json['grammarId']),
      readingId: serializer.fromJson<String>(json['readingId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'grammarId': serializer.toJson<String>(grammarId),
      'readingId': serializer.toJson<String>(readingId),
    };
  }

  GrammarReading copyWith({String? grammarId, String? readingId}) =>
      GrammarReading(
        grammarId: grammarId ?? this.grammarId,
        readingId: readingId ?? this.readingId,
      );
  GrammarReading copyWithCompanion(GrammarReadingsCompanion data) {
    return GrammarReading(
      grammarId: data.grammarId.present ? data.grammarId.value : this.grammarId,
      readingId: data.readingId.present ? data.readingId.value : this.readingId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrammarReading(')
          ..write('grammarId: $grammarId, ')
          ..write('readingId: $readingId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(grammarId, readingId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrammarReading &&
          other.grammarId == this.grammarId &&
          other.readingId == this.readingId);
}

class GrammarReadingsCompanion extends UpdateCompanion<GrammarReading> {
  final Value<String> grammarId;
  final Value<String> readingId;
  final Value<int> rowid;
  const GrammarReadingsCompanion({
    this.grammarId = const Value.absent(),
    this.readingId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GrammarReadingsCompanion.insert({
    required String grammarId,
    required String readingId,
    this.rowid = const Value.absent(),
  }) : grammarId = Value(grammarId),
       readingId = Value(readingId);
  static Insertable<GrammarReading> custom({
    Expression<String>? grammarId,
    Expression<String>? readingId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (grammarId != null) 'grammar_id': grammarId,
      if (readingId != null) 'reading_id': readingId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GrammarReadingsCompanion copyWith({
    Value<String>? grammarId,
    Value<String>? readingId,
    Value<int>? rowid,
  }) {
    return GrammarReadingsCompanion(
      grammarId: grammarId ?? this.grammarId,
      readingId: readingId ?? this.readingId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (grammarId.present) {
      map['grammar_id'] = Variable<String>(grammarId.value);
    }
    if (readingId.present) {
      map['reading_id'] = Variable<String>(readingId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrammarReadingsCompanion(')
          ..write('grammarId: $grammarId, ')
          ..write('readingId: $readingId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReadingListeningsTable extends ReadingListenings
    with TableInfo<$ReadingListeningsTable, ReadingListening> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingListeningsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _readingIdMeta = const VerificationMeta(
    'readingId',
  );
  @override
  late final GeneratedColumn<String> readingId = GeneratedColumn<String>(
    'reading_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_readings(id) ON DELETE CASCADE NOT NULL',
  );
  static const VerificationMeta _listeningIdMeta = const VerificationMeta(
    'listeningId',
  );
  @override
  late final GeneratedColumn<String> listeningId = GeneratedColumn<String>(
    'listening_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_listenings(id) ON DELETE CASCADE NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [readingId, listeningId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_listenings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingListening> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('reading_id')) {
      context.handle(
        _readingIdMeta,
        readingId.isAcceptableOrUnknown(data['reading_id']!, _readingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_readingIdMeta);
    }
    if (data.containsKey('listening_id')) {
      context.handle(
        _listeningIdMeta,
        listeningId.isAcceptableOrUnknown(
          data['listening_id']!,
          _listeningIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_listeningIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {readingId, listeningId};
  @override
  ReadingListening map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingListening(
      readingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_id'],
      )!,
      listeningId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}listening_id'],
      )!,
    );
  }

  @override
  $ReadingListeningsTable createAlias(String alias) {
    return $ReadingListeningsTable(attachedDatabase, alias);
  }
}

class ReadingListening extends DataClass
    implements Insertable<ReadingListening> {
  final String readingId;
  final String listeningId;
  const ReadingListening({required this.readingId, required this.listeningId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['reading_id'] = Variable<String>(readingId);
    map['listening_id'] = Variable<String>(listeningId);
    return map;
  }

  ReadingListeningsCompanion toCompanion(bool nullToAbsent) {
    return ReadingListeningsCompanion(
      readingId: Value(readingId),
      listeningId: Value(listeningId),
    );
  }

  factory ReadingListening.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingListening(
      readingId: serializer.fromJson<String>(json['readingId']),
      listeningId: serializer.fromJson<String>(json['listeningId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'readingId': serializer.toJson<String>(readingId),
      'listeningId': serializer.toJson<String>(listeningId),
    };
  }

  ReadingListening copyWith({String? readingId, String? listeningId}) =>
      ReadingListening(
        readingId: readingId ?? this.readingId,
        listeningId: listeningId ?? this.listeningId,
      );
  ReadingListening copyWithCompanion(ReadingListeningsCompanion data) {
    return ReadingListening(
      readingId: data.readingId.present ? data.readingId.value : this.readingId,
      listeningId: data.listeningId.present
          ? data.listeningId.value
          : this.listeningId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingListening(')
          ..write('readingId: $readingId, ')
          ..write('listeningId: $listeningId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(readingId, listeningId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingListening &&
          other.readingId == this.readingId &&
          other.listeningId == this.listeningId);
}

class ReadingListeningsCompanion extends UpdateCompanion<ReadingListening> {
  final Value<String> readingId;
  final Value<String> listeningId;
  final Value<int> rowid;
  const ReadingListeningsCompanion({
    this.readingId = const Value.absent(),
    this.listeningId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReadingListeningsCompanion.insert({
    required String readingId,
    required String listeningId,
    this.rowid = const Value.absent(),
  }) : readingId = Value(readingId),
       listeningId = Value(listeningId);
  static Insertable<ReadingListening> custom({
    Expression<String>? readingId,
    Expression<String>? listeningId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (readingId != null) 'reading_id': readingId,
      if (listeningId != null) 'listening_id': listeningId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReadingListeningsCompanion copyWith({
    Value<String>? readingId,
    Value<String>? listeningId,
    Value<int>? rowid,
  }) {
    return ReadingListeningsCompanion(
      readingId: readingId ?? this.readingId,
      listeningId: listeningId ?? this.listeningId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (readingId.present) {
      map['reading_id'] = Variable<String>(readingId.value);
    }
    if (listeningId.present) {
      map['listening_id'] = Variable<String>(listeningId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingListeningsCompanion(')
          ..write('readingId: $readingId, ')
          ..write('listeningId: $listeningId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KanjiReadingsTable extends KanjiReadings
    with TableInfo<$KanjiReadingsTable, KanjiReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kanjiIdMeta = const VerificationMeta(
    'kanjiId',
  );
  @override
  late final GeneratedColumn<String> kanjiId = GeneratedColumn<String>(
    'kanji_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_kanjis(id) ON DELETE CASCADE NOT NULL',
  );
  static const VerificationMeta _readingIdMeta = const VerificationMeta(
    'readingId',
  );
  @override
  late final GeneratedColumn<String> readingId = GeneratedColumn<String>(
    'reading_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_readings(id) ON DELETE CASCADE NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [kanjiId, readingId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<KanjiReading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('kanji_id')) {
      context.handle(
        _kanjiIdMeta,
        kanjiId.isAcceptableOrUnknown(data['kanji_id']!, _kanjiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kanjiIdMeta);
    }
    if (data.containsKey('reading_id')) {
      context.handle(
        _readingIdMeta,
        readingId.isAcceptableOrUnknown(data['reading_id']!, _readingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_readingIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {kanjiId, readingId};
  @override
  KanjiReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiReading(
      kanjiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kanji_id'],
      )!,
      readingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_id'],
      )!,
    );
  }

  @override
  $KanjiReadingsTable createAlias(String alias) {
    return $KanjiReadingsTable(attachedDatabase, alias);
  }
}

class KanjiReading extends DataClass implements Insertable<KanjiReading> {
  final String kanjiId;
  final String readingId;
  const KanjiReading({required this.kanjiId, required this.readingId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['kanji_id'] = Variable<String>(kanjiId);
    map['reading_id'] = Variable<String>(readingId);
    return map;
  }

  KanjiReadingsCompanion toCompanion(bool nullToAbsent) {
    return KanjiReadingsCompanion(
      kanjiId: Value(kanjiId),
      readingId: Value(readingId),
    );
  }

  factory KanjiReading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiReading(
      kanjiId: serializer.fromJson<String>(json['kanjiId']),
      readingId: serializer.fromJson<String>(json['readingId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'kanjiId': serializer.toJson<String>(kanjiId),
      'readingId': serializer.toJson<String>(readingId),
    };
  }

  KanjiReading copyWith({String? kanjiId, String? readingId}) => KanjiReading(
    kanjiId: kanjiId ?? this.kanjiId,
    readingId: readingId ?? this.readingId,
  );
  KanjiReading copyWithCompanion(KanjiReadingsCompanion data) {
    return KanjiReading(
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
      readingId: data.readingId.present ? data.readingId.value : this.readingId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiReading(')
          ..write('kanjiId: $kanjiId, ')
          ..write('readingId: $readingId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(kanjiId, readingId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiReading &&
          other.kanjiId == this.kanjiId &&
          other.readingId == this.readingId);
}

class KanjiReadingsCompanion extends UpdateCompanion<KanjiReading> {
  final Value<String> kanjiId;
  final Value<String> readingId;
  final Value<int> rowid;
  const KanjiReadingsCompanion({
    this.kanjiId = const Value.absent(),
    this.readingId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KanjiReadingsCompanion.insert({
    required String kanjiId,
    required String readingId,
    this.rowid = const Value.absent(),
  }) : kanjiId = Value(kanjiId),
       readingId = Value(readingId);
  static Insertable<KanjiReading> custom({
    Expression<String>? kanjiId,
    Expression<String>? readingId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (kanjiId != null) 'kanji_id': kanjiId,
      if (readingId != null) 'reading_id': readingId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KanjiReadingsCompanion copyWith({
    Value<String>? kanjiId,
    Value<String>? readingId,
    Value<int>? rowid,
  }) {
    return KanjiReadingsCompanion(
      kanjiId: kanjiId ?? this.kanjiId,
      readingId: readingId ?? this.readingId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (kanjiId.present) {
      map['kanji_id'] = Variable<String>(kanjiId.value);
    }
    if (readingId.present) {
      map['reading_id'] = Variable<String>(readingId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiReadingsCompanion(')
          ..write('kanjiId: $kanjiId, ')
          ..write('readingId: $readingId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VocabReadingsTable extends VocabReadings
    with TableInfo<$VocabReadingsTable, VocabReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _vocabIdMeta = const VerificationMeta(
    'vocabId',
  );
  @override
  late final GeneratedColumn<String> vocabId = GeneratedColumn<String>(
    'vocab_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_vocabularies(id) ON DELETE CASCADE NOT NULL',
  );
  static const VerificationMeta _readingIdMeta = const VerificationMeta(
    'readingId',
  );
  @override
  late final GeneratedColumn<String> readingId = GeneratedColumn<String>(
    'reading_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'REFERENCES master_readings(id) ON DELETE CASCADE NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [vocabId, readingId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocab_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<VocabReading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vocab_id')) {
      context.handle(
        _vocabIdMeta,
        vocabId.isAcceptableOrUnknown(data['vocab_id']!, _vocabIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vocabIdMeta);
    }
    if (data.containsKey('reading_id')) {
      context.handle(
        _readingIdMeta,
        readingId.isAcceptableOrUnknown(data['reading_id']!, _readingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_readingIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vocabId, readingId};
  @override
  VocabReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabReading(
      vocabId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vocab_id'],
      )!,
      readingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_id'],
      )!,
    );
  }

  @override
  $VocabReadingsTable createAlias(String alias) {
    return $VocabReadingsTable(attachedDatabase, alias);
  }
}

class VocabReading extends DataClass implements Insertable<VocabReading> {
  final String vocabId;
  final String readingId;
  const VocabReading({required this.vocabId, required this.readingId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vocab_id'] = Variable<String>(vocabId);
    map['reading_id'] = Variable<String>(readingId);
    return map;
  }

  VocabReadingsCompanion toCompanion(bool nullToAbsent) {
    return VocabReadingsCompanion(
      vocabId: Value(vocabId),
      readingId: Value(readingId),
    );
  }

  factory VocabReading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabReading(
      vocabId: serializer.fromJson<String>(json['vocabId']),
      readingId: serializer.fromJson<String>(json['readingId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vocabId': serializer.toJson<String>(vocabId),
      'readingId': serializer.toJson<String>(readingId),
    };
  }

  VocabReading copyWith({String? vocabId, String? readingId}) => VocabReading(
    vocabId: vocabId ?? this.vocabId,
    readingId: readingId ?? this.readingId,
  );
  VocabReading copyWithCompanion(VocabReadingsCompanion data) {
    return VocabReading(
      vocabId: data.vocabId.present ? data.vocabId.value : this.vocabId,
      readingId: data.readingId.present ? data.readingId.value : this.readingId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabReading(')
          ..write('vocabId: $vocabId, ')
          ..write('readingId: $readingId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(vocabId, readingId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabReading &&
          other.vocabId == this.vocabId &&
          other.readingId == this.readingId);
}

class VocabReadingsCompanion extends UpdateCompanion<VocabReading> {
  final Value<String> vocabId;
  final Value<String> readingId;
  final Value<int> rowid;
  const VocabReadingsCompanion({
    this.vocabId = const Value.absent(),
    this.readingId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VocabReadingsCompanion.insert({
    required String vocabId,
    required String readingId,
    this.rowid = const Value.absent(),
  }) : vocabId = Value(vocabId),
       readingId = Value(readingId);
  static Insertable<VocabReading> custom({
    Expression<String>? vocabId,
    Expression<String>? readingId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (vocabId != null) 'vocab_id': vocabId,
      if (readingId != null) 'reading_id': readingId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VocabReadingsCompanion copyWith({
    Value<String>? vocabId,
    Value<String>? readingId,
    Value<int>? rowid,
  }) {
    return VocabReadingsCompanion(
      vocabId: vocabId ?? this.vocabId,
      readingId: readingId ?? this.readingId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vocabId.present) {
      map['vocab_id'] = Variable<String>(vocabId.value);
    }
    if (readingId.present) {
      map['reading_id'] = Variable<String>(readingId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabReadingsCompanion(')
          ..write('vocabId: $vocabId, ')
          ..write('readingId: $readingId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudySessionsTable extends StudySessions
    with TableInfo<$StudySessionsTable, StudySession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudySessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, durationSeconds, category];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudySession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudySession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudySession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
    );
  }

  @override
  $StudySessionsTable createAlias(String alias) {
    return $StudySessionsTable(attachedDatabase, alias);
  }
}

class StudySession extends DataClass implements Insertable<StudySession> {
  final String id;
  final DateTime date;
  final int durationSeconds;
  final String category;
  const StudySession({
    required this.id,
    required this.date,
    required this.durationSeconds,
    required this.category,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['category'] = Variable<String>(category);
    return map;
  }

  StudySessionsCompanion toCompanion(bool nullToAbsent) {
    return StudySessionsCompanion(
      id: Value(id),
      date: Value(date),
      durationSeconds: Value(durationSeconds),
      category: Value(category),
    );
  }

  factory StudySession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudySession(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'category': serializer.toJson<String>(category),
    };
  }

  StudySession copyWith({
    String? id,
    DateTime? date,
    int? durationSeconds,
    String? category,
  }) => StudySession(
    id: id ?? this.id,
    date: date ?? this.date,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    category: category ?? this.category,
  );
  StudySession copyWithCompanion(StudySessionsCompanion data) {
    return StudySession(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudySession(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, durationSeconds, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudySession &&
          other.id == this.id &&
          other.date == this.date &&
          other.durationSeconds == this.durationSeconds &&
          other.category == this.category);
}

class StudySessionsCompanion extends UpdateCompanion<StudySession> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<int> durationSeconds;
  final Value<String> category;
  final Value<int> rowid;
  const StudySessionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudySessionsCompanion.insert({
    required String id,
    required DateTime date,
    required int durationSeconds,
    required String category,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       durationSeconds = Value(durationSeconds),
       category = Value(category);
  static Insertable<StudySession> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<int>? durationSeconds,
    Expression<String>? category,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (category != null) 'category': category,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudySessionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<int>? durationSeconds,
    Value<String>? category,
    Value<int>? rowid,
  }) {
    return StudySessionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      category: category ?? this.category,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('category: $category, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyGoalsTable extends DailyGoals
    with TableInfo<$DailyGoalsTable, DailyGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetSecondsMeta = const VerificationMeta(
    'targetSeconds',
  );
  @override
  late final GeneratedColumn<int> targetSeconds = GeneratedColumn<int>(
    'target_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(900),
  );
  static const VerificationMeta _completedSecondsMeta = const VerificationMeta(
    'completedSeconds',
  );
  @override
  late final GeneratedColumn<int> completedSeconds = GeneratedColumn<int>(
    'completed_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _targetItemsMeta = const VerificationMeta(
    'targetItems',
  );
  @override
  late final GeneratedColumn<int> targetItems = GeneratedColumn<int>(
    'target_items',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _completedItemsMeta = const VerificationMeta(
    'completedItems',
  );
  @override
  late final GeneratedColumn<int> completedItems = GeneratedColumn<int>(
    'completed_items',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    targetSeconds,
    completedSeconds,
    targetItems,
    completedItems,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyGoal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('target_seconds')) {
      context.handle(
        _targetSecondsMeta,
        targetSeconds.isAcceptableOrUnknown(
          data['target_seconds']!,
          _targetSecondsMeta,
        ),
      );
    }
    if (data.containsKey('completed_seconds')) {
      context.handle(
        _completedSecondsMeta,
        completedSeconds.isAcceptableOrUnknown(
          data['completed_seconds']!,
          _completedSecondsMeta,
        ),
      );
    }
    if (data.containsKey('target_items')) {
      context.handle(
        _targetItemsMeta,
        targetItems.isAcceptableOrUnknown(
          data['target_items']!,
          _targetItemsMeta,
        ),
      );
    }
    if (data.containsKey('completed_items')) {
      context.handle(
        _completedItemsMeta,
        completedItems.isAcceptableOrUnknown(
          data['completed_items']!,
          _completedItemsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyGoal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      targetSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_seconds'],
      )!,
      completedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_seconds'],
      )!,
      targetItems: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_items'],
      )!,
      completedItems: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_items'],
      )!,
    );
  }

  @override
  $DailyGoalsTable createAlias(String alias) {
    return $DailyGoalsTable(attachedDatabase, alias);
  }
}

class DailyGoal extends DataClass implements Insertable<DailyGoal> {
  final String id;
  final int targetSeconds;
  final int completedSeconds;
  final int targetItems;
  final int completedItems;
  const DailyGoal({
    required this.id,
    required this.targetSeconds,
    required this.completedSeconds,
    required this.targetItems,
    required this.completedItems,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['target_seconds'] = Variable<int>(targetSeconds);
    map['completed_seconds'] = Variable<int>(completedSeconds);
    map['target_items'] = Variable<int>(targetItems);
    map['completed_items'] = Variable<int>(completedItems);
    return map;
  }

  DailyGoalsCompanion toCompanion(bool nullToAbsent) {
    return DailyGoalsCompanion(
      id: Value(id),
      targetSeconds: Value(targetSeconds),
      completedSeconds: Value(completedSeconds),
      targetItems: Value(targetItems),
      completedItems: Value(completedItems),
    );
  }

  factory DailyGoal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyGoal(
      id: serializer.fromJson<String>(json['id']),
      targetSeconds: serializer.fromJson<int>(json['targetSeconds']),
      completedSeconds: serializer.fromJson<int>(json['completedSeconds']),
      targetItems: serializer.fromJson<int>(json['targetItems']),
      completedItems: serializer.fromJson<int>(json['completedItems']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'targetSeconds': serializer.toJson<int>(targetSeconds),
      'completedSeconds': serializer.toJson<int>(completedSeconds),
      'targetItems': serializer.toJson<int>(targetItems),
      'completedItems': serializer.toJson<int>(completedItems),
    };
  }

  DailyGoal copyWith({
    String? id,
    int? targetSeconds,
    int? completedSeconds,
    int? targetItems,
    int? completedItems,
  }) => DailyGoal(
    id: id ?? this.id,
    targetSeconds: targetSeconds ?? this.targetSeconds,
    completedSeconds: completedSeconds ?? this.completedSeconds,
    targetItems: targetItems ?? this.targetItems,
    completedItems: completedItems ?? this.completedItems,
  );
  DailyGoal copyWithCompanion(DailyGoalsCompanion data) {
    return DailyGoal(
      id: data.id.present ? data.id.value : this.id,
      targetSeconds: data.targetSeconds.present
          ? data.targetSeconds.value
          : this.targetSeconds,
      completedSeconds: data.completedSeconds.present
          ? data.completedSeconds.value
          : this.completedSeconds,
      targetItems: data.targetItems.present
          ? data.targetItems.value
          : this.targetItems,
      completedItems: data.completedItems.present
          ? data.completedItems.value
          : this.completedItems,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyGoal(')
          ..write('id: $id, ')
          ..write('targetSeconds: $targetSeconds, ')
          ..write('completedSeconds: $completedSeconds, ')
          ..write('targetItems: $targetItems, ')
          ..write('completedItems: $completedItems')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    targetSeconds,
    completedSeconds,
    targetItems,
    completedItems,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyGoal &&
          other.id == this.id &&
          other.targetSeconds == this.targetSeconds &&
          other.completedSeconds == this.completedSeconds &&
          other.targetItems == this.targetItems &&
          other.completedItems == this.completedItems);
}

class DailyGoalsCompanion extends UpdateCompanion<DailyGoal> {
  final Value<String> id;
  final Value<int> targetSeconds;
  final Value<int> completedSeconds;
  final Value<int> targetItems;
  final Value<int> completedItems;
  final Value<int> rowid;
  const DailyGoalsCompanion({
    this.id = const Value.absent(),
    this.targetSeconds = const Value.absent(),
    this.completedSeconds = const Value.absent(),
    this.targetItems = const Value.absent(),
    this.completedItems = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyGoalsCompanion.insert({
    required String id,
    this.targetSeconds = const Value.absent(),
    this.completedSeconds = const Value.absent(),
    this.targetItems = const Value.absent(),
    this.completedItems = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<DailyGoal> custom({
    Expression<String>? id,
    Expression<int>? targetSeconds,
    Expression<int>? completedSeconds,
    Expression<int>? targetItems,
    Expression<int>? completedItems,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetSeconds != null) 'target_seconds': targetSeconds,
      if (completedSeconds != null) 'completed_seconds': completedSeconds,
      if (targetItems != null) 'target_items': targetItems,
      if (completedItems != null) 'completed_items': completedItems,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyGoalsCompanion copyWith({
    Value<String>? id,
    Value<int>? targetSeconds,
    Value<int>? completedSeconds,
    Value<int>? targetItems,
    Value<int>? completedItems,
    Value<int>? rowid,
  }) {
    return DailyGoalsCompanion(
      id: id ?? this.id,
      targetSeconds: targetSeconds ?? this.targetSeconds,
      completedSeconds: completedSeconds ?? this.completedSeconds,
      targetItems: targetItems ?? this.targetItems,
      completedItems: completedItems ?? this.completedItems,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (targetSeconds.present) {
      map['target_seconds'] = Variable<int>(targetSeconds.value);
    }
    if (completedSeconds.present) {
      map['completed_seconds'] = Variable<int>(completedSeconds.value);
    }
    if (targetItems.present) {
      map['target_items'] = Variable<int>(targetItems.value);
    }
    if (completedItems.present) {
      map['completed_items'] = Variable<int>(completedItems.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyGoalsCompanion(')
          ..write('id: $id, ')
          ..write('targetSeconds: $targetSeconds, ')
          ..write('completedSeconds: $completedSeconds, ')
          ..write('targetItems: $targetItems, ')
          ..write('completedItems: $completedItems, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuizResultsTable extends QuizResults
    with TableInfo<$QuizResultsTable, QuizResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCountMeta = const VerificationMeta(
    'totalCount',
  );
  @override
  late final GeneratedColumn<int> totalCount = GeneratedColumn<int>(
    'total_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quizTypeMeta = const VerificationMeta(
    'quizType',
  );
  @override
  late final GeneratedColumn<String> quizType = GeneratedColumn<String>(
    'quiz_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    correctCount,
    totalCount,
    quizType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quiz_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuizResult> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctCountMeta);
    }
    if (data.containsKey('total_count')) {
      context.handle(
        _totalCountMeta,
        totalCount.isAcceptableOrUnknown(data['total_count']!, _totalCountMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCountMeta);
    }
    if (data.containsKey('quiz_type')) {
      context.handle(
        _quizTypeMeta,
        quizType.isAcceptableOrUnknown(data['quiz_type']!, _quizTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_quizTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizResult(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      totalCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_count'],
      )!,
      quizType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quiz_type'],
      )!,
    );
  }

  @override
  $QuizResultsTable createAlias(String alias) {
    return $QuizResultsTable(attachedDatabase, alias);
  }
}

class QuizResult extends DataClass implements Insertable<QuizResult> {
  final String id;
  final DateTime date;
  final int correctCount;
  final int totalCount;
  final String quizType;
  const QuizResult({
    required this.id,
    required this.date,
    required this.correctCount,
    required this.totalCount,
    required this.quizType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['correct_count'] = Variable<int>(correctCount);
    map['total_count'] = Variable<int>(totalCount);
    map['quiz_type'] = Variable<String>(quizType);
    return map;
  }

  QuizResultsCompanion toCompanion(bool nullToAbsent) {
    return QuizResultsCompanion(
      id: Value(id),
      date: Value(date),
      correctCount: Value(correctCount),
      totalCount: Value(totalCount),
      quizType: Value(quizType),
    );
  }

  factory QuizResult.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizResult(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      totalCount: serializer.fromJson<int>(json['totalCount']),
      quizType: serializer.fromJson<String>(json['quizType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'correctCount': serializer.toJson<int>(correctCount),
      'totalCount': serializer.toJson<int>(totalCount),
      'quizType': serializer.toJson<String>(quizType),
    };
  }

  QuizResult copyWith({
    String? id,
    DateTime? date,
    int? correctCount,
    int? totalCount,
    String? quizType,
  }) => QuizResult(
    id: id ?? this.id,
    date: date ?? this.date,
    correctCount: correctCount ?? this.correctCount,
    totalCount: totalCount ?? this.totalCount,
    quizType: quizType ?? this.quizType,
  );
  QuizResult copyWithCompanion(QuizResultsCompanion data) {
    return QuizResult(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      totalCount: data.totalCount.present
          ? data.totalCount.value
          : this.totalCount,
      quizType: data.quizType.present ? data.quizType.value : this.quizType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizResult(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('correctCount: $correctCount, ')
          ..write('totalCount: $totalCount, ')
          ..write('quizType: $quizType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, correctCount, totalCount, quizType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizResult &&
          other.id == this.id &&
          other.date == this.date &&
          other.correctCount == this.correctCount &&
          other.totalCount == this.totalCount &&
          other.quizType == this.quizType);
}

class QuizResultsCompanion extends UpdateCompanion<QuizResult> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<int> correctCount;
  final Value<int> totalCount;
  final Value<String> quizType;
  final Value<int> rowid;
  const QuizResultsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.quizType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuizResultsCompanion.insert({
    required String id,
    required DateTime date,
    required int correctCount,
    required int totalCount,
    required String quizType,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       correctCount = Value(correctCount),
       totalCount = Value(totalCount),
       quizType = Value(quizType);
  static Insertable<QuizResult> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<int>? correctCount,
    Expression<int>? totalCount,
    Expression<String>? quizType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (correctCount != null) 'correct_count': correctCount,
      if (totalCount != null) 'total_count': totalCount,
      if (quizType != null) 'quiz_type': quizType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuizResultsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<int>? correctCount,
    Value<int>? totalCount,
    Value<String>? quizType,
    Value<int>? rowid,
  }) {
    return QuizResultsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      correctCount: correctCount ?? this.correctCount,
      totalCount: totalCount ?? this.totalCount,
      quizType: quizType ?? this.quizType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (totalCount.present) {
      map['total_count'] = Variable<int>(totalCount.value);
    }
    if (quizType.present) {
      map['quiz_type'] = Variable<String>(quizType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizResultsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('correctCount: $correctCount, ')
          ..write('totalCount: $totalCount, ')
          ..write('quizType: $quizType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyPlansTable extends StudyPlans
    with TableInfo<$StudyPlansTable, StudyPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
    'target_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _availableHoursMeta = const VerificationMeta(
    'availableHours',
  );
  @override
  late final GeneratedColumn<double> availableHours = GeneratedColumn<double>(
    'available_hours',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startDate,
    targetDate,
    availableHours,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    } else if (isInserting) {
      context.missing(_targetDateMeta);
    }
    if (data.containsKey('available_hours')) {
      context.handle(
        _availableHoursMeta,
        availableHours.isAcceptableOrUnknown(
          data['available_hours']!,
          _availableHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_availableHoursMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudyPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_date'],
      )!,
      availableHours: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}available_hours'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $StudyPlansTable createAlias(String alias) {
    return $StudyPlansTable(attachedDatabase, alias);
  }
}

class StudyPlan extends DataClass implements Insertable<StudyPlan> {
  final String id;
  final DateTime startDate;
  final DateTime targetDate;
  final double availableHours;
  final bool isActive;
  const StudyPlan({
    required this.id,
    required this.startDate,
    required this.targetDate,
    required this.availableHours,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['start_date'] = Variable<DateTime>(startDate);
    map['target_date'] = Variable<DateTime>(targetDate);
    map['available_hours'] = Variable<double>(availableHours);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  StudyPlansCompanion toCompanion(bool nullToAbsent) {
    return StudyPlansCompanion(
      id: Value(id),
      startDate: Value(startDate),
      targetDate: Value(targetDate),
      availableHours: Value(availableHours),
      isActive: Value(isActive),
    );
  }

  factory StudyPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyPlan(
      id: serializer.fromJson<String>(json['id']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      targetDate: serializer.fromJson<DateTime>(json['targetDate']),
      availableHours: serializer.fromJson<double>(json['availableHours']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startDate': serializer.toJson<DateTime>(startDate),
      'targetDate': serializer.toJson<DateTime>(targetDate),
      'availableHours': serializer.toJson<double>(availableHours),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  StudyPlan copyWith({
    String? id,
    DateTime? startDate,
    DateTime? targetDate,
    double? availableHours,
    bool? isActive,
  }) => StudyPlan(
    id: id ?? this.id,
    startDate: startDate ?? this.startDate,
    targetDate: targetDate ?? this.targetDate,
    availableHours: availableHours ?? this.availableHours,
    isActive: isActive ?? this.isActive,
  );
  StudyPlan copyWithCompanion(StudyPlansCompanion data) {
    return StudyPlan(
      id: data.id.present ? data.id.value : this.id,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      availableHours: data.availableHours.present
          ? data.availableHours.value
          : this.availableHours,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyPlan(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('targetDate: $targetDate, ')
          ..write('availableHours: $availableHours, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, startDate, targetDate, availableHours, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyPlan &&
          other.id == this.id &&
          other.startDate == this.startDate &&
          other.targetDate == this.targetDate &&
          other.availableHours == this.availableHours &&
          other.isActive == this.isActive);
}

class StudyPlansCompanion extends UpdateCompanion<StudyPlan> {
  final Value<String> id;
  final Value<DateTime> startDate;
  final Value<DateTime> targetDate;
  final Value<double> availableHours;
  final Value<bool> isActive;
  final Value<int> rowid;
  const StudyPlansCompanion({
    this.id = const Value.absent(),
    this.startDate = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.availableHours = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyPlansCompanion.insert({
    required String id,
    required DateTime startDate,
    required DateTime targetDate,
    required double availableHours,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startDate = Value(startDate),
       targetDate = Value(targetDate),
       availableHours = Value(availableHours);
  static Insertable<StudyPlan> custom({
    Expression<String>? id,
    Expression<DateTime>? startDate,
    Expression<DateTime>? targetDate,
    Expression<double>? availableHours,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startDate != null) 'start_date': startDate,
      if (targetDate != null) 'target_date': targetDate,
      if (availableHours != null) 'available_hours': availableHours,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyPlansCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? startDate,
    Value<DateTime>? targetDate,
    Value<double>? availableHours,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return StudyPlansCompanion(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      availableHours: availableHours ?? this.availableHours,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (availableHours.present) {
      map['available_hours'] = Variable<double>(availableHours.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyPlansCompanion(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('targetDate: $targetDate, ')
          ..write('availableHours: $availableHours, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlannerTasksTable extends PlannerTasks
    with TableInfo<$PlannerTasksTable, PlannerTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlannerTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemTypeMeta = const VerificationMeta(
    'itemType',
  );
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
    'item_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isReviewMeta = const VerificationMeta(
    'isReview',
  );
  @override
  late final GeneratedColumn<bool> isReview = GeneratedColumn<bool>(
    'is_review',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_review" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    itemType,
    itemId,
    isCompleted,
    isReview,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'planner_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlannerTask> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('item_type')) {
      context.handle(
        _itemTypeMeta,
        itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('is_review')) {
      context.handle(
        _isReviewMeta,
        isReview.isAcceptableOrUnknown(data['is_review']!, _isReviewMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlannerTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlannerTask(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      itemType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_type'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      isReview: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_review'],
      )!,
    );
  }

  @override
  $PlannerTasksTable createAlias(String alias) {
    return $PlannerTasksTable(attachedDatabase, alias);
  }
}

class PlannerTask extends DataClass implements Insertable<PlannerTask> {
  final String id;
  final DateTime date;
  final String itemType;
  final String itemId;
  final bool isCompleted;
  final bool isReview;
  const PlannerTask({
    required this.id,
    required this.date,
    required this.itemType,
    required this.itemId,
    required this.isCompleted,
    required this.isReview,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['item_type'] = Variable<String>(itemType);
    map['item_id'] = Variable<String>(itemId);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['is_review'] = Variable<bool>(isReview);
    return map;
  }

  PlannerTasksCompanion toCompanion(bool nullToAbsent) {
    return PlannerTasksCompanion(
      id: Value(id),
      date: Value(date),
      itemType: Value(itemType),
      itemId: Value(itemId),
      isCompleted: Value(isCompleted),
      isReview: Value(isReview),
    );
  }

  factory PlannerTask.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlannerTask(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      itemType: serializer.fromJson<String>(json['itemType']),
      itemId: serializer.fromJson<String>(json['itemId']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      isReview: serializer.fromJson<bool>(json['isReview']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'itemType': serializer.toJson<String>(itemType),
      'itemId': serializer.toJson<String>(itemId),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'isReview': serializer.toJson<bool>(isReview),
    };
  }

  PlannerTask copyWith({
    String? id,
    DateTime? date,
    String? itemType,
    String? itemId,
    bool? isCompleted,
    bool? isReview,
  }) => PlannerTask(
    id: id ?? this.id,
    date: date ?? this.date,
    itemType: itemType ?? this.itemType,
    itemId: itemId ?? this.itemId,
    isCompleted: isCompleted ?? this.isCompleted,
    isReview: isReview ?? this.isReview,
  );
  PlannerTask copyWithCompanion(PlannerTasksCompanion data) {
    return PlannerTask(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      isReview: data.isReview.present ? data.isReview.value : this.isReview,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlannerTask(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('itemType: $itemType, ')
          ..write('itemId: $itemId, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('isReview: $isReview')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, itemType, itemId, isCompleted, isReview);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlannerTask &&
          other.id == this.id &&
          other.date == this.date &&
          other.itemType == this.itemType &&
          other.itemId == this.itemId &&
          other.isCompleted == this.isCompleted &&
          other.isReview == this.isReview);
}

class PlannerTasksCompanion extends UpdateCompanion<PlannerTask> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> itemType;
  final Value<String> itemId;
  final Value<bool> isCompleted;
  final Value<bool> isReview;
  final Value<int> rowid;
  const PlannerTasksCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.itemType = const Value.absent(),
    this.itemId = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.isReview = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlannerTasksCompanion.insert({
    required String id,
    required DateTime date,
    required String itemType,
    required String itemId,
    this.isCompleted = const Value.absent(),
    this.isReview = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       itemType = Value(itemType),
       itemId = Value(itemId);
  static Insertable<PlannerTask> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? itemType,
    Expression<String>? itemId,
    Expression<bool>? isCompleted,
    Expression<bool>? isReview,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (itemType != null) 'item_type': itemType,
      if (itemId != null) 'item_id': itemId,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (isReview != null) 'is_review': isReview,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlannerTasksCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<String>? itemType,
    Value<String>? itemId,
    Value<bool>? isCompleted,
    Value<bool>? isReview,
    Value<int>? rowid,
  }) {
    return PlannerTasksCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      itemType: itemType ?? this.itemType,
      itemId: itemId ?? this.itemId,
      isCompleted: isCompleted ?? this.isCompleted,
      isReview: isReview ?? this.isReview,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (isReview.present) {
      map['is_review'] = Variable<bool>(isReview.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlannerTasksCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('itemType: $itemType, ')
          ..write('itemId: $itemId, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('isReview: $isReview, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewItemsTable extends ReviewItems
    with TableInfo<$ReviewItemsTable, ReviewItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemTypeMeta = const VerificationMeta(
    'itemType',
  );
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
    'item_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stageMeta = const VerificationMeta('stage');
  @override
  late final GeneratedColumn<int> stage = GeneratedColumn<int>(
    'stage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextReviewDateMeta = const VerificationMeta(
    'nextReviewDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextReviewDate =
      GeneratedColumn<DateTime>(
        'next_review_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _lastReviewDateMeta = const VerificationMeta(
    'lastReviewDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewDate =
      GeneratedColumn<DateTime>(
        'last_review_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemType,
    itemId,
    stage,
    nextReviewDate,
    lastReviewDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_type')) {
      context.handle(
        _itemTypeMeta,
        itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('stage')) {
      context.handle(
        _stageMeta,
        stage.isAcceptableOrUnknown(data['stage']!, _stageMeta),
      );
    }
    if (data.containsKey('next_review_date')) {
      context.handle(
        _nextReviewDateMeta,
        nextReviewDate.isAcceptableOrUnknown(
          data['next_review_date']!,
          _nextReviewDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextReviewDateMeta);
    }
    if (data.containsKey('last_review_date')) {
      context.handle(
        _lastReviewDateMeta,
        lastReviewDate.isAcceptableOrUnknown(
          data['last_review_date']!,
          _lastReviewDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastReviewDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      itemType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_type'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      stage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stage'],
      )!,
      nextReviewDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_review_date'],
      )!,
      lastReviewDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_review_date'],
      )!,
    );
  }

  @override
  $ReviewItemsTable createAlias(String alias) {
    return $ReviewItemsTable(attachedDatabase, alias);
  }
}

class ReviewItem extends DataClass implements Insertable<ReviewItem> {
  final String id;
  final String itemType;
  final String itemId;
  final int stage;
  final DateTime nextReviewDate;
  final DateTime lastReviewDate;
  const ReviewItem({
    required this.id,
    required this.itemType,
    required this.itemId,
    required this.stage,
    required this.nextReviewDate,
    required this.lastReviewDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['item_type'] = Variable<String>(itemType);
    map['item_id'] = Variable<String>(itemId);
    map['stage'] = Variable<int>(stage);
    map['next_review_date'] = Variable<DateTime>(nextReviewDate);
    map['last_review_date'] = Variable<DateTime>(lastReviewDate);
    return map;
  }

  ReviewItemsCompanion toCompanion(bool nullToAbsent) {
    return ReviewItemsCompanion(
      id: Value(id),
      itemType: Value(itemType),
      itemId: Value(itemId),
      stage: Value(stage),
      nextReviewDate: Value(nextReviewDate),
      lastReviewDate: Value(lastReviewDate),
    );
  }

  factory ReviewItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewItem(
      id: serializer.fromJson<String>(json['id']),
      itemType: serializer.fromJson<String>(json['itemType']),
      itemId: serializer.fromJson<String>(json['itemId']),
      stage: serializer.fromJson<int>(json['stage']),
      nextReviewDate: serializer.fromJson<DateTime>(json['nextReviewDate']),
      lastReviewDate: serializer.fromJson<DateTime>(json['lastReviewDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemType': serializer.toJson<String>(itemType),
      'itemId': serializer.toJson<String>(itemId),
      'stage': serializer.toJson<int>(stage),
      'nextReviewDate': serializer.toJson<DateTime>(nextReviewDate),
      'lastReviewDate': serializer.toJson<DateTime>(lastReviewDate),
    };
  }

  ReviewItem copyWith({
    String? id,
    String? itemType,
    String? itemId,
    int? stage,
    DateTime? nextReviewDate,
    DateTime? lastReviewDate,
  }) => ReviewItem(
    id: id ?? this.id,
    itemType: itemType ?? this.itemType,
    itemId: itemId ?? this.itemId,
    stage: stage ?? this.stage,
    nextReviewDate: nextReviewDate ?? this.nextReviewDate,
    lastReviewDate: lastReviewDate ?? this.lastReviewDate,
  );
  ReviewItem copyWithCompanion(ReviewItemsCompanion data) {
    return ReviewItem(
      id: data.id.present ? data.id.value : this.id,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      stage: data.stage.present ? data.stage.value : this.stage,
      nextReviewDate: data.nextReviewDate.present
          ? data.nextReviewDate.value
          : this.nextReviewDate,
      lastReviewDate: data.lastReviewDate.present
          ? data.lastReviewDate.value
          : this.lastReviewDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewItem(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('itemId: $itemId, ')
          ..write('stage: $stage, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('lastReviewDate: $lastReviewDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, itemType, itemId, stage, nextReviewDate, lastReviewDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewItem &&
          other.id == this.id &&
          other.itemType == this.itemType &&
          other.itemId == this.itemId &&
          other.stage == this.stage &&
          other.nextReviewDate == this.nextReviewDate &&
          other.lastReviewDate == this.lastReviewDate);
}

class ReviewItemsCompanion extends UpdateCompanion<ReviewItem> {
  final Value<String> id;
  final Value<String> itemType;
  final Value<String> itemId;
  final Value<int> stage;
  final Value<DateTime> nextReviewDate;
  final Value<DateTime> lastReviewDate;
  final Value<int> rowid;
  const ReviewItemsCompanion({
    this.id = const Value.absent(),
    this.itemType = const Value.absent(),
    this.itemId = const Value.absent(),
    this.stage = const Value.absent(),
    this.nextReviewDate = const Value.absent(),
    this.lastReviewDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewItemsCompanion.insert({
    required String id,
    required String itemType,
    required String itemId,
    this.stage = const Value.absent(),
    required DateTime nextReviewDate,
    required DateTime lastReviewDate,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       itemType = Value(itemType),
       itemId = Value(itemId),
       nextReviewDate = Value(nextReviewDate),
       lastReviewDate = Value(lastReviewDate);
  static Insertable<ReviewItem> custom({
    Expression<String>? id,
    Expression<String>? itemType,
    Expression<String>? itemId,
    Expression<int>? stage,
    Expression<DateTime>? nextReviewDate,
    Expression<DateTime>? lastReviewDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemType != null) 'item_type': itemType,
      if (itemId != null) 'item_id': itemId,
      if (stage != null) 'stage': stage,
      if (nextReviewDate != null) 'next_review_date': nextReviewDate,
      if (lastReviewDate != null) 'last_review_date': lastReviewDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? itemType,
    Value<String>? itemId,
    Value<int>? stage,
    Value<DateTime>? nextReviewDate,
    Value<DateTime>? lastReviewDate,
    Value<int>? rowid,
  }) {
    return ReviewItemsCompanion(
      id: id ?? this.id,
      itemType: itemType ?? this.itemType,
      itemId: itemId ?? this.itemId,
      stage: stage ?? this.stage,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      lastReviewDate: lastReviewDate ?? this.lastReviewDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (stage.present) {
      map['stage'] = Variable<int>(stage.value);
    }
    if (nextReviewDate.present) {
      map['next_review_date'] = Variable<DateTime>(nextReviewDate.value);
    }
    if (lastReviewDate.present) {
      map['last_review_date'] = Variable<DateTime>(lastReviewDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewItemsCompanion(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('itemId: $itemId, ')
          ..write('stage: $stage, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('lastReviewDate: $lastReviewDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserStatsTable extends UserStats
    with TableInfo<$UserStatsTable, UserStat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _coinsMeta = const VerificationMeta('coins');
  @override
  late final GeneratedColumn<int> coins = GeneratedColumn<int>(
    'coins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, xp, coins];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserStat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('coins')) {
      context.handle(
        _coinsMeta,
        coins.isAcceptableOrUnknown(data['coins']!, _coinsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserStat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserStat(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      )!,
      coins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}coins'],
      )!,
    );
  }

  @override
  $UserStatsTable createAlias(String alias) {
    return $UserStatsTable(attachedDatabase, alias);
  }
}

class UserStat extends DataClass implements Insertable<UserStat> {
  final String id;
  final int xp;
  final int coins;
  const UserStat({required this.id, required this.xp, required this.coins});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['xp'] = Variable<int>(xp);
    map['coins'] = Variable<int>(coins);
    return map;
  }

  UserStatsCompanion toCompanion(bool nullToAbsent) {
    return UserStatsCompanion(
      id: Value(id),
      xp: Value(xp),
      coins: Value(coins),
    );
  }

  factory UserStat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserStat(
      id: serializer.fromJson<String>(json['id']),
      xp: serializer.fromJson<int>(json['xp']),
      coins: serializer.fromJson<int>(json['coins']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'xp': serializer.toJson<int>(xp),
      'coins': serializer.toJson<int>(coins),
    };
  }

  UserStat copyWith({String? id, int? xp, int? coins}) => UserStat(
    id: id ?? this.id,
    xp: xp ?? this.xp,
    coins: coins ?? this.coins,
  );
  UserStat copyWithCompanion(UserStatsCompanion data) {
    return UserStat(
      id: data.id.present ? data.id.value : this.id,
      xp: data.xp.present ? data.xp.value : this.xp,
      coins: data.coins.present ? data.coins.value : this.coins,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserStat(')
          ..write('id: $id, ')
          ..write('xp: $xp, ')
          ..write('coins: $coins')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, xp, coins);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserStat &&
          other.id == this.id &&
          other.xp == this.xp &&
          other.coins == this.coins);
}

class UserStatsCompanion extends UpdateCompanion<UserStat> {
  final Value<String> id;
  final Value<int> xp;
  final Value<int> coins;
  final Value<int> rowid;
  const UserStatsCompanion({
    this.id = const Value.absent(),
    this.xp = const Value.absent(),
    this.coins = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserStatsCompanion.insert({
    required String id,
    this.xp = const Value.absent(),
    this.coins = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<UserStat> custom({
    Expression<String>? id,
    Expression<int>? xp,
    Expression<int>? coins,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (xp != null) 'xp': xp,
      if (coins != null) 'coins': coins,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserStatsCompanion copyWith({
    Value<String>? id,
    Value<int>? xp,
    Value<int>? coins,
    Value<int>? rowid,
  }) {
    return UserStatsCompanion(
      id: id ?? this.id,
      xp: xp ?? this.xp,
      coins: coins ?? this.coins,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (coins.present) {
      map['coins'] = Variable<int>(coins.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserStatsCompanion(')
          ..write('id: $id, ')
          ..write('xp: $xp, ')
          ..write('coins: $coins, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTable extends Achievements
    with TableInfo<$AchievementsTable, Achievement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpRewardMeta = const VerificationMeta(
    'xpReward',
  );
  @override
  late final GeneratedColumn<int> xpReward = GeneratedColumn<int>(
    'xp_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coinRewardMeta = const VerificationMeta(
    'coinReward',
  );
  @override
  late final GeneratedColumn<int> coinReward = GeneratedColumn<int>(
    'coin_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isUnlockedMeta = const VerificationMeta(
    'isUnlocked',
  );
  @override
  late final GeneratedColumn<bool> isUnlocked = GeneratedColumn<bool>(
    'is_unlocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_unlocked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    xpReward,
    coinReward,
    isUnlocked,
    unlockedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<Achievement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('xp_reward')) {
      context.handle(
        _xpRewardMeta,
        xpReward.isAcceptableOrUnknown(data['xp_reward']!, _xpRewardMeta),
      );
    } else if (isInserting) {
      context.missing(_xpRewardMeta);
    }
    if (data.containsKey('coin_reward')) {
      context.handle(
        _coinRewardMeta,
        coinReward.isAcceptableOrUnknown(data['coin_reward']!, _coinRewardMeta),
      );
    } else if (isInserting) {
      context.missing(_coinRewardMeta);
    }
    if (data.containsKey('is_unlocked')) {
      context.handle(
        _isUnlockedMeta,
        isUnlocked.isAcceptableOrUnknown(data['is_unlocked']!, _isUnlockedMeta),
      );
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Achievement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Achievement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      xpReward: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_reward'],
      )!,
      coinReward: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}coin_reward'],
      )!,
      isUnlocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_unlocked'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      ),
    );
  }

  @override
  $AchievementsTable createAlias(String alias) {
    return $AchievementsTable(attachedDatabase, alias);
  }
}

class Achievement extends DataClass implements Insertable<Achievement> {
  final String id;
  final String title;
  final String description;
  final int xpReward;
  final int coinReward;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.xpReward,
    required this.coinReward,
    required this.isUnlocked,
    this.unlockedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['xp_reward'] = Variable<int>(xpReward);
    map['coin_reward'] = Variable<int>(coinReward);
    map['is_unlocked'] = Variable<bool>(isUnlocked);
    if (!nullToAbsent || unlockedAt != null) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    }
    return map;
  }

  AchievementsCompanion toCompanion(bool nullToAbsent) {
    return AchievementsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      xpReward: Value(xpReward),
      coinReward: Value(coinReward),
      isUnlocked: Value(isUnlocked),
      unlockedAt: unlockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedAt),
    );
  }

  factory Achievement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Achievement(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      xpReward: serializer.fromJson<int>(json['xpReward']),
      coinReward: serializer.fromJson<int>(json['coinReward']),
      isUnlocked: serializer.fromJson<bool>(json['isUnlocked']),
      unlockedAt: serializer.fromJson<DateTime?>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'xpReward': serializer.toJson<int>(xpReward),
      'coinReward': serializer.toJson<int>(coinReward),
      'isUnlocked': serializer.toJson<bool>(isUnlocked),
      'unlockedAt': serializer.toJson<DateTime?>(unlockedAt),
    };
  }

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    int? xpReward,
    int? coinReward,
    bool? isUnlocked,
    Value<DateTime?> unlockedAt = const Value.absent(),
  }) => Achievement(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    xpReward: xpReward ?? this.xpReward,
    coinReward: coinReward ?? this.coinReward,
    isUnlocked: isUnlocked ?? this.isUnlocked,
    unlockedAt: unlockedAt.present ? unlockedAt.value : this.unlockedAt,
  );
  Achievement copyWithCompanion(AchievementsCompanion data) {
    return Achievement(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      xpReward: data.xpReward.present ? data.xpReward.value : this.xpReward,
      coinReward: data.coinReward.present
          ? data.coinReward.value
          : this.coinReward,
      isUnlocked: data.isUnlocked.present
          ? data.isUnlocked.value
          : this.isUnlocked,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Achievement(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('xpReward: $xpReward, ')
          ..write('coinReward: $coinReward, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    xpReward,
    coinReward,
    isUnlocked,
    unlockedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Achievement &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.xpReward == this.xpReward &&
          other.coinReward == this.coinReward &&
          other.isUnlocked == this.isUnlocked &&
          other.unlockedAt == this.unlockedAt);
}

class AchievementsCompanion extends UpdateCompanion<Achievement> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<int> xpReward;
  final Value<int> coinReward;
  final Value<bool> isUnlocked;
  final Value<DateTime?> unlockedAt;
  final Value<int> rowid;
  const AchievementsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.coinReward = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementsCompanion.insert({
    required String id,
    required String title,
    required String description,
    required int xpReward,
    required int coinReward,
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       description = Value(description),
       xpReward = Value(xpReward),
       coinReward = Value(coinReward);
  static Insertable<Achievement> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? xpReward,
    Expression<int>? coinReward,
    Expression<bool>? isUnlocked,
    Expression<DateTime>? unlockedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (xpReward != null) 'xp_reward': xpReward,
      if (coinReward != null) 'coin_reward': coinReward,
      if (isUnlocked != null) 'is_unlocked': isUnlocked,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<int>? xpReward,
    Value<int>? coinReward,
    Value<bool>? isUnlocked,
    Value<DateTime?>? unlockedAt,
    Value<int>? rowid,
  }) {
    return AchievementsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      xpReward: xpReward ?? this.xpReward,
      coinReward: coinReward ?? this.coinReward,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (xpReward.present) {
      map['xp_reward'] = Variable<int>(xpReward.value);
    }
    if (coinReward.present) {
      map['coin_reward'] = Variable<int>(coinReward.value);
    }
    if (isUnlocked.present) {
      map['is_unlocked'] = Variable<bool>(isUnlocked.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('xpReward: $xpReward, ')
          ..write('coinReward: $coinReward, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklyGoalsTable extends WeeklyGoals
    with TableInfo<$WeeklyGoalsTable, WeeklyGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetSecondsMeta = const VerificationMeta(
    'targetSeconds',
  );
  @override
  late final GeneratedColumn<int> targetSeconds = GeneratedColumn<int>(
    'target_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedSecondsMeta = const VerificationMeta(
    'completedSeconds',
  );
  @override
  late final GeneratedColumn<int> completedSeconds = GeneratedColumn<int>(
    'completed_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _targetItemsMeta = const VerificationMeta(
    'targetItems',
  );
  @override
  late final GeneratedColumn<int> targetItems = GeneratedColumn<int>(
    'target_items',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedItemsMeta = const VerificationMeta(
    'completedItems',
  );
  @override
  late final GeneratedColumn<int> completedItems = GeneratedColumn<int>(
    'completed_items',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isClaimedMeta = const VerificationMeta(
    'isClaimed',
  );
  @override
  late final GeneratedColumn<bool> isClaimed = GeneratedColumn<bool>(
    'is_claimed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_claimed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    targetSeconds,
    completedSeconds,
    targetItems,
    completedItems,
    isClaimed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeeklyGoal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('target_seconds')) {
      context.handle(
        _targetSecondsMeta,
        targetSeconds.isAcceptableOrUnknown(
          data['target_seconds']!,
          _targetSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetSecondsMeta);
    }
    if (data.containsKey('completed_seconds')) {
      context.handle(
        _completedSecondsMeta,
        completedSeconds.isAcceptableOrUnknown(
          data['completed_seconds']!,
          _completedSecondsMeta,
        ),
      );
    }
    if (data.containsKey('target_items')) {
      context.handle(
        _targetItemsMeta,
        targetItems.isAcceptableOrUnknown(
          data['target_items']!,
          _targetItemsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetItemsMeta);
    }
    if (data.containsKey('completed_items')) {
      context.handle(
        _completedItemsMeta,
        completedItems.isAcceptableOrUnknown(
          data['completed_items']!,
          _completedItemsMeta,
        ),
      );
    }
    if (data.containsKey('is_claimed')) {
      context.handle(
        _isClaimedMeta,
        isClaimed.isAcceptableOrUnknown(data['is_claimed']!, _isClaimedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeeklyGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyGoal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      targetSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_seconds'],
      )!,
      completedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_seconds'],
      )!,
      targetItems: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_items'],
      )!,
      completedItems: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_items'],
      )!,
      isClaimed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_claimed'],
      )!,
    );
  }

  @override
  $WeeklyGoalsTable createAlias(String alias) {
    return $WeeklyGoalsTable(attachedDatabase, alias);
  }
}

class WeeklyGoal extends DataClass implements Insertable<WeeklyGoal> {
  final String id;
  final int targetSeconds;
  final int completedSeconds;
  final int targetItems;
  final int completedItems;
  final bool isClaimed;
  const WeeklyGoal({
    required this.id,
    required this.targetSeconds,
    required this.completedSeconds,
    required this.targetItems,
    required this.completedItems,
    required this.isClaimed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['target_seconds'] = Variable<int>(targetSeconds);
    map['completed_seconds'] = Variable<int>(completedSeconds);
    map['target_items'] = Variable<int>(targetItems);
    map['completed_items'] = Variable<int>(completedItems);
    map['is_claimed'] = Variable<bool>(isClaimed);
    return map;
  }

  WeeklyGoalsCompanion toCompanion(bool nullToAbsent) {
    return WeeklyGoalsCompanion(
      id: Value(id),
      targetSeconds: Value(targetSeconds),
      completedSeconds: Value(completedSeconds),
      targetItems: Value(targetItems),
      completedItems: Value(completedItems),
      isClaimed: Value(isClaimed),
    );
  }

  factory WeeklyGoal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyGoal(
      id: serializer.fromJson<String>(json['id']),
      targetSeconds: serializer.fromJson<int>(json['targetSeconds']),
      completedSeconds: serializer.fromJson<int>(json['completedSeconds']),
      targetItems: serializer.fromJson<int>(json['targetItems']),
      completedItems: serializer.fromJson<int>(json['completedItems']),
      isClaimed: serializer.fromJson<bool>(json['isClaimed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'targetSeconds': serializer.toJson<int>(targetSeconds),
      'completedSeconds': serializer.toJson<int>(completedSeconds),
      'targetItems': serializer.toJson<int>(targetItems),
      'completedItems': serializer.toJson<int>(completedItems),
      'isClaimed': serializer.toJson<bool>(isClaimed),
    };
  }

  WeeklyGoal copyWith({
    String? id,
    int? targetSeconds,
    int? completedSeconds,
    int? targetItems,
    int? completedItems,
    bool? isClaimed,
  }) => WeeklyGoal(
    id: id ?? this.id,
    targetSeconds: targetSeconds ?? this.targetSeconds,
    completedSeconds: completedSeconds ?? this.completedSeconds,
    targetItems: targetItems ?? this.targetItems,
    completedItems: completedItems ?? this.completedItems,
    isClaimed: isClaimed ?? this.isClaimed,
  );
  WeeklyGoal copyWithCompanion(WeeklyGoalsCompanion data) {
    return WeeklyGoal(
      id: data.id.present ? data.id.value : this.id,
      targetSeconds: data.targetSeconds.present
          ? data.targetSeconds.value
          : this.targetSeconds,
      completedSeconds: data.completedSeconds.present
          ? data.completedSeconds.value
          : this.completedSeconds,
      targetItems: data.targetItems.present
          ? data.targetItems.value
          : this.targetItems,
      completedItems: data.completedItems.present
          ? data.completedItems.value
          : this.completedItems,
      isClaimed: data.isClaimed.present ? data.isClaimed.value : this.isClaimed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyGoal(')
          ..write('id: $id, ')
          ..write('targetSeconds: $targetSeconds, ')
          ..write('completedSeconds: $completedSeconds, ')
          ..write('targetItems: $targetItems, ')
          ..write('completedItems: $completedItems, ')
          ..write('isClaimed: $isClaimed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    targetSeconds,
    completedSeconds,
    targetItems,
    completedItems,
    isClaimed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyGoal &&
          other.id == this.id &&
          other.targetSeconds == this.targetSeconds &&
          other.completedSeconds == this.completedSeconds &&
          other.targetItems == this.targetItems &&
          other.completedItems == this.completedItems &&
          other.isClaimed == this.isClaimed);
}

class WeeklyGoalsCompanion extends UpdateCompanion<WeeklyGoal> {
  final Value<String> id;
  final Value<int> targetSeconds;
  final Value<int> completedSeconds;
  final Value<int> targetItems;
  final Value<int> completedItems;
  final Value<bool> isClaimed;
  final Value<int> rowid;
  const WeeklyGoalsCompanion({
    this.id = const Value.absent(),
    this.targetSeconds = const Value.absent(),
    this.completedSeconds = const Value.absent(),
    this.targetItems = const Value.absent(),
    this.completedItems = const Value.absent(),
    this.isClaimed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyGoalsCompanion.insert({
    required String id,
    required int targetSeconds,
    this.completedSeconds = const Value.absent(),
    required int targetItems,
    this.completedItems = const Value.absent(),
    this.isClaimed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       targetSeconds = Value(targetSeconds),
       targetItems = Value(targetItems);
  static Insertable<WeeklyGoal> custom({
    Expression<String>? id,
    Expression<int>? targetSeconds,
    Expression<int>? completedSeconds,
    Expression<int>? targetItems,
    Expression<int>? completedItems,
    Expression<bool>? isClaimed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetSeconds != null) 'target_seconds': targetSeconds,
      if (completedSeconds != null) 'completed_seconds': completedSeconds,
      if (targetItems != null) 'target_items': targetItems,
      if (completedItems != null) 'completed_items': completedItems,
      if (isClaimed != null) 'is_claimed': isClaimed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyGoalsCompanion copyWith({
    Value<String>? id,
    Value<int>? targetSeconds,
    Value<int>? completedSeconds,
    Value<int>? targetItems,
    Value<int>? completedItems,
    Value<bool>? isClaimed,
    Value<int>? rowid,
  }) {
    return WeeklyGoalsCompanion(
      id: id ?? this.id,
      targetSeconds: targetSeconds ?? this.targetSeconds,
      completedSeconds: completedSeconds ?? this.completedSeconds,
      targetItems: targetItems ?? this.targetItems,
      completedItems: completedItems ?? this.completedItems,
      isClaimed: isClaimed ?? this.isClaimed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (targetSeconds.present) {
      map['target_seconds'] = Variable<int>(targetSeconds.value);
    }
    if (completedSeconds.present) {
      map['completed_seconds'] = Variable<int>(completedSeconds.value);
    }
    if (targetItems.present) {
      map['target_items'] = Variable<int>(targetItems.value);
    }
    if (completedItems.present) {
      map['completed_items'] = Variable<int>(completedItems.value);
    }
    if (isClaimed.present) {
      map['is_claimed'] = Variable<bool>(isClaimed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyGoalsCompanion(')
          ..write('id: $id, ')
          ..write('targetSeconds: $targetSeconds, ')
          ..write('completedSeconds: $completedSeconds, ')
          ..write('targetItems: $targetItems, ')
          ..write('completedItems: $completedItems, ')
          ..write('isClaimed: $isClaimed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewHistoryRecordsTable extends ReviewHistoryRecords
    with TableInfo<$ReviewHistoryRecordsTable, ReviewHistoryRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewHistoryRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemTypeMeta = const VerificationMeta(
    'itemType',
  );
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
    'item_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeTakenSecondsMeta = const VerificationMeta(
    'timeTakenSeconds',
  );
  @override
  late final GeneratedColumn<int> timeTakenSeconds = GeneratedColumn<int>(
    'time_taken_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prevIntervalMeta = const VerificationMeta(
    'prevInterval',
  );
  @override
  late final GeneratedColumn<int> prevInterval = GeneratedColumn<int>(
    'prev_interval',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextIntervalMeta = const VerificationMeta(
    'nextInterval',
  );
  @override
  late final GeneratedColumn<int> nextInterval = GeneratedColumn<int>(
    'next_interval',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemId,
    itemType,
    timestamp,
    result,
    timeTakenSeconds,
    prevInterval,
    nextInterval,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_history_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewHistoryRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('item_type')) {
      context.handle(
        _itemTypeMeta,
        itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    } else if (isInserting) {
      context.missing(_resultMeta);
    }
    if (data.containsKey('time_taken_seconds')) {
      context.handle(
        _timeTakenSecondsMeta,
        timeTakenSeconds.isAcceptableOrUnknown(
          data['time_taken_seconds']!,
          _timeTakenSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timeTakenSecondsMeta);
    }
    if (data.containsKey('prev_interval')) {
      context.handle(
        _prevIntervalMeta,
        prevInterval.isAcceptableOrUnknown(
          data['prev_interval']!,
          _prevIntervalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prevIntervalMeta);
    }
    if (data.containsKey('next_interval')) {
      context.handle(
        _nextIntervalMeta,
        nextInterval.isAcceptableOrUnknown(
          data['next_interval']!,
          _nextIntervalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextIntervalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewHistoryRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewHistoryRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      itemType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_type'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      )!,
      timeTakenSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_taken_seconds'],
      )!,
      prevInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prev_interval'],
      )!,
      nextInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_interval'],
      )!,
    );
  }

  @override
  $ReviewHistoryRecordsTable createAlias(String alias) {
    return $ReviewHistoryRecordsTable(attachedDatabase, alias);
  }
}

class ReviewHistoryRecord extends DataClass
    implements Insertable<ReviewHistoryRecord> {
  final String id;
  final String itemId;
  final String itemType;
  final DateTime timestamp;
  final String result;
  final int timeTakenSeconds;
  final int prevInterval;
  final int nextInterval;
  const ReviewHistoryRecord({
    required this.id,
    required this.itemId,
    required this.itemType,
    required this.timestamp,
    required this.result,
    required this.timeTakenSeconds,
    required this.prevInterval,
    required this.nextInterval,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['item_id'] = Variable<String>(itemId);
    map['item_type'] = Variable<String>(itemType);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['result'] = Variable<String>(result);
    map['time_taken_seconds'] = Variable<int>(timeTakenSeconds);
    map['prev_interval'] = Variable<int>(prevInterval);
    map['next_interval'] = Variable<int>(nextInterval);
    return map;
  }

  ReviewHistoryRecordsCompanion toCompanion(bool nullToAbsent) {
    return ReviewHistoryRecordsCompanion(
      id: Value(id),
      itemId: Value(itemId),
      itemType: Value(itemType),
      timestamp: Value(timestamp),
      result: Value(result),
      timeTakenSeconds: Value(timeTakenSeconds),
      prevInterval: Value(prevInterval),
      nextInterval: Value(nextInterval),
    );
  }

  factory ReviewHistoryRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewHistoryRecord(
      id: serializer.fromJson<String>(json['id']),
      itemId: serializer.fromJson<String>(json['itemId']),
      itemType: serializer.fromJson<String>(json['itemType']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      result: serializer.fromJson<String>(json['result']),
      timeTakenSeconds: serializer.fromJson<int>(json['timeTakenSeconds']),
      prevInterval: serializer.fromJson<int>(json['prevInterval']),
      nextInterval: serializer.fromJson<int>(json['nextInterval']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemId': serializer.toJson<String>(itemId),
      'itemType': serializer.toJson<String>(itemType),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'result': serializer.toJson<String>(result),
      'timeTakenSeconds': serializer.toJson<int>(timeTakenSeconds),
      'prevInterval': serializer.toJson<int>(prevInterval),
      'nextInterval': serializer.toJson<int>(nextInterval),
    };
  }

  ReviewHistoryRecord copyWith({
    String? id,
    String? itemId,
    String? itemType,
    DateTime? timestamp,
    String? result,
    int? timeTakenSeconds,
    int? prevInterval,
    int? nextInterval,
  }) => ReviewHistoryRecord(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    itemType: itemType ?? this.itemType,
    timestamp: timestamp ?? this.timestamp,
    result: result ?? this.result,
    timeTakenSeconds: timeTakenSeconds ?? this.timeTakenSeconds,
    prevInterval: prevInterval ?? this.prevInterval,
    nextInterval: nextInterval ?? this.nextInterval,
  );
  ReviewHistoryRecord copyWithCompanion(ReviewHistoryRecordsCompanion data) {
    return ReviewHistoryRecord(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      result: data.result.present ? data.result.value : this.result,
      timeTakenSeconds: data.timeTakenSeconds.present
          ? data.timeTakenSeconds.value
          : this.timeTakenSeconds,
      prevInterval: data.prevInterval.present
          ? data.prevInterval.value
          : this.prevInterval,
      nextInterval: data.nextInterval.present
          ? data.nextInterval.value
          : this.nextInterval,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewHistoryRecord(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('itemType: $itemType, ')
          ..write('timestamp: $timestamp, ')
          ..write('result: $result, ')
          ..write('timeTakenSeconds: $timeTakenSeconds, ')
          ..write('prevInterval: $prevInterval, ')
          ..write('nextInterval: $nextInterval')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    itemId,
    itemType,
    timestamp,
    result,
    timeTakenSeconds,
    prevInterval,
    nextInterval,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewHistoryRecord &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.itemType == this.itemType &&
          other.timestamp == this.timestamp &&
          other.result == this.result &&
          other.timeTakenSeconds == this.timeTakenSeconds &&
          other.prevInterval == this.prevInterval &&
          other.nextInterval == this.nextInterval);
}

class ReviewHistoryRecordsCompanion
    extends UpdateCompanion<ReviewHistoryRecord> {
  final Value<String> id;
  final Value<String> itemId;
  final Value<String> itemType;
  final Value<DateTime> timestamp;
  final Value<String> result;
  final Value<int> timeTakenSeconds;
  final Value<int> prevInterval;
  final Value<int> nextInterval;
  final Value<int> rowid;
  const ReviewHistoryRecordsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.itemType = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.result = const Value.absent(),
    this.timeTakenSeconds = const Value.absent(),
    this.prevInterval = const Value.absent(),
    this.nextInterval = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewHistoryRecordsCompanion.insert({
    required String id,
    required String itemId,
    required String itemType,
    required DateTime timestamp,
    required String result,
    required int timeTakenSeconds,
    required int prevInterval,
    required int nextInterval,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       itemId = Value(itemId),
       itemType = Value(itemType),
       timestamp = Value(timestamp),
       result = Value(result),
       timeTakenSeconds = Value(timeTakenSeconds),
       prevInterval = Value(prevInterval),
       nextInterval = Value(nextInterval);
  static Insertable<ReviewHistoryRecord> custom({
    Expression<String>? id,
    Expression<String>? itemId,
    Expression<String>? itemType,
    Expression<DateTime>? timestamp,
    Expression<String>? result,
    Expression<int>? timeTakenSeconds,
    Expression<int>? prevInterval,
    Expression<int>? nextInterval,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (itemType != null) 'item_type': itemType,
      if (timestamp != null) 'timestamp': timestamp,
      if (result != null) 'result': result,
      if (timeTakenSeconds != null) 'time_taken_seconds': timeTakenSeconds,
      if (prevInterval != null) 'prev_interval': prevInterval,
      if (nextInterval != null) 'next_interval': nextInterval,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewHistoryRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? itemId,
    Value<String>? itemType,
    Value<DateTime>? timestamp,
    Value<String>? result,
    Value<int>? timeTakenSeconds,
    Value<int>? prevInterval,
    Value<int>? nextInterval,
    Value<int>? rowid,
  }) {
    return ReviewHistoryRecordsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      itemType: itemType ?? this.itemType,
      timestamp: timestamp ?? this.timestamp,
      result: result ?? this.result,
      timeTakenSeconds: timeTakenSeconds ?? this.timeTakenSeconds,
      prevInterval: prevInterval ?? this.prevInterval,
      nextInterval: nextInterval ?? this.nextInterval,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (timeTakenSeconds.present) {
      map['time_taken_seconds'] = Variable<int>(timeTakenSeconds.value);
    }
    if (prevInterval.present) {
      map['prev_interval'] = Variable<int>(prevInterval.value);
    }
    if (nextInterval.present) {
      map['next_interval'] = Variable<int>(nextInterval.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewHistoryRecordsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('itemType: $itemType, ')
          ..write('timestamp: $timestamp, ')
          ..write('result: $result, ')
          ..write('timeTakenSeconds: $timeTakenSeconds, ')
          ..write('prevInterval: $prevInterval, ')
          ..write('nextInterval: $nextInterval, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MasterKanjisTable masterKanjis = $MasterKanjisTable(this);
  late final $UserKanjisTable userKanjis = $UserKanjisTable(this);
  late final $MasterVocabulariesTable masterVocabularies =
      $MasterVocabulariesTable(this);
  late final $UserVocabulariesTable userVocabularies = $UserVocabulariesTable(
    this,
  );
  late final $MasterGrammarsTable masterGrammars = $MasterGrammarsTable(this);
  late final $UserGrammarsTable userGrammars = $UserGrammarsTable(this);
  late final $MasterReadingsTable masterReadings = $MasterReadingsTable(this);
  late final $UserReadingsTable userReadings = $UserReadingsTable(this);
  late final $MasterListeningsTable masterListenings = $MasterListeningsTable(
    this,
  );
  late final $UserListeningsTable userListenings = $UserListeningsTable(this);
  late final $KanjiVocabsTable kanjiVocabs = $KanjiVocabsTable(this);
  late final $VocabGrammarsTable vocabGrammars = $VocabGrammarsTable(this);
  late final $GrammarReadingsTable grammarReadings = $GrammarReadingsTable(
    this,
  );
  late final $ReadingListeningsTable readingListenings =
      $ReadingListeningsTable(this);
  late final $KanjiReadingsTable kanjiReadings = $KanjiReadingsTable(this);
  late final $VocabReadingsTable vocabReadings = $VocabReadingsTable(this);
  late final $StudySessionsTable studySessions = $StudySessionsTable(this);
  late final $DailyGoalsTable dailyGoals = $DailyGoalsTable(this);
  late final $QuizResultsTable quizResults = $QuizResultsTable(this);
  late final $StudyPlansTable studyPlans = $StudyPlansTable(this);
  late final $PlannerTasksTable plannerTasks = $PlannerTasksTable(this);
  late final $ReviewItemsTable reviewItems = $ReviewItemsTable(this);
  late final $UserStatsTable userStats = $UserStatsTable(this);
  late final $AchievementsTable achievements = $AchievementsTable(this);
  late final $WeeklyGoalsTable weeklyGoals = $WeeklyGoalsTable(this);
  late final $ReviewHistoryRecordsTable reviewHistoryRecords =
      $ReviewHistoryRecordsTable(this);
  late final Index idxMasterKanjisKanji = Index(
    'idx_master_kanjis_kanji',
    'CREATE INDEX idx_master_kanjis_kanji ON master_kanjis (kanji)',
  );
  late final Index idxMasterKanjisJlpt = Index(
    'idx_master_kanjis_jlpt',
    'CREATE INDEX idx_master_kanjis_jlpt ON master_kanjis (jlpt_level)',
  );
  late final Index idxUserKanjisMasterId = Index(
    'idx_user_kanjis_master_id',
    'CREATE INDEX idx_user_kanjis_master_id ON user_kanjis (master_kanji_id)',
  );
  late final Index idxUserKanjisLearned = Index(
    'idx_user_kanjis_learned',
    'CREATE INDEX idx_user_kanjis_learned ON user_kanjis (is_learned)',
  );
  late final Index idxUserKanjisFavorite = Index(
    'idx_user_kanjis_favorite',
    'CREATE INDEX idx_user_kanjis_favorite ON user_kanjis (is_favorite)',
  );
  late final Index idxUserKanjisNextReview = Index(
    'idx_user_kanjis_next_review',
    'CREATE INDEX idx_user_kanjis_next_review ON user_kanjis (next_review)',
  );
  late final Index idxPlannerTasksDate = Index(
    'idx_planner_tasks_date',
    'CREATE INDEX idx_planner_tasks_date ON planner_tasks (date)',
  );
  late final Index idxReviewItemsNextReview = Index(
    'idx_review_items_next_review',
    'CREATE INDEX idx_review_items_next_review ON review_items (next_review_date, stage)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    masterKanjis,
    userKanjis,
    masterVocabularies,
    userVocabularies,
    masterGrammars,
    userGrammars,
    masterReadings,
    userReadings,
    masterListenings,
    userListenings,
    kanjiVocabs,
    vocabGrammars,
    grammarReadings,
    readingListenings,
    kanjiReadings,
    vocabReadings,
    studySessions,
    dailyGoals,
    quizResults,
    studyPlans,
    plannerTasks,
    reviewItems,
    userStats,
    achievements,
    weeklyGoals,
    reviewHistoryRecords,
    idxMasterKanjisKanji,
    idxMasterKanjisJlpt,
    idxUserKanjisMasterId,
    idxUserKanjisLearned,
    idxUserKanjisFavorite,
    idxUserKanjisNextReview,
    idxPlannerTasksDate,
    idxReviewItemsNextReview,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_kanjis',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_kanjis', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_vocabularies',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_vocabularies', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_grammars',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_grammars', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_readings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_readings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_listenings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_listenings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_kanjis',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('kanji_vocabs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_vocabularies',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('kanji_vocabs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_vocabularies',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vocab_grammars', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_grammars',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vocab_grammars', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_grammars',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('grammar_readings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_readings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('grammar_readings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_readings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reading_listenings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_listenings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reading_listenings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_kanjis',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('kanji_readings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_readings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('kanji_readings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_vocabularies',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vocab_readings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'master_readings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vocab_readings', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MasterKanjisTableCreateCompanionBuilder =
    MasterKanjisCompanion Function({
      required String id,
      required String kanji,
      required String unicode,
      required int jlptLevel,
      Value<int?> gradeLevel,
      required String meaning,
      required String kunYomi,
      required String onYomi,
      required int strokeCount,
      required String radicals,
      Value<String?> strokeOrderDiagram,
      Value<String> exampleWords,
      Value<String> exampleSentences,
      Value<String> notes,
      Value<String> tags,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> status,
      Value<int?> rtkNumber,
      Value<int?> frequencyRank,
      Value<String?> pitchAccent,
      Value<String?> audioPath,
      Value<String?> animatedStrokeOrderPath,
      Value<String?> syncStatus,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$MasterKanjisTableUpdateCompanionBuilder =
    MasterKanjisCompanion Function({
      Value<String> id,
      Value<String> kanji,
      Value<String> unicode,
      Value<int> jlptLevel,
      Value<int?> gradeLevel,
      Value<String> meaning,
      Value<String> kunYomi,
      Value<String> onYomi,
      Value<int> strokeCount,
      Value<String> radicals,
      Value<String?> strokeOrderDiagram,
      Value<String> exampleWords,
      Value<String> exampleSentences,
      Value<String> notes,
      Value<String> tags,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> status,
      Value<int?> rtkNumber,
      Value<int?> frequencyRank,
      Value<String?> pitchAccent,
      Value<String?> audioPath,
      Value<String?> animatedStrokeOrderPath,
      Value<String?> syncStatus,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

final class $$MasterKanjisTableReferences
    extends BaseReferences<_$AppDatabase, $MasterKanjisTable, MasterKanji> {
  $$MasterKanjisTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserKanjisTable, List<UserKanji>>
  _userKanjisRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userKanjis,
    aliasName: 'master_kanjis__id__user_kanjis__master_kanji_id',
  );

  $$UserKanjisTableProcessedTableManager get userKanjisRefs {
    final manager = $$UserKanjisTableTableManager(
      $_db,
      $_db.userKanjis,
    ).filter((f) => f.masterKanjiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userKanjisRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$KanjiVocabsTable, List<KanjiVocab>>
  _kanjiVocabsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.kanjiVocabs,
    aliasName: 'master_kanjis__id__kanji_vocabs__kanji_id',
  );

  $$KanjiVocabsTableProcessedTableManager get kanjiVocabsRefs {
    final manager = $$KanjiVocabsTableTableManager(
      $_db,
      $_db.kanjiVocabs,
    ).filter((f) => f.kanjiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_kanjiVocabsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$KanjiReadingsTable, List<KanjiReading>>
  _kanjiReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.kanjiReadings,
    aliasName: 'master_kanjis__id__kanji_readings__kanji_id',
  );

  $$KanjiReadingsTableProcessedTableManager get kanjiReadingsRefs {
    final manager = $$KanjiReadingsTableTableManager(
      $_db,
      $_db.kanjiReadings,
    ).filter((f) => f.kanjiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_kanjiReadingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MasterKanjisTableFilterComposer
    extends Composer<_$AppDatabase, $MasterKanjisTable> {
  $$MasterKanjisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kanji => $composableBuilder(
    column: $table.kanji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unicode => $composableBuilder(
    column: $table.unicode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jlptLevel => $composableBuilder(
    column: $table.jlptLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gradeLevel => $composableBuilder(
    column: $table.gradeLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kunYomi => $composableBuilder(
    column: $table.kunYomi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get onYomi => $composableBuilder(
    column: $table.onYomi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get strokeCount => $composableBuilder(
    column: $table.strokeCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get radicals => $composableBuilder(
    column: $table.radicals,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strokeOrderDiagram => $composableBuilder(
    column: $table.strokeOrderDiagram,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exampleWords => $composableBuilder(
    column: $table.exampleWords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exampleSentences => $composableBuilder(
    column: $table.exampleSentences,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rtkNumber => $composableBuilder(
    column: $table.rtkNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get frequencyRank => $composableBuilder(
    column: $table.frequencyRank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pitchAccent => $composableBuilder(
    column: $table.pitchAccent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get animatedStrokeOrderPath => $composableBuilder(
    column: $table.animatedStrokeOrderPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userKanjisRefs(
    Expression<bool> Function($$UserKanjisTableFilterComposer f) f,
  ) {
    final $$UserKanjisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userKanjis,
      getReferencedColumn: (t) => t.masterKanjiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserKanjisTableFilterComposer(
            $db: $db,
            $table: $db.userKanjis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> kanjiVocabsRefs(
    Expression<bool> Function($$KanjiVocabsTableFilterComposer f) f,
  ) {
    final $$KanjiVocabsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kanjiVocabs,
      getReferencedColumn: (t) => t.kanjiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KanjiVocabsTableFilterComposer(
            $db: $db,
            $table: $db.kanjiVocabs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> kanjiReadingsRefs(
    Expression<bool> Function($$KanjiReadingsTableFilterComposer f) f,
  ) {
    final $$KanjiReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kanjiReadings,
      getReferencedColumn: (t) => t.kanjiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KanjiReadingsTableFilterComposer(
            $db: $db,
            $table: $db.kanjiReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MasterKanjisTableOrderingComposer
    extends Composer<_$AppDatabase, $MasterKanjisTable> {
  $$MasterKanjisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kanji => $composableBuilder(
    column: $table.kanji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unicode => $composableBuilder(
    column: $table.unicode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jlptLevel => $composableBuilder(
    column: $table.jlptLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gradeLevel => $composableBuilder(
    column: $table.gradeLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kunYomi => $composableBuilder(
    column: $table.kunYomi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get onYomi => $composableBuilder(
    column: $table.onYomi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get strokeCount => $composableBuilder(
    column: $table.strokeCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get radicals => $composableBuilder(
    column: $table.radicals,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strokeOrderDiagram => $composableBuilder(
    column: $table.strokeOrderDiagram,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exampleWords => $composableBuilder(
    column: $table.exampleWords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exampleSentences => $composableBuilder(
    column: $table.exampleSentences,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rtkNumber => $composableBuilder(
    column: $table.rtkNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get frequencyRank => $composableBuilder(
    column: $table.frequencyRank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pitchAccent => $composableBuilder(
    column: $table.pitchAccent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get animatedStrokeOrderPath => $composableBuilder(
    column: $table.animatedStrokeOrderPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MasterKanjisTableAnnotationComposer
    extends Composer<_$AppDatabase, $MasterKanjisTable> {
  $$MasterKanjisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kanji =>
      $composableBuilder(column: $table.kanji, builder: (column) => column);

  GeneratedColumn<String> get unicode =>
      $composableBuilder(column: $table.unicode, builder: (column) => column);

  GeneratedColumn<int> get jlptLevel =>
      $composableBuilder(column: $table.jlptLevel, builder: (column) => column);

  GeneratedColumn<int> get gradeLevel => $composableBuilder(
    column: $table.gradeLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  GeneratedColumn<String> get kunYomi =>
      $composableBuilder(column: $table.kunYomi, builder: (column) => column);

  GeneratedColumn<String> get onYomi =>
      $composableBuilder(column: $table.onYomi, builder: (column) => column);

  GeneratedColumn<int> get strokeCount => $composableBuilder(
    column: $table.strokeCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get radicals =>
      $composableBuilder(column: $table.radicals, builder: (column) => column);

  GeneratedColumn<String> get strokeOrderDiagram => $composableBuilder(
    column: $table.strokeOrderDiagram,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exampleWords => $composableBuilder(
    column: $table.exampleWords,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exampleSentences => $composableBuilder(
    column: $table.exampleSentences,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get rtkNumber =>
      $composableBuilder(column: $table.rtkNumber, builder: (column) => column);

  GeneratedColumn<int> get frequencyRank => $composableBuilder(
    column: $table.frequencyRank,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pitchAccent => $composableBuilder(
    column: $table.pitchAccent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);

  GeneratedColumn<String> get animatedStrokeOrderPath => $composableBuilder(
    column: $table.animatedStrokeOrderPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  Expression<T> userKanjisRefs<T extends Object>(
    Expression<T> Function($$UserKanjisTableAnnotationComposer a) f,
  ) {
    final $$UserKanjisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userKanjis,
      getReferencedColumn: (t) => t.masterKanjiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserKanjisTableAnnotationComposer(
            $db: $db,
            $table: $db.userKanjis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> kanjiVocabsRefs<T extends Object>(
    Expression<T> Function($$KanjiVocabsTableAnnotationComposer a) f,
  ) {
    final $$KanjiVocabsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kanjiVocabs,
      getReferencedColumn: (t) => t.kanjiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KanjiVocabsTableAnnotationComposer(
            $db: $db,
            $table: $db.kanjiVocabs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> kanjiReadingsRefs<T extends Object>(
    Expression<T> Function($$KanjiReadingsTableAnnotationComposer a) f,
  ) {
    final $$KanjiReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kanjiReadings,
      getReferencedColumn: (t) => t.kanjiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KanjiReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.kanjiReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MasterKanjisTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MasterKanjisTable,
          MasterKanji,
          $$MasterKanjisTableFilterComposer,
          $$MasterKanjisTableOrderingComposer,
          $$MasterKanjisTableAnnotationComposer,
          $$MasterKanjisTableCreateCompanionBuilder,
          $$MasterKanjisTableUpdateCompanionBuilder,
          (MasterKanji, $$MasterKanjisTableReferences),
          MasterKanji,
          PrefetchHooks Function({
            bool userKanjisRefs,
            bool kanjiVocabsRefs,
            bool kanjiReadingsRefs,
          })
        > {
  $$MasterKanjisTableTableManager(_$AppDatabase db, $MasterKanjisTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MasterKanjisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MasterKanjisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MasterKanjisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> kanji = const Value.absent(),
                Value<String> unicode = const Value.absent(),
                Value<int> jlptLevel = const Value.absent(),
                Value<int?> gradeLevel = const Value.absent(),
                Value<String> meaning = const Value.absent(),
                Value<String> kunYomi = const Value.absent(),
                Value<String> onYomi = const Value.absent(),
                Value<int> strokeCount = const Value.absent(),
                Value<String> radicals = const Value.absent(),
                Value<String?> strokeOrderDiagram = const Value.absent(),
                Value<String> exampleWords = const Value.absent(),
                Value<String> exampleSentences = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> rtkNumber = const Value.absent(),
                Value<int?> frequencyRank = const Value.absent(),
                Value<String?> pitchAccent = const Value.absent(),
                Value<String?> audioPath = const Value.absent(),
                Value<String?> animatedStrokeOrderPath = const Value.absent(),
                Value<String?> syncStatus = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MasterKanjisCompanion(
                id: id,
                kanji: kanji,
                unicode: unicode,
                jlptLevel: jlptLevel,
                gradeLevel: gradeLevel,
                meaning: meaning,
                kunYomi: kunYomi,
                onYomi: onYomi,
                strokeCount: strokeCount,
                radicals: radicals,
                strokeOrderDiagram: strokeOrderDiagram,
                exampleWords: exampleWords,
                exampleSentences: exampleSentences,
                notes: notes,
                tags: tags,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                rtkNumber: rtkNumber,
                frequencyRank: frequencyRank,
                pitchAccent: pitchAccent,
                audioPath: audioPath,
                animatedStrokeOrderPath: animatedStrokeOrderPath,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String kanji,
                required String unicode,
                required int jlptLevel,
                Value<int?> gradeLevel = const Value.absent(),
                required String meaning,
                required String kunYomi,
                required String onYomi,
                required int strokeCount,
                required String radicals,
                Value<String?> strokeOrderDiagram = const Value.absent(),
                Value<String> exampleWords = const Value.absent(),
                Value<String> exampleSentences = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<String> tags = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> status = const Value.absent(),
                Value<int?> rtkNumber = const Value.absent(),
                Value<int?> frequencyRank = const Value.absent(),
                Value<String?> pitchAccent = const Value.absent(),
                Value<String?> audioPath = const Value.absent(),
                Value<String?> animatedStrokeOrderPath = const Value.absent(),
                Value<String?> syncStatus = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MasterKanjisCompanion.insert(
                id: id,
                kanji: kanji,
                unicode: unicode,
                jlptLevel: jlptLevel,
                gradeLevel: gradeLevel,
                meaning: meaning,
                kunYomi: kunYomi,
                onYomi: onYomi,
                strokeCount: strokeCount,
                radicals: radicals,
                strokeOrderDiagram: strokeOrderDiagram,
                exampleWords: exampleWords,
                exampleSentences: exampleSentences,
                notes: notes,
                tags: tags,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                rtkNumber: rtkNumber,
                frequencyRank: frequencyRank,
                pitchAccent: pitchAccent,
                audioPath: audioPath,
                animatedStrokeOrderPath: animatedStrokeOrderPath,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MasterKanjisTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userKanjisRefs = false,
                kanjiVocabsRefs = false,
                kanjiReadingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userKanjisRefs) db.userKanjis,
                    if (kanjiVocabsRefs) db.kanjiVocabs,
                    if (kanjiReadingsRefs) db.kanjiReadings,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userKanjisRefs)
                        await $_getPrefetchedData<
                          MasterKanji,
                          $MasterKanjisTable,
                          UserKanji
                        >(
                          currentTable: table,
                          referencedTable: $$MasterKanjisTableReferences
                              ._userKanjisRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterKanjisTableReferences(
                                db,
                                table,
                                p0,
                              ).userKanjisRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.masterKanjiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (kanjiVocabsRefs)
                        await $_getPrefetchedData<
                          MasterKanji,
                          $MasterKanjisTable,
                          KanjiVocab
                        >(
                          currentTable: table,
                          referencedTable: $$MasterKanjisTableReferences
                              ._kanjiVocabsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterKanjisTableReferences(
                                db,
                                table,
                                p0,
                              ).kanjiVocabsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.kanjiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (kanjiReadingsRefs)
                        await $_getPrefetchedData<
                          MasterKanji,
                          $MasterKanjisTable,
                          KanjiReading
                        >(
                          currentTable: table,
                          referencedTable: $$MasterKanjisTableReferences
                              ._kanjiReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterKanjisTableReferences(
                                db,
                                table,
                                p0,
                              ).kanjiReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.kanjiId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MasterKanjisTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MasterKanjisTable,
      MasterKanji,
      $$MasterKanjisTableFilterComposer,
      $$MasterKanjisTableOrderingComposer,
      $$MasterKanjisTableAnnotationComposer,
      $$MasterKanjisTableCreateCompanionBuilder,
      $$MasterKanjisTableUpdateCompanionBuilder,
      (MasterKanji, $$MasterKanjisTableReferences),
      MasterKanji,
      PrefetchHooks Function({
        bool userKanjisRefs,
        bool kanjiVocabsRefs,
        bool kanjiReadingsRefs,
      })
    >;
typedef $$UserKanjisTableCreateCompanionBuilder =
    UserKanjisCompanion Function({
      required String id,
      required String masterKanjiId,
      Value<bool> isAdded,
      Value<bool> isLearned,
      Value<bool> isFavorite,
      Value<int> reviewCount,
      Value<double> easeFactor,
      Value<DateTime?> nextReview,
      Value<DateTime?> lastReviewed,
      Value<String> customNotes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UserKanjisTableUpdateCompanionBuilder =
    UserKanjisCompanion Function({
      Value<String> id,
      Value<String> masterKanjiId,
      Value<bool> isAdded,
      Value<bool> isLearned,
      Value<bool> isFavorite,
      Value<int> reviewCount,
      Value<double> easeFactor,
      Value<DateTime?> nextReview,
      Value<DateTime?> lastReviewed,
      Value<String> customNotes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$UserKanjisTableReferences
    extends BaseReferences<_$AppDatabase, $UserKanjisTable, UserKanji> {
  $$UserKanjisTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MasterKanjisTable _masterKanjiIdTable(_$AppDatabase db) => db
      .masterKanjis
      .createAlias('user_kanjis__master_kanji_id__master_kanjis__id');

  $$MasterKanjisTableProcessedTableManager get masterKanjiId {
    final $_column = $_itemColumn<String>('master_kanji_id')!;

    final manager = $$MasterKanjisTableTableManager(
      $_db,
      $_db.masterKanjis,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_masterKanjiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserKanjisTableFilterComposer
    extends Composer<_$AppDatabase, $UserKanjisTable> {
  $$UserKanjisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAdded => $composableBuilder(
    column: $table.isAdded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLearned => $composableBuilder(
    column: $table.isLearned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextReview => $composableBuilder(
    column: $table.nextReview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewed => $composableBuilder(
    column: $table.lastReviewed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MasterKanjisTableFilterComposer get masterKanjiId {
    final $$MasterKanjisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterKanjiId,
      referencedTable: $db.masterKanjis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterKanjisTableFilterComposer(
            $db: $db,
            $table: $db.masterKanjis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserKanjisTableOrderingComposer
    extends Composer<_$AppDatabase, $UserKanjisTable> {
  $$UserKanjisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAdded => $composableBuilder(
    column: $table.isAdded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLearned => $composableBuilder(
    column: $table.isLearned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextReview => $composableBuilder(
    column: $table.nextReview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewed => $composableBuilder(
    column: $table.lastReviewed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MasterKanjisTableOrderingComposer get masterKanjiId {
    final $$MasterKanjisTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterKanjiId,
      referencedTable: $db.masterKanjis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterKanjisTableOrderingComposer(
            $db: $db,
            $table: $db.masterKanjis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserKanjisTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserKanjisTable> {
  $$UserKanjisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isAdded =>
      $composableBuilder(column: $table.isAdded, builder: (column) => column);

  GeneratedColumn<bool> get isLearned =>
      $composableBuilder(column: $table.isLearned, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextReview => $composableBuilder(
    column: $table.nextReview,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReviewed => $composableBuilder(
    column: $table.lastReviewed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$MasterKanjisTableAnnotationComposer get masterKanjiId {
    final $$MasterKanjisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterKanjiId,
      referencedTable: $db.masterKanjis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterKanjisTableAnnotationComposer(
            $db: $db,
            $table: $db.masterKanjis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserKanjisTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserKanjisTable,
          UserKanji,
          $$UserKanjisTableFilterComposer,
          $$UserKanjisTableOrderingComposer,
          $$UserKanjisTableAnnotationComposer,
          $$UserKanjisTableCreateCompanionBuilder,
          $$UserKanjisTableUpdateCompanionBuilder,
          (UserKanji, $$UserKanjisTableReferences),
          UserKanji,
          PrefetchHooks Function({bool masterKanjiId})
        > {
  $$UserKanjisTableTableManager(_$AppDatabase db, $UserKanjisTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserKanjisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserKanjisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserKanjisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> masterKanjiId = const Value.absent(),
                Value<bool> isAdded = const Value.absent(),
                Value<bool> isLearned = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<double> easeFactor = const Value.absent(),
                Value<DateTime?> nextReview = const Value.absent(),
                Value<DateTime?> lastReviewed = const Value.absent(),
                Value<String> customNotes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserKanjisCompanion(
                id: id,
                masterKanjiId: masterKanjiId,
                isAdded: isAdded,
                isLearned: isLearned,
                isFavorite: isFavorite,
                reviewCount: reviewCount,
                easeFactor: easeFactor,
                nextReview: nextReview,
                lastReviewed: lastReviewed,
                customNotes: customNotes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String masterKanjiId,
                Value<bool> isAdded = const Value.absent(),
                Value<bool> isLearned = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<double> easeFactor = const Value.absent(),
                Value<DateTime?> nextReview = const Value.absent(),
                Value<DateTime?> lastReviewed = const Value.absent(),
                Value<String> customNotes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserKanjisCompanion.insert(
                id: id,
                masterKanjiId: masterKanjiId,
                isAdded: isAdded,
                isLearned: isLearned,
                isFavorite: isFavorite,
                reviewCount: reviewCount,
                easeFactor: easeFactor,
                nextReview: nextReview,
                lastReviewed: lastReviewed,
                customNotes: customNotes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserKanjisTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({masterKanjiId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (masterKanjiId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.masterKanjiId,
                                referencedTable: $$UserKanjisTableReferences
                                    ._masterKanjiIdTable(db),
                                referencedColumn: $$UserKanjisTableReferences
                                    ._masterKanjiIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserKanjisTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserKanjisTable,
      UserKanji,
      $$UserKanjisTableFilterComposer,
      $$UserKanjisTableOrderingComposer,
      $$UserKanjisTableAnnotationComposer,
      $$UserKanjisTableCreateCompanionBuilder,
      $$UserKanjisTableUpdateCompanionBuilder,
      (UserKanji, $$UserKanjisTableReferences),
      UserKanji,
      PrefetchHooks Function({bool masterKanjiId})
    >;
typedef $$MasterVocabulariesTableCreateCompanionBuilder =
    MasterVocabulariesCompanion Function({
      required String id,
      required String word,
      required String kana,
      required String meaning,
      Value<String?> partOfSpeech,
      Value<int?> jlptLevel,
      Value<int?> frequency,
      Value<String?> relatedKanji,
      Value<String?> exampleSentences,
      Value<String?> synonyms,
      Value<String?> antonyms,
      Value<String?> tags,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> status,
      Value<int> rowid,
    });
typedef $$MasterVocabulariesTableUpdateCompanionBuilder =
    MasterVocabulariesCompanion Function({
      Value<String> id,
      Value<String> word,
      Value<String> kana,
      Value<String> meaning,
      Value<String?> partOfSpeech,
      Value<int?> jlptLevel,
      Value<int?> frequency,
      Value<String?> relatedKanji,
      Value<String?> exampleSentences,
      Value<String?> synonyms,
      Value<String?> antonyms,
      Value<String?> tags,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> status,
      Value<int> rowid,
    });

final class $$MasterVocabulariesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MasterVocabulariesTable,
          MasterVocabulary
        > {
  $$MasterVocabulariesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$UserVocabulariesTable, List<UserVocabulary>>
  _userVocabulariesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userVocabularies,
    aliasName: 'master_vocabularies__id__user_vocabularies__master_vocab_id',
  );

  $$UserVocabulariesTableProcessedTableManager get userVocabulariesRefs {
    final manager = $$UserVocabulariesTableTableManager(
      $_db,
      $_db.userVocabularies,
    ).filter((f) => f.masterVocabId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userVocabulariesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$KanjiVocabsTable, List<KanjiVocab>>
  _kanjiVocabsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.kanjiVocabs,
    aliasName: 'master_vocabularies__id__kanji_vocabs__vocab_id',
  );

  $$KanjiVocabsTableProcessedTableManager get kanjiVocabsRefs {
    final manager = $$KanjiVocabsTableTableManager(
      $_db,
      $_db.kanjiVocabs,
    ).filter((f) => f.vocabId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_kanjiVocabsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VocabGrammarsTable, List<VocabGrammar>>
  _vocabGrammarsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vocabGrammars,
    aliasName: 'master_vocabularies__id__vocab_grammars__vocab_id',
  );

  $$VocabGrammarsTableProcessedTableManager get vocabGrammarsRefs {
    final manager = $$VocabGrammarsTableTableManager(
      $_db,
      $_db.vocabGrammars,
    ).filter((f) => f.vocabId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_vocabGrammarsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VocabReadingsTable, List<VocabReading>>
  _vocabReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vocabReadings,
    aliasName: 'master_vocabularies__id__vocab_readings__vocab_id',
  );

  $$VocabReadingsTableProcessedTableManager get vocabReadingsRefs {
    final manager = $$VocabReadingsTableTableManager(
      $_db,
      $_db.vocabReadings,
    ).filter((f) => f.vocabId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_vocabReadingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MasterVocabulariesTableFilterComposer
    extends Composer<_$AppDatabase, $MasterVocabulariesTable> {
  $$MasterVocabulariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kana => $composableBuilder(
    column: $table.kana,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jlptLevel => $composableBuilder(
    column: $table.jlptLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relatedKanji => $composableBuilder(
    column: $table.relatedKanji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exampleSentences => $composableBuilder(
    column: $table.exampleSentences,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get synonyms => $composableBuilder(
    column: $table.synonyms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get antonyms => $composableBuilder(
    column: $table.antonyms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userVocabulariesRefs(
    Expression<bool> Function($$UserVocabulariesTableFilterComposer f) f,
  ) {
    final $$UserVocabulariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userVocabularies,
      getReferencedColumn: (t) => t.masterVocabId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserVocabulariesTableFilterComposer(
            $db: $db,
            $table: $db.userVocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> kanjiVocabsRefs(
    Expression<bool> Function($$KanjiVocabsTableFilterComposer f) f,
  ) {
    final $$KanjiVocabsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kanjiVocabs,
      getReferencedColumn: (t) => t.vocabId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KanjiVocabsTableFilterComposer(
            $db: $db,
            $table: $db.kanjiVocabs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vocabGrammarsRefs(
    Expression<bool> Function($$VocabGrammarsTableFilterComposer f) f,
  ) {
    final $$VocabGrammarsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabGrammars,
      getReferencedColumn: (t) => t.vocabId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabGrammarsTableFilterComposer(
            $db: $db,
            $table: $db.vocabGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vocabReadingsRefs(
    Expression<bool> Function($$VocabReadingsTableFilterComposer f) f,
  ) {
    final $$VocabReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabReadings,
      getReferencedColumn: (t) => t.vocabId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabReadingsTableFilterComposer(
            $db: $db,
            $table: $db.vocabReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MasterVocabulariesTableOrderingComposer
    extends Composer<_$AppDatabase, $MasterVocabulariesTable> {
  $$MasterVocabulariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kana => $composableBuilder(
    column: $table.kana,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jlptLevel => $composableBuilder(
    column: $table.jlptLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relatedKanji => $composableBuilder(
    column: $table.relatedKanji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exampleSentences => $composableBuilder(
    column: $table.exampleSentences,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get synonyms => $composableBuilder(
    column: $table.synonyms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get antonyms => $composableBuilder(
    column: $table.antonyms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MasterVocabulariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MasterVocabulariesTable> {
  $$MasterVocabulariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get kana =>
      $composableBuilder(column: $table.kana, builder: (column) => column);

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumn<int> get jlptLevel =>
      $composableBuilder(column: $table.jlptLevel, builder: (column) => column);

  GeneratedColumn<int> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<String> get relatedKanji => $composableBuilder(
    column: $table.relatedKanji,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exampleSentences => $composableBuilder(
    column: $table.exampleSentences,
    builder: (column) => column,
  );

  GeneratedColumn<String> get synonyms =>
      $composableBuilder(column: $table.synonyms, builder: (column) => column);

  GeneratedColumn<String> get antonyms =>
      $composableBuilder(column: $table.antonyms, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  Expression<T> userVocabulariesRefs<T extends Object>(
    Expression<T> Function($$UserVocabulariesTableAnnotationComposer a) f,
  ) {
    final $$UserVocabulariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userVocabularies,
      getReferencedColumn: (t) => t.masterVocabId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserVocabulariesTableAnnotationComposer(
            $db: $db,
            $table: $db.userVocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> kanjiVocabsRefs<T extends Object>(
    Expression<T> Function($$KanjiVocabsTableAnnotationComposer a) f,
  ) {
    final $$KanjiVocabsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kanjiVocabs,
      getReferencedColumn: (t) => t.vocabId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KanjiVocabsTableAnnotationComposer(
            $db: $db,
            $table: $db.kanjiVocabs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vocabGrammarsRefs<T extends Object>(
    Expression<T> Function($$VocabGrammarsTableAnnotationComposer a) f,
  ) {
    final $$VocabGrammarsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabGrammars,
      getReferencedColumn: (t) => t.vocabId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabGrammarsTableAnnotationComposer(
            $db: $db,
            $table: $db.vocabGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vocabReadingsRefs<T extends Object>(
    Expression<T> Function($$VocabReadingsTableAnnotationComposer a) f,
  ) {
    final $$VocabReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabReadings,
      getReferencedColumn: (t) => t.vocabId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.vocabReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MasterVocabulariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MasterVocabulariesTable,
          MasterVocabulary,
          $$MasterVocabulariesTableFilterComposer,
          $$MasterVocabulariesTableOrderingComposer,
          $$MasterVocabulariesTableAnnotationComposer,
          $$MasterVocabulariesTableCreateCompanionBuilder,
          $$MasterVocabulariesTableUpdateCompanionBuilder,
          (MasterVocabulary, $$MasterVocabulariesTableReferences),
          MasterVocabulary,
          PrefetchHooks Function({
            bool userVocabulariesRefs,
            bool kanjiVocabsRefs,
            bool vocabGrammarsRefs,
            bool vocabReadingsRefs,
          })
        > {
  $$MasterVocabulariesTableTableManager(
    _$AppDatabase db,
    $MasterVocabulariesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MasterVocabulariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MasterVocabulariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MasterVocabulariesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> word = const Value.absent(),
                Value<String> kana = const Value.absent(),
                Value<String> meaning = const Value.absent(),
                Value<String?> partOfSpeech = const Value.absent(),
                Value<int?> jlptLevel = const Value.absent(),
                Value<int?> frequency = const Value.absent(),
                Value<String?> relatedKanji = const Value.absent(),
                Value<String?> exampleSentences = const Value.absent(),
                Value<String?> synonyms = const Value.absent(),
                Value<String?> antonyms = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MasterVocabulariesCompanion(
                id: id,
                word: word,
                kana: kana,
                meaning: meaning,
                partOfSpeech: partOfSpeech,
                jlptLevel: jlptLevel,
                frequency: frequency,
                relatedKanji: relatedKanji,
                exampleSentences: exampleSentences,
                synonyms: synonyms,
                antonyms: antonyms,
                tags: tags,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String word,
                required String kana,
                required String meaning,
                Value<String?> partOfSpeech = const Value.absent(),
                Value<int?> jlptLevel = const Value.absent(),
                Value<int?> frequency = const Value.absent(),
                Value<String?> relatedKanji = const Value.absent(),
                Value<String?> exampleSentences = const Value.absent(),
                Value<String?> synonyms = const Value.absent(),
                Value<String?> antonyms = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MasterVocabulariesCompanion.insert(
                id: id,
                word: word,
                kana: kana,
                meaning: meaning,
                partOfSpeech: partOfSpeech,
                jlptLevel: jlptLevel,
                frequency: frequency,
                relatedKanji: relatedKanji,
                exampleSentences: exampleSentences,
                synonyms: synonyms,
                antonyms: antonyms,
                tags: tags,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MasterVocabulariesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userVocabulariesRefs = false,
                kanjiVocabsRefs = false,
                vocabGrammarsRefs = false,
                vocabReadingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userVocabulariesRefs) db.userVocabularies,
                    if (kanjiVocabsRefs) db.kanjiVocabs,
                    if (vocabGrammarsRefs) db.vocabGrammars,
                    if (vocabReadingsRefs) db.vocabReadings,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userVocabulariesRefs)
                        await $_getPrefetchedData<
                          MasterVocabulary,
                          $MasterVocabulariesTable,
                          UserVocabulary
                        >(
                          currentTable: table,
                          referencedTable: $$MasterVocabulariesTableReferences
                              ._userVocabulariesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterVocabulariesTableReferences(
                                db,
                                table,
                                p0,
                              ).userVocabulariesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.masterVocabId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (kanjiVocabsRefs)
                        await $_getPrefetchedData<
                          MasterVocabulary,
                          $MasterVocabulariesTable,
                          KanjiVocab
                        >(
                          currentTable: table,
                          referencedTable: $$MasterVocabulariesTableReferences
                              ._kanjiVocabsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterVocabulariesTableReferences(
                                db,
                                table,
                                p0,
                              ).kanjiVocabsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vocabId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vocabGrammarsRefs)
                        await $_getPrefetchedData<
                          MasterVocabulary,
                          $MasterVocabulariesTable,
                          VocabGrammar
                        >(
                          currentTable: table,
                          referencedTable: $$MasterVocabulariesTableReferences
                              ._vocabGrammarsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterVocabulariesTableReferences(
                                db,
                                table,
                                p0,
                              ).vocabGrammarsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vocabId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vocabReadingsRefs)
                        await $_getPrefetchedData<
                          MasterVocabulary,
                          $MasterVocabulariesTable,
                          VocabReading
                        >(
                          currentTable: table,
                          referencedTable: $$MasterVocabulariesTableReferences
                              ._vocabReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterVocabulariesTableReferences(
                                db,
                                table,
                                p0,
                              ).vocabReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vocabId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MasterVocabulariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MasterVocabulariesTable,
      MasterVocabulary,
      $$MasterVocabulariesTableFilterComposer,
      $$MasterVocabulariesTableOrderingComposer,
      $$MasterVocabulariesTableAnnotationComposer,
      $$MasterVocabulariesTableCreateCompanionBuilder,
      $$MasterVocabulariesTableUpdateCompanionBuilder,
      (MasterVocabulary, $$MasterVocabulariesTableReferences),
      MasterVocabulary,
      PrefetchHooks Function({
        bool userVocabulariesRefs,
        bool kanjiVocabsRefs,
        bool vocabGrammarsRefs,
        bool vocabReadingsRefs,
      })
    >;
typedef $$UserVocabulariesTableCreateCompanionBuilder =
    UserVocabulariesCompanion Function({
      required String id,
      required String masterVocabId,
      Value<bool> isAdded,
      Value<bool> isFavorite,
      Value<String> status,
      Value<int> reviewCount,
      Value<DateTime?> nextReview,
      Value<DateTime?> lastReviewed,
      Value<double> easeFactor,
      Value<String> customNotes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UserVocabulariesTableUpdateCompanionBuilder =
    UserVocabulariesCompanion Function({
      Value<String> id,
      Value<String> masterVocabId,
      Value<bool> isAdded,
      Value<bool> isFavorite,
      Value<String> status,
      Value<int> reviewCount,
      Value<DateTime?> nextReview,
      Value<DateTime?> lastReviewed,
      Value<double> easeFactor,
      Value<String> customNotes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$UserVocabulariesTableReferences
    extends
        BaseReferences<_$AppDatabase, $UserVocabulariesTable, UserVocabulary> {
  $$UserVocabulariesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MasterVocabulariesTable _masterVocabIdTable(_$AppDatabase db) =>
      db.masterVocabularies.createAlias(
        'user_vocabularies__master_vocab_id__master_vocabularies__id',
      );

  $$MasterVocabulariesTableProcessedTableManager get masterVocabId {
    final $_column = $_itemColumn<String>('master_vocab_id')!;

    final manager = $$MasterVocabulariesTableTableManager(
      $_db,
      $_db.masterVocabularies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_masterVocabIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserVocabulariesTableFilterComposer
    extends Composer<_$AppDatabase, $UserVocabulariesTable> {
  $$UserVocabulariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAdded => $composableBuilder(
    column: $table.isAdded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextReview => $composableBuilder(
    column: $table.nextReview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewed => $composableBuilder(
    column: $table.lastReviewed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MasterVocabulariesTableFilterComposer get masterVocabId {
    final $$MasterVocabulariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterVocabId,
      referencedTable: $db.masterVocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterVocabulariesTableFilterComposer(
            $db: $db,
            $table: $db.masterVocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserVocabulariesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserVocabulariesTable> {
  $$UserVocabulariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAdded => $composableBuilder(
    column: $table.isAdded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextReview => $composableBuilder(
    column: $table.nextReview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewed => $composableBuilder(
    column: $table.lastReviewed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MasterVocabulariesTableOrderingComposer get masterVocabId {
    final $$MasterVocabulariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterVocabId,
      referencedTable: $db.masterVocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterVocabulariesTableOrderingComposer(
            $db: $db,
            $table: $db.masterVocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserVocabulariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserVocabulariesTable> {
  $$UserVocabulariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isAdded =>
      $composableBuilder(column: $table.isAdded, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextReview => $composableBuilder(
    column: $table.nextReview,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReviewed => $composableBuilder(
    column: $table.lastReviewed,
    builder: (column) => column,
  );

  GeneratedColumn<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$MasterVocabulariesTableAnnotationComposer get masterVocabId {
    final $$MasterVocabulariesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.masterVocabId,
          referencedTable: $db.masterVocabularies,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MasterVocabulariesTableAnnotationComposer(
                $db: $db,
                $table: $db.masterVocabularies,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$UserVocabulariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserVocabulariesTable,
          UserVocabulary,
          $$UserVocabulariesTableFilterComposer,
          $$UserVocabulariesTableOrderingComposer,
          $$UserVocabulariesTableAnnotationComposer,
          $$UserVocabulariesTableCreateCompanionBuilder,
          $$UserVocabulariesTableUpdateCompanionBuilder,
          (UserVocabulary, $$UserVocabulariesTableReferences),
          UserVocabulary,
          PrefetchHooks Function({bool masterVocabId})
        > {
  $$UserVocabulariesTableTableManager(
    _$AppDatabase db,
    $UserVocabulariesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserVocabulariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserVocabulariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserVocabulariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> masterVocabId = const Value.absent(),
                Value<bool> isAdded = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<DateTime?> nextReview = const Value.absent(),
                Value<DateTime?> lastReviewed = const Value.absent(),
                Value<double> easeFactor = const Value.absent(),
                Value<String> customNotes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserVocabulariesCompanion(
                id: id,
                masterVocabId: masterVocabId,
                isAdded: isAdded,
                isFavorite: isFavorite,
                status: status,
                reviewCount: reviewCount,
                nextReview: nextReview,
                lastReviewed: lastReviewed,
                easeFactor: easeFactor,
                customNotes: customNotes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String masterVocabId,
                Value<bool> isAdded = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<DateTime?> nextReview = const Value.absent(),
                Value<DateTime?> lastReviewed = const Value.absent(),
                Value<double> easeFactor = const Value.absent(),
                Value<String> customNotes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserVocabulariesCompanion.insert(
                id: id,
                masterVocabId: masterVocabId,
                isAdded: isAdded,
                isFavorite: isFavorite,
                status: status,
                reviewCount: reviewCount,
                nextReview: nextReview,
                lastReviewed: lastReviewed,
                easeFactor: easeFactor,
                customNotes: customNotes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserVocabulariesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({masterVocabId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (masterVocabId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.masterVocabId,
                                referencedTable:
                                    $$UserVocabulariesTableReferences
                                        ._masterVocabIdTable(db),
                                referencedColumn:
                                    $$UserVocabulariesTableReferences
                                        ._masterVocabIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserVocabulariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserVocabulariesTable,
      UserVocabulary,
      $$UserVocabulariesTableFilterComposer,
      $$UserVocabulariesTableOrderingComposer,
      $$UserVocabulariesTableAnnotationComposer,
      $$UserVocabulariesTableCreateCompanionBuilder,
      $$UserVocabulariesTableUpdateCompanionBuilder,
      (UserVocabulary, $$UserVocabulariesTableReferences),
      UserVocabulary,
      PrefetchHooks Function({bool masterVocabId})
    >;
typedef $$MasterGrammarsTableCreateCompanionBuilder =
    MasterGrammarsCompanion Function({
      required String id,
      required String pattern,
      required String meaning,
      Value<String?> formation,
      Value<String?> usage,
      Value<String?> examples,
      Value<String?> commonMistakes,
      Value<String?> relatedGrammar,
      Value<int?> jlptLevel,
      Value<String?> tags,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> status,
      Value<int> rowid,
    });
typedef $$MasterGrammarsTableUpdateCompanionBuilder =
    MasterGrammarsCompanion Function({
      Value<String> id,
      Value<String> pattern,
      Value<String> meaning,
      Value<String?> formation,
      Value<String?> usage,
      Value<String?> examples,
      Value<String?> commonMistakes,
      Value<String?> relatedGrammar,
      Value<int?> jlptLevel,
      Value<String?> tags,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> status,
      Value<int> rowid,
    });

final class $$MasterGrammarsTableReferences
    extends BaseReferences<_$AppDatabase, $MasterGrammarsTable, MasterGrammar> {
  $$MasterGrammarsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$UserGrammarsTable, List<UserGrammar>>
  _userGrammarsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userGrammars,
    aliasName: 'master_grammars__id__user_grammars__master_grammar_id',
  );

  $$UserGrammarsTableProcessedTableManager get userGrammarsRefs {
    final manager = $$UserGrammarsTableTableManager($_db, $_db.userGrammars)
        .filter(
          (f) => f.masterGrammarId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_userGrammarsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VocabGrammarsTable, List<VocabGrammar>>
  _vocabGrammarsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vocabGrammars,
    aliasName: 'master_grammars__id__vocab_grammars__grammar_id',
  );

  $$VocabGrammarsTableProcessedTableManager get vocabGrammarsRefs {
    final manager = $$VocabGrammarsTableTableManager(
      $_db,
      $_db.vocabGrammars,
    ).filter((f) => f.grammarId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_vocabGrammarsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GrammarReadingsTable, List<GrammarReading>>
  _grammarReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.grammarReadings,
    aliasName: 'master_grammars__id__grammar_readings__grammar_id',
  );

  $$GrammarReadingsTableProcessedTableManager get grammarReadingsRefs {
    final manager = $$GrammarReadingsTableTableManager(
      $_db,
      $_db.grammarReadings,
    ).filter((f) => f.grammarId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _grammarReadingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MasterGrammarsTableFilterComposer
    extends Composer<_$AppDatabase, $MasterGrammarsTable> {
  $$MasterGrammarsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formation => $composableBuilder(
    column: $table.formation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usage => $composableBuilder(
    column: $table.usage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examples => $composableBuilder(
    column: $table.examples,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commonMistakes => $composableBuilder(
    column: $table.commonMistakes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relatedGrammar => $composableBuilder(
    column: $table.relatedGrammar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jlptLevel => $composableBuilder(
    column: $table.jlptLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userGrammarsRefs(
    Expression<bool> Function($$UserGrammarsTableFilterComposer f) f,
  ) {
    final $$UserGrammarsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userGrammars,
      getReferencedColumn: (t) => t.masterGrammarId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserGrammarsTableFilterComposer(
            $db: $db,
            $table: $db.userGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vocabGrammarsRefs(
    Expression<bool> Function($$VocabGrammarsTableFilterComposer f) f,
  ) {
    final $$VocabGrammarsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabGrammars,
      getReferencedColumn: (t) => t.grammarId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabGrammarsTableFilterComposer(
            $db: $db,
            $table: $db.vocabGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> grammarReadingsRefs(
    Expression<bool> Function($$GrammarReadingsTableFilterComposer f) f,
  ) {
    final $$GrammarReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.grammarReadings,
      getReferencedColumn: (t) => t.grammarId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrammarReadingsTableFilterComposer(
            $db: $db,
            $table: $db.grammarReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MasterGrammarsTableOrderingComposer
    extends Composer<_$AppDatabase, $MasterGrammarsTable> {
  $$MasterGrammarsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formation => $composableBuilder(
    column: $table.formation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usage => $composableBuilder(
    column: $table.usage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examples => $composableBuilder(
    column: $table.examples,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commonMistakes => $composableBuilder(
    column: $table.commonMistakes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relatedGrammar => $composableBuilder(
    column: $table.relatedGrammar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jlptLevel => $composableBuilder(
    column: $table.jlptLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MasterGrammarsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MasterGrammarsTable> {
  $$MasterGrammarsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pattern =>
      $composableBuilder(column: $table.pattern, builder: (column) => column);

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  GeneratedColumn<String> get formation =>
      $composableBuilder(column: $table.formation, builder: (column) => column);

  GeneratedColumn<String> get usage =>
      $composableBuilder(column: $table.usage, builder: (column) => column);

  GeneratedColumn<String> get examples =>
      $composableBuilder(column: $table.examples, builder: (column) => column);

  GeneratedColumn<String> get commonMistakes => $composableBuilder(
    column: $table.commonMistakes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relatedGrammar => $composableBuilder(
    column: $table.relatedGrammar,
    builder: (column) => column,
  );

  GeneratedColumn<int> get jlptLevel =>
      $composableBuilder(column: $table.jlptLevel, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  Expression<T> userGrammarsRefs<T extends Object>(
    Expression<T> Function($$UserGrammarsTableAnnotationComposer a) f,
  ) {
    final $$UserGrammarsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userGrammars,
      getReferencedColumn: (t) => t.masterGrammarId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserGrammarsTableAnnotationComposer(
            $db: $db,
            $table: $db.userGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vocabGrammarsRefs<T extends Object>(
    Expression<T> Function($$VocabGrammarsTableAnnotationComposer a) f,
  ) {
    final $$VocabGrammarsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabGrammars,
      getReferencedColumn: (t) => t.grammarId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabGrammarsTableAnnotationComposer(
            $db: $db,
            $table: $db.vocabGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> grammarReadingsRefs<T extends Object>(
    Expression<T> Function($$GrammarReadingsTableAnnotationComposer a) f,
  ) {
    final $$GrammarReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.grammarReadings,
      getReferencedColumn: (t) => t.grammarId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrammarReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.grammarReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MasterGrammarsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MasterGrammarsTable,
          MasterGrammar,
          $$MasterGrammarsTableFilterComposer,
          $$MasterGrammarsTableOrderingComposer,
          $$MasterGrammarsTableAnnotationComposer,
          $$MasterGrammarsTableCreateCompanionBuilder,
          $$MasterGrammarsTableUpdateCompanionBuilder,
          (MasterGrammar, $$MasterGrammarsTableReferences),
          MasterGrammar,
          PrefetchHooks Function({
            bool userGrammarsRefs,
            bool vocabGrammarsRefs,
            bool grammarReadingsRefs,
          })
        > {
  $$MasterGrammarsTableTableManager(
    _$AppDatabase db,
    $MasterGrammarsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MasterGrammarsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MasterGrammarsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MasterGrammarsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> pattern = const Value.absent(),
                Value<String> meaning = const Value.absent(),
                Value<String?> formation = const Value.absent(),
                Value<String?> usage = const Value.absent(),
                Value<String?> examples = const Value.absent(),
                Value<String?> commonMistakes = const Value.absent(),
                Value<String?> relatedGrammar = const Value.absent(),
                Value<int?> jlptLevel = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MasterGrammarsCompanion(
                id: id,
                pattern: pattern,
                meaning: meaning,
                formation: formation,
                usage: usage,
                examples: examples,
                commonMistakes: commonMistakes,
                relatedGrammar: relatedGrammar,
                jlptLevel: jlptLevel,
                tags: tags,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String pattern,
                required String meaning,
                Value<String?> formation = const Value.absent(),
                Value<String?> usage = const Value.absent(),
                Value<String?> examples = const Value.absent(),
                Value<String?> commonMistakes = const Value.absent(),
                Value<String?> relatedGrammar = const Value.absent(),
                Value<int?> jlptLevel = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MasterGrammarsCompanion.insert(
                id: id,
                pattern: pattern,
                meaning: meaning,
                formation: formation,
                usage: usage,
                examples: examples,
                commonMistakes: commonMistakes,
                relatedGrammar: relatedGrammar,
                jlptLevel: jlptLevel,
                tags: tags,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MasterGrammarsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userGrammarsRefs = false,
                vocabGrammarsRefs = false,
                grammarReadingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userGrammarsRefs) db.userGrammars,
                    if (vocabGrammarsRefs) db.vocabGrammars,
                    if (grammarReadingsRefs) db.grammarReadings,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userGrammarsRefs)
                        await $_getPrefetchedData<
                          MasterGrammar,
                          $MasterGrammarsTable,
                          UserGrammar
                        >(
                          currentTable: table,
                          referencedTable: $$MasterGrammarsTableReferences
                              ._userGrammarsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterGrammarsTableReferences(
                                db,
                                table,
                                p0,
                              ).userGrammarsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.masterGrammarId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vocabGrammarsRefs)
                        await $_getPrefetchedData<
                          MasterGrammar,
                          $MasterGrammarsTable,
                          VocabGrammar
                        >(
                          currentTable: table,
                          referencedTable: $$MasterGrammarsTableReferences
                              ._vocabGrammarsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterGrammarsTableReferences(
                                db,
                                table,
                                p0,
                              ).vocabGrammarsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.grammarId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (grammarReadingsRefs)
                        await $_getPrefetchedData<
                          MasterGrammar,
                          $MasterGrammarsTable,
                          GrammarReading
                        >(
                          currentTable: table,
                          referencedTable: $$MasterGrammarsTableReferences
                              ._grammarReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterGrammarsTableReferences(
                                db,
                                table,
                                p0,
                              ).grammarReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.grammarId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MasterGrammarsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MasterGrammarsTable,
      MasterGrammar,
      $$MasterGrammarsTableFilterComposer,
      $$MasterGrammarsTableOrderingComposer,
      $$MasterGrammarsTableAnnotationComposer,
      $$MasterGrammarsTableCreateCompanionBuilder,
      $$MasterGrammarsTableUpdateCompanionBuilder,
      (MasterGrammar, $$MasterGrammarsTableReferences),
      MasterGrammar,
      PrefetchHooks Function({
        bool userGrammarsRefs,
        bool vocabGrammarsRefs,
        bool grammarReadingsRefs,
      })
    >;
typedef $$UserGrammarsTableCreateCompanionBuilder =
    UserGrammarsCompanion Function({
      required String id,
      required String masterGrammarId,
      Value<bool> isAdded,
      Value<bool> isFavorite,
      Value<String> status,
      Value<String> customNotes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UserGrammarsTableUpdateCompanionBuilder =
    UserGrammarsCompanion Function({
      Value<String> id,
      Value<String> masterGrammarId,
      Value<bool> isAdded,
      Value<bool> isFavorite,
      Value<String> status,
      Value<String> customNotes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$UserGrammarsTableReferences
    extends BaseReferences<_$AppDatabase, $UserGrammarsTable, UserGrammar> {
  $$UserGrammarsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MasterGrammarsTable _masterGrammarIdTable(_$AppDatabase db) => db
      .masterGrammars
      .createAlias('user_grammars__master_grammar_id__master_grammars__id');

  $$MasterGrammarsTableProcessedTableManager get masterGrammarId {
    final $_column = $_itemColumn<String>('master_grammar_id')!;

    final manager = $$MasterGrammarsTableTableManager(
      $_db,
      $_db.masterGrammars,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_masterGrammarIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserGrammarsTableFilterComposer
    extends Composer<_$AppDatabase, $UserGrammarsTable> {
  $$UserGrammarsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAdded => $composableBuilder(
    column: $table.isAdded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MasterGrammarsTableFilterComposer get masterGrammarId {
    final $$MasterGrammarsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterGrammarId,
      referencedTable: $db.masterGrammars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterGrammarsTableFilterComposer(
            $db: $db,
            $table: $db.masterGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserGrammarsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserGrammarsTable> {
  $$UserGrammarsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAdded => $composableBuilder(
    column: $table.isAdded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MasterGrammarsTableOrderingComposer get masterGrammarId {
    final $$MasterGrammarsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterGrammarId,
      referencedTable: $db.masterGrammars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterGrammarsTableOrderingComposer(
            $db: $db,
            $table: $db.masterGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserGrammarsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserGrammarsTable> {
  $$UserGrammarsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isAdded =>
      $composableBuilder(column: $table.isAdded, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$MasterGrammarsTableAnnotationComposer get masterGrammarId {
    final $$MasterGrammarsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterGrammarId,
      referencedTable: $db.masterGrammars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterGrammarsTableAnnotationComposer(
            $db: $db,
            $table: $db.masterGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserGrammarsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserGrammarsTable,
          UserGrammar,
          $$UserGrammarsTableFilterComposer,
          $$UserGrammarsTableOrderingComposer,
          $$UserGrammarsTableAnnotationComposer,
          $$UserGrammarsTableCreateCompanionBuilder,
          $$UserGrammarsTableUpdateCompanionBuilder,
          (UserGrammar, $$UserGrammarsTableReferences),
          UserGrammar,
          PrefetchHooks Function({bool masterGrammarId})
        > {
  $$UserGrammarsTableTableManager(_$AppDatabase db, $UserGrammarsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserGrammarsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserGrammarsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserGrammarsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> masterGrammarId = const Value.absent(),
                Value<bool> isAdded = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> customNotes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserGrammarsCompanion(
                id: id,
                masterGrammarId: masterGrammarId,
                isAdded: isAdded,
                isFavorite: isFavorite,
                status: status,
                customNotes: customNotes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String masterGrammarId,
                Value<bool> isAdded = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> customNotes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserGrammarsCompanion.insert(
                id: id,
                masterGrammarId: masterGrammarId,
                isAdded: isAdded,
                isFavorite: isFavorite,
                status: status,
                customNotes: customNotes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserGrammarsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({masterGrammarId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (masterGrammarId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.masterGrammarId,
                                referencedTable: $$UserGrammarsTableReferences
                                    ._masterGrammarIdTable(db),
                                referencedColumn: $$UserGrammarsTableReferences
                                    ._masterGrammarIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserGrammarsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserGrammarsTable,
      UserGrammar,
      $$UserGrammarsTableFilterComposer,
      $$UserGrammarsTableOrderingComposer,
      $$UserGrammarsTableAnnotationComposer,
      $$UserGrammarsTableCreateCompanionBuilder,
      $$UserGrammarsTableUpdateCompanionBuilder,
      (UserGrammar, $$UserGrammarsTableReferences),
      UserGrammar,
      PrefetchHooks Function({bool masterGrammarId})
    >;
typedef $$MasterReadingsTableCreateCompanionBuilder =
    MasterReadingsCompanion Function({
      required String id,
      required String title,
      Value<int?> level,
      required String passage,
      Value<String?> translation,
      Value<String?> kanjiIds,
      Value<String?> vocabularyIds,
      Value<String?> grammarIds,
      Value<int?> estimatedReadingTime,
      Value<String?> difficulty,
      Value<String?> question,
      Value<String?> answer,
      Value<String?> explanation,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> status,
      Value<int> rowid,
    });
typedef $$MasterReadingsTableUpdateCompanionBuilder =
    MasterReadingsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<int?> level,
      Value<String> passage,
      Value<String?> translation,
      Value<String?> kanjiIds,
      Value<String?> vocabularyIds,
      Value<String?> grammarIds,
      Value<int?> estimatedReadingTime,
      Value<String?> difficulty,
      Value<String?> question,
      Value<String?> answer,
      Value<String?> explanation,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> status,
      Value<int> rowid,
    });

final class $$MasterReadingsTableReferences
    extends BaseReferences<_$AppDatabase, $MasterReadingsTable, MasterReading> {
  $$MasterReadingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$UserReadingsTable, List<UserReading>>
  _userReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userReadings,
    aliasName: 'master_readings__id__user_readings__master_reading_id',
  );

  $$UserReadingsTableProcessedTableManager get userReadingsRefs {
    final manager = $$UserReadingsTableTableManager($_db, $_db.userReadings)
        .filter(
          (f) => f.masterReadingId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_userReadingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GrammarReadingsTable, List<GrammarReading>>
  _grammarReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.grammarReadings,
    aliasName: 'master_readings__id__grammar_readings__reading_id',
  );

  $$GrammarReadingsTableProcessedTableManager get grammarReadingsRefs {
    final manager = $$GrammarReadingsTableTableManager(
      $_db,
      $_db.grammarReadings,
    ).filter((f) => f.readingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _grammarReadingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReadingListeningsTable, List<ReadingListening>>
  _readingListeningsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.readingListenings,
        aliasName: 'master_readings__id__reading_listenings__reading_id',
      );

  $$ReadingListeningsTableProcessedTableManager get readingListeningsRefs {
    final manager = $$ReadingListeningsTableTableManager(
      $_db,
      $_db.readingListenings,
    ).filter((f) => f.readingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _readingListeningsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$KanjiReadingsTable, List<KanjiReading>>
  _kanjiReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.kanjiReadings,
    aliasName: 'master_readings__id__kanji_readings__reading_id',
  );

  $$KanjiReadingsTableProcessedTableManager get kanjiReadingsRefs {
    final manager = $$KanjiReadingsTableTableManager(
      $_db,
      $_db.kanjiReadings,
    ).filter((f) => f.readingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_kanjiReadingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VocabReadingsTable, List<VocabReading>>
  _vocabReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vocabReadings,
    aliasName: 'master_readings__id__vocab_readings__reading_id',
  );

  $$VocabReadingsTableProcessedTableManager get vocabReadingsRefs {
    final manager = $$VocabReadingsTableTableManager(
      $_db,
      $_db.vocabReadings,
    ).filter((f) => f.readingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_vocabReadingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MasterReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $MasterReadingsTable> {
  $$MasterReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passage => $composableBuilder(
    column: $table.passage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kanjiIds => $composableBuilder(
    column: $table.kanjiIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vocabularyIds => $composableBuilder(
    column: $table.vocabularyIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grammarIds => $composableBuilder(
    column: $table.grammarIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedReadingTime => $composableBuilder(
    column: $table.estimatedReadingTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userReadingsRefs(
    Expression<bool> Function($$UserReadingsTableFilterComposer f) f,
  ) {
    final $$UserReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userReadings,
      getReferencedColumn: (t) => t.masterReadingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserReadingsTableFilterComposer(
            $db: $db,
            $table: $db.userReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> grammarReadingsRefs(
    Expression<bool> Function($$GrammarReadingsTableFilterComposer f) f,
  ) {
    final $$GrammarReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.grammarReadings,
      getReferencedColumn: (t) => t.readingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrammarReadingsTableFilterComposer(
            $db: $db,
            $table: $db.grammarReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> readingListeningsRefs(
    Expression<bool> Function($$ReadingListeningsTableFilterComposer f) f,
  ) {
    final $$ReadingListeningsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readingListenings,
      getReferencedColumn: (t) => t.readingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingListeningsTableFilterComposer(
            $db: $db,
            $table: $db.readingListenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> kanjiReadingsRefs(
    Expression<bool> Function($$KanjiReadingsTableFilterComposer f) f,
  ) {
    final $$KanjiReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kanjiReadings,
      getReferencedColumn: (t) => t.readingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KanjiReadingsTableFilterComposer(
            $db: $db,
            $table: $db.kanjiReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vocabReadingsRefs(
    Expression<bool> Function($$VocabReadingsTableFilterComposer f) f,
  ) {
    final $$VocabReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabReadings,
      getReferencedColumn: (t) => t.readingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabReadingsTableFilterComposer(
            $db: $db,
            $table: $db.vocabReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MasterReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $MasterReadingsTable> {
  $$MasterReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passage => $composableBuilder(
    column: $table.passage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kanjiIds => $composableBuilder(
    column: $table.kanjiIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vocabularyIds => $composableBuilder(
    column: $table.vocabularyIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grammarIds => $composableBuilder(
    column: $table.grammarIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedReadingTime => $composableBuilder(
    column: $table.estimatedReadingTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MasterReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MasterReadingsTable> {
  $$MasterReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get passage =>
      $composableBuilder(column: $table.passage, builder: (column) => column);

  GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kanjiIds =>
      $composableBuilder(column: $table.kanjiIds, builder: (column) => column);

  GeneratedColumn<String> get vocabularyIds => $composableBuilder(
    column: $table.vocabularyIds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grammarIds => $composableBuilder(
    column: $table.grammarIds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedReadingTime => $composableBuilder(
    column: $table.estimatedReadingTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => column);

  GeneratedColumn<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  Expression<T> userReadingsRefs<T extends Object>(
    Expression<T> Function($$UserReadingsTableAnnotationComposer a) f,
  ) {
    final $$UserReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userReadings,
      getReferencedColumn: (t) => t.masterReadingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.userReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> grammarReadingsRefs<T extends Object>(
    Expression<T> Function($$GrammarReadingsTableAnnotationComposer a) f,
  ) {
    final $$GrammarReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.grammarReadings,
      getReferencedColumn: (t) => t.readingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrammarReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.grammarReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> readingListeningsRefs<T extends Object>(
    Expression<T> Function($$ReadingListeningsTableAnnotationComposer a) f,
  ) {
    final $$ReadingListeningsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.readingListenings,
          getReferencedColumn: (t) => t.readingId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReadingListeningsTableAnnotationComposer(
                $db: $db,
                $table: $db.readingListenings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> kanjiReadingsRefs<T extends Object>(
    Expression<T> Function($$KanjiReadingsTableAnnotationComposer a) f,
  ) {
    final $$KanjiReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kanjiReadings,
      getReferencedColumn: (t) => t.readingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KanjiReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.kanjiReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vocabReadingsRefs<T extends Object>(
    Expression<T> Function($$VocabReadingsTableAnnotationComposer a) f,
  ) {
    final $$VocabReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabReadings,
      getReferencedColumn: (t) => t.readingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.vocabReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MasterReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MasterReadingsTable,
          MasterReading,
          $$MasterReadingsTableFilterComposer,
          $$MasterReadingsTableOrderingComposer,
          $$MasterReadingsTableAnnotationComposer,
          $$MasterReadingsTableCreateCompanionBuilder,
          $$MasterReadingsTableUpdateCompanionBuilder,
          (MasterReading, $$MasterReadingsTableReferences),
          MasterReading,
          PrefetchHooks Function({
            bool userReadingsRefs,
            bool grammarReadingsRefs,
            bool readingListeningsRefs,
            bool kanjiReadingsRefs,
            bool vocabReadingsRefs,
          })
        > {
  $$MasterReadingsTableTableManager(
    _$AppDatabase db,
    $MasterReadingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MasterReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MasterReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MasterReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int?> level = const Value.absent(),
                Value<String> passage = const Value.absent(),
                Value<String?> translation = const Value.absent(),
                Value<String?> kanjiIds = const Value.absent(),
                Value<String?> vocabularyIds = const Value.absent(),
                Value<String?> grammarIds = const Value.absent(),
                Value<int?> estimatedReadingTime = const Value.absent(),
                Value<String?> difficulty = const Value.absent(),
                Value<String?> question = const Value.absent(),
                Value<String?> answer = const Value.absent(),
                Value<String?> explanation = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MasterReadingsCompanion(
                id: id,
                title: title,
                level: level,
                passage: passage,
                translation: translation,
                kanjiIds: kanjiIds,
                vocabularyIds: vocabularyIds,
                grammarIds: grammarIds,
                estimatedReadingTime: estimatedReadingTime,
                difficulty: difficulty,
                question: question,
                answer: answer,
                explanation: explanation,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<int?> level = const Value.absent(),
                required String passage,
                Value<String?> translation = const Value.absent(),
                Value<String?> kanjiIds = const Value.absent(),
                Value<String?> vocabularyIds = const Value.absent(),
                Value<String?> grammarIds = const Value.absent(),
                Value<int?> estimatedReadingTime = const Value.absent(),
                Value<String?> difficulty = const Value.absent(),
                Value<String?> question = const Value.absent(),
                Value<String?> answer = const Value.absent(),
                Value<String?> explanation = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MasterReadingsCompanion.insert(
                id: id,
                title: title,
                level: level,
                passage: passage,
                translation: translation,
                kanjiIds: kanjiIds,
                vocabularyIds: vocabularyIds,
                grammarIds: grammarIds,
                estimatedReadingTime: estimatedReadingTime,
                difficulty: difficulty,
                question: question,
                answer: answer,
                explanation: explanation,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MasterReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userReadingsRefs = false,
                grammarReadingsRefs = false,
                readingListeningsRefs = false,
                kanjiReadingsRefs = false,
                vocabReadingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userReadingsRefs) db.userReadings,
                    if (grammarReadingsRefs) db.grammarReadings,
                    if (readingListeningsRefs) db.readingListenings,
                    if (kanjiReadingsRefs) db.kanjiReadings,
                    if (vocabReadingsRefs) db.vocabReadings,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userReadingsRefs)
                        await $_getPrefetchedData<
                          MasterReading,
                          $MasterReadingsTable,
                          UserReading
                        >(
                          currentTable: table,
                          referencedTable: $$MasterReadingsTableReferences
                              ._userReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterReadingsTableReferences(
                                db,
                                table,
                                p0,
                              ).userReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.masterReadingId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (grammarReadingsRefs)
                        await $_getPrefetchedData<
                          MasterReading,
                          $MasterReadingsTable,
                          GrammarReading
                        >(
                          currentTable: table,
                          referencedTable: $$MasterReadingsTableReferences
                              ._grammarReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterReadingsTableReferences(
                                db,
                                table,
                                p0,
                              ).grammarReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.readingId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (readingListeningsRefs)
                        await $_getPrefetchedData<
                          MasterReading,
                          $MasterReadingsTable,
                          ReadingListening
                        >(
                          currentTable: table,
                          referencedTable: $$MasterReadingsTableReferences
                              ._readingListeningsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterReadingsTableReferences(
                                db,
                                table,
                                p0,
                              ).readingListeningsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.readingId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (kanjiReadingsRefs)
                        await $_getPrefetchedData<
                          MasterReading,
                          $MasterReadingsTable,
                          KanjiReading
                        >(
                          currentTable: table,
                          referencedTable: $$MasterReadingsTableReferences
                              ._kanjiReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterReadingsTableReferences(
                                db,
                                table,
                                p0,
                              ).kanjiReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.readingId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vocabReadingsRefs)
                        await $_getPrefetchedData<
                          MasterReading,
                          $MasterReadingsTable,
                          VocabReading
                        >(
                          currentTable: table,
                          referencedTable: $$MasterReadingsTableReferences
                              ._vocabReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterReadingsTableReferences(
                                db,
                                table,
                                p0,
                              ).vocabReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.readingId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MasterReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MasterReadingsTable,
      MasterReading,
      $$MasterReadingsTableFilterComposer,
      $$MasterReadingsTableOrderingComposer,
      $$MasterReadingsTableAnnotationComposer,
      $$MasterReadingsTableCreateCompanionBuilder,
      $$MasterReadingsTableUpdateCompanionBuilder,
      (MasterReading, $$MasterReadingsTableReferences),
      MasterReading,
      PrefetchHooks Function({
        bool userReadingsRefs,
        bool grammarReadingsRefs,
        bool readingListeningsRefs,
        bool kanjiReadingsRefs,
        bool vocabReadingsRefs,
      })
    >;
typedef $$UserReadingsTableCreateCompanionBuilder =
    UserReadingsCompanion Function({
      required String id,
      required String masterReadingId,
      Value<bool> isAdded,
      Value<bool> isFavorite,
      Value<String> status,
      Value<String> customNotes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UserReadingsTableUpdateCompanionBuilder =
    UserReadingsCompanion Function({
      Value<String> id,
      Value<String> masterReadingId,
      Value<bool> isAdded,
      Value<bool> isFavorite,
      Value<String> status,
      Value<String> customNotes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$UserReadingsTableReferences
    extends BaseReferences<_$AppDatabase, $UserReadingsTable, UserReading> {
  $$UserReadingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MasterReadingsTable _masterReadingIdTable(_$AppDatabase db) => db
      .masterReadings
      .createAlias('user_readings__master_reading_id__master_readings__id');

  $$MasterReadingsTableProcessedTableManager get masterReadingId {
    final $_column = $_itemColumn<String>('master_reading_id')!;

    final manager = $$MasterReadingsTableTableManager(
      $_db,
      $_db.masterReadings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_masterReadingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $UserReadingsTable> {
  $$UserReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAdded => $composableBuilder(
    column: $table.isAdded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MasterReadingsTableFilterComposer get masterReadingId {
    final $$MasterReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterReadingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableFilterComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserReadingsTable> {
  $$UserReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAdded => $composableBuilder(
    column: $table.isAdded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MasterReadingsTableOrderingComposer get masterReadingId {
    final $$MasterReadingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterReadingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableOrderingComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserReadingsTable> {
  $$UserReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isAdded =>
      $composableBuilder(column: $table.isAdded, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$MasterReadingsTableAnnotationComposer get masterReadingId {
    final $$MasterReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterReadingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserReadingsTable,
          UserReading,
          $$UserReadingsTableFilterComposer,
          $$UserReadingsTableOrderingComposer,
          $$UserReadingsTableAnnotationComposer,
          $$UserReadingsTableCreateCompanionBuilder,
          $$UserReadingsTableUpdateCompanionBuilder,
          (UserReading, $$UserReadingsTableReferences),
          UserReading,
          PrefetchHooks Function({bool masterReadingId})
        > {
  $$UserReadingsTableTableManager(_$AppDatabase db, $UserReadingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> masterReadingId = const Value.absent(),
                Value<bool> isAdded = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> customNotes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserReadingsCompanion(
                id: id,
                masterReadingId: masterReadingId,
                isAdded: isAdded,
                isFavorite: isFavorite,
                status: status,
                customNotes: customNotes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String masterReadingId,
                Value<bool> isAdded = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> customNotes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserReadingsCompanion.insert(
                id: id,
                masterReadingId: masterReadingId,
                isAdded: isAdded,
                isFavorite: isFavorite,
                status: status,
                customNotes: customNotes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({masterReadingId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (masterReadingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.masterReadingId,
                                referencedTable: $$UserReadingsTableReferences
                                    ._masterReadingIdTable(db),
                                referencedColumn: $$UserReadingsTableReferences
                                    ._masterReadingIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserReadingsTable,
      UserReading,
      $$UserReadingsTableFilterComposer,
      $$UserReadingsTableOrderingComposer,
      $$UserReadingsTableAnnotationComposer,
      $$UserReadingsTableCreateCompanionBuilder,
      $$UserReadingsTableUpdateCompanionBuilder,
      (UserReading, $$UserReadingsTableReferences),
      UserReading,
      PrefetchHooks Function({bool masterReadingId})
    >;
typedef $$MasterListeningsTableCreateCompanionBuilder =
    MasterListeningsCompanion Function({
      required String id,
      required String title,
      required String transcript,
      Value<String?> audioPath,
      Value<int?> length,
      Value<String?> difficulty,
      Value<String?> kanjiIds,
      Value<String?> vocabularyIds,
      Value<String?> grammarIds,
      Value<String?> question,
      Value<String?> answer,
      Value<String?> explanation,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> status,
      Value<int> rowid,
    });
typedef $$MasterListeningsTableUpdateCompanionBuilder =
    MasterListeningsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> transcript,
      Value<String?> audioPath,
      Value<int?> length,
      Value<String?> difficulty,
      Value<String?> kanjiIds,
      Value<String?> vocabularyIds,
      Value<String?> grammarIds,
      Value<String?> question,
      Value<String?> answer,
      Value<String?> explanation,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> status,
      Value<int> rowid,
    });

final class $$MasterListeningsTableReferences
    extends
        BaseReferences<_$AppDatabase, $MasterListeningsTable, MasterListening> {
  $$MasterListeningsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$UserListeningsTable, List<UserListening>>
  _userListeningsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userListenings,
    aliasName: 'master_listenings__id__user_listenings__master_listening_id',
  );

  $$UserListeningsTableProcessedTableManager get userListeningsRefs {
    final manager = $$UserListeningsTableTableManager($_db, $_db.userListenings)
        .filter(
          (f) => f.masterListeningId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_userListeningsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReadingListeningsTable, List<ReadingListening>>
  _readingListeningsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.readingListenings,
        aliasName: 'master_listenings__id__reading_listenings__listening_id',
      );

  $$ReadingListeningsTableProcessedTableManager get readingListeningsRefs {
    final manager = $$ReadingListeningsTableTableManager(
      $_db,
      $_db.readingListenings,
    ).filter((f) => f.listeningId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _readingListeningsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MasterListeningsTableFilterComposer
    extends Composer<_$AppDatabase, $MasterListeningsTable> {
  $$MasterListeningsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transcript => $composableBuilder(
    column: $table.transcript,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get length => $composableBuilder(
    column: $table.length,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kanjiIds => $composableBuilder(
    column: $table.kanjiIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vocabularyIds => $composableBuilder(
    column: $table.vocabularyIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grammarIds => $composableBuilder(
    column: $table.grammarIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userListeningsRefs(
    Expression<bool> Function($$UserListeningsTableFilterComposer f) f,
  ) {
    final $$UserListeningsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userListenings,
      getReferencedColumn: (t) => t.masterListeningId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserListeningsTableFilterComposer(
            $db: $db,
            $table: $db.userListenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> readingListeningsRefs(
    Expression<bool> Function($$ReadingListeningsTableFilterComposer f) f,
  ) {
    final $$ReadingListeningsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readingListenings,
      getReferencedColumn: (t) => t.listeningId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingListeningsTableFilterComposer(
            $db: $db,
            $table: $db.readingListenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MasterListeningsTableOrderingComposer
    extends Composer<_$AppDatabase, $MasterListeningsTable> {
  $$MasterListeningsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transcript => $composableBuilder(
    column: $table.transcript,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get length => $composableBuilder(
    column: $table.length,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kanjiIds => $composableBuilder(
    column: $table.kanjiIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vocabularyIds => $composableBuilder(
    column: $table.vocabularyIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grammarIds => $composableBuilder(
    column: $table.grammarIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MasterListeningsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MasterListeningsTable> {
  $$MasterListeningsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get transcript => $composableBuilder(
    column: $table.transcript,
    builder: (column) => column,
  );

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);

  GeneratedColumn<int> get length =>
      $composableBuilder(column: $table.length, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kanjiIds =>
      $composableBuilder(column: $table.kanjiIds, builder: (column) => column);

  GeneratedColumn<String> get vocabularyIds => $composableBuilder(
    column: $table.vocabularyIds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grammarIds => $composableBuilder(
    column: $table.grammarIds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => column);

  GeneratedColumn<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  Expression<T> userListeningsRefs<T extends Object>(
    Expression<T> Function($$UserListeningsTableAnnotationComposer a) f,
  ) {
    final $$UserListeningsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userListenings,
      getReferencedColumn: (t) => t.masterListeningId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserListeningsTableAnnotationComposer(
            $db: $db,
            $table: $db.userListenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> readingListeningsRefs<T extends Object>(
    Expression<T> Function($$ReadingListeningsTableAnnotationComposer a) f,
  ) {
    final $$ReadingListeningsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.readingListenings,
          getReferencedColumn: (t) => t.listeningId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReadingListeningsTableAnnotationComposer(
                $db: $db,
                $table: $db.readingListenings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MasterListeningsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MasterListeningsTable,
          MasterListening,
          $$MasterListeningsTableFilterComposer,
          $$MasterListeningsTableOrderingComposer,
          $$MasterListeningsTableAnnotationComposer,
          $$MasterListeningsTableCreateCompanionBuilder,
          $$MasterListeningsTableUpdateCompanionBuilder,
          (MasterListening, $$MasterListeningsTableReferences),
          MasterListening,
          PrefetchHooks Function({
            bool userListeningsRefs,
            bool readingListeningsRefs,
          })
        > {
  $$MasterListeningsTableTableManager(
    _$AppDatabase db,
    $MasterListeningsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MasterListeningsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MasterListeningsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MasterListeningsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> transcript = const Value.absent(),
                Value<String?> audioPath = const Value.absent(),
                Value<int?> length = const Value.absent(),
                Value<String?> difficulty = const Value.absent(),
                Value<String?> kanjiIds = const Value.absent(),
                Value<String?> vocabularyIds = const Value.absent(),
                Value<String?> grammarIds = const Value.absent(),
                Value<String?> question = const Value.absent(),
                Value<String?> answer = const Value.absent(),
                Value<String?> explanation = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MasterListeningsCompanion(
                id: id,
                title: title,
                transcript: transcript,
                audioPath: audioPath,
                length: length,
                difficulty: difficulty,
                kanjiIds: kanjiIds,
                vocabularyIds: vocabularyIds,
                grammarIds: grammarIds,
                question: question,
                answer: answer,
                explanation: explanation,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String transcript,
                Value<String?> audioPath = const Value.absent(),
                Value<int?> length = const Value.absent(),
                Value<String?> difficulty = const Value.absent(),
                Value<String?> kanjiIds = const Value.absent(),
                Value<String?> vocabularyIds = const Value.absent(),
                Value<String?> grammarIds = const Value.absent(),
                Value<String?> question = const Value.absent(),
                Value<String?> answer = const Value.absent(),
                Value<String?> explanation = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MasterListeningsCompanion.insert(
                id: id,
                title: title,
                transcript: transcript,
                audioPath: audioPath,
                length: length,
                difficulty: difficulty,
                kanjiIds: kanjiIds,
                vocabularyIds: vocabularyIds,
                grammarIds: grammarIds,
                question: question,
                answer: answer,
                explanation: explanation,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MasterListeningsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({userListeningsRefs = false, readingListeningsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userListeningsRefs) db.userListenings,
                    if (readingListeningsRefs) db.readingListenings,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userListeningsRefs)
                        await $_getPrefetchedData<
                          MasterListening,
                          $MasterListeningsTable,
                          UserListening
                        >(
                          currentTable: table,
                          referencedTable: $$MasterListeningsTableReferences
                              ._userListeningsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterListeningsTableReferences(
                                db,
                                table,
                                p0,
                              ).userListeningsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.masterListeningId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (readingListeningsRefs)
                        await $_getPrefetchedData<
                          MasterListening,
                          $MasterListeningsTable,
                          ReadingListening
                        >(
                          currentTable: table,
                          referencedTable: $$MasterListeningsTableReferences
                              ._readingListeningsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MasterListeningsTableReferences(
                                db,
                                table,
                                p0,
                              ).readingListeningsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.listeningId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MasterListeningsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MasterListeningsTable,
      MasterListening,
      $$MasterListeningsTableFilterComposer,
      $$MasterListeningsTableOrderingComposer,
      $$MasterListeningsTableAnnotationComposer,
      $$MasterListeningsTableCreateCompanionBuilder,
      $$MasterListeningsTableUpdateCompanionBuilder,
      (MasterListening, $$MasterListeningsTableReferences),
      MasterListening,
      PrefetchHooks Function({
        bool userListeningsRefs,
        bool readingListeningsRefs,
      })
    >;
typedef $$UserListeningsTableCreateCompanionBuilder =
    UserListeningsCompanion Function({
      required String id,
      required String masterListeningId,
      Value<bool> isAdded,
      Value<bool> isFavorite,
      Value<String> status,
      Value<String> customNotes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UserListeningsTableUpdateCompanionBuilder =
    UserListeningsCompanion Function({
      Value<String> id,
      Value<String> masterListeningId,
      Value<bool> isAdded,
      Value<bool> isFavorite,
      Value<String> status,
      Value<String> customNotes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$UserListeningsTableReferences
    extends BaseReferences<_$AppDatabase, $UserListeningsTable, UserListening> {
  $$UserListeningsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MasterListeningsTable _masterListeningIdTable(_$AppDatabase db) =>
      db.masterListenings.createAlias(
        'user_listenings__master_listening_id__master_listenings__id',
      );

  $$MasterListeningsTableProcessedTableManager get masterListeningId {
    final $_column = $_itemColumn<String>('master_listening_id')!;

    final manager = $$MasterListeningsTableTableManager(
      $_db,
      $_db.masterListenings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_masterListeningIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserListeningsTableFilterComposer
    extends Composer<_$AppDatabase, $UserListeningsTable> {
  $$UserListeningsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAdded => $composableBuilder(
    column: $table.isAdded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MasterListeningsTableFilterComposer get masterListeningId {
    final $$MasterListeningsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterListeningId,
      referencedTable: $db.masterListenings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterListeningsTableFilterComposer(
            $db: $db,
            $table: $db.masterListenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserListeningsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserListeningsTable> {
  $$UserListeningsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAdded => $composableBuilder(
    column: $table.isAdded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MasterListeningsTableOrderingComposer get masterListeningId {
    final $$MasterListeningsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterListeningId,
      referencedTable: $db.masterListenings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterListeningsTableOrderingComposer(
            $db: $db,
            $table: $db.masterListenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserListeningsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserListeningsTable> {
  $$UserListeningsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isAdded =>
      $composableBuilder(column: $table.isAdded, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$MasterListeningsTableAnnotationComposer get masterListeningId {
    final $$MasterListeningsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.masterListeningId,
      referencedTable: $db.masterListenings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterListeningsTableAnnotationComposer(
            $db: $db,
            $table: $db.masterListenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserListeningsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserListeningsTable,
          UserListening,
          $$UserListeningsTableFilterComposer,
          $$UserListeningsTableOrderingComposer,
          $$UserListeningsTableAnnotationComposer,
          $$UserListeningsTableCreateCompanionBuilder,
          $$UserListeningsTableUpdateCompanionBuilder,
          (UserListening, $$UserListeningsTableReferences),
          UserListening,
          PrefetchHooks Function({bool masterListeningId})
        > {
  $$UserListeningsTableTableManager(
    _$AppDatabase db,
    $UserListeningsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserListeningsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserListeningsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserListeningsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> masterListeningId = const Value.absent(),
                Value<bool> isAdded = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> customNotes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserListeningsCompanion(
                id: id,
                masterListeningId: masterListeningId,
                isAdded: isAdded,
                isFavorite: isFavorite,
                status: status,
                customNotes: customNotes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String masterListeningId,
                Value<bool> isAdded = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> customNotes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserListeningsCompanion.insert(
                id: id,
                masterListeningId: masterListeningId,
                isAdded: isAdded,
                isFavorite: isFavorite,
                status: status,
                customNotes: customNotes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserListeningsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({masterListeningId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (masterListeningId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.masterListeningId,
                                referencedTable: $$UserListeningsTableReferences
                                    ._masterListeningIdTable(db),
                                referencedColumn:
                                    $$UserListeningsTableReferences
                                        ._masterListeningIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserListeningsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserListeningsTable,
      UserListening,
      $$UserListeningsTableFilterComposer,
      $$UserListeningsTableOrderingComposer,
      $$UserListeningsTableAnnotationComposer,
      $$UserListeningsTableCreateCompanionBuilder,
      $$UserListeningsTableUpdateCompanionBuilder,
      (UserListening, $$UserListeningsTableReferences),
      UserListening,
      PrefetchHooks Function({bool masterListeningId})
    >;
typedef $$KanjiVocabsTableCreateCompanionBuilder =
    KanjiVocabsCompanion Function({
      required String kanjiId,
      required String vocabId,
      Value<int> rowid,
    });
typedef $$KanjiVocabsTableUpdateCompanionBuilder =
    KanjiVocabsCompanion Function({
      Value<String> kanjiId,
      Value<String> vocabId,
      Value<int> rowid,
    });

final class $$KanjiVocabsTableReferences
    extends BaseReferences<_$AppDatabase, $KanjiVocabsTable, KanjiVocab> {
  $$KanjiVocabsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MasterKanjisTable _kanjiIdTable(_$AppDatabase db) =>
      db.masterKanjis.createAlias('kanji_vocabs__kanji_id__master_kanjis__id');

  $$MasterKanjisTableProcessedTableManager get kanjiId {
    final $_column = $_itemColumn<String>('kanji_id')!;

    final manager = $$MasterKanjisTableTableManager(
      $_db,
      $_db.masterKanjis,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kanjiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MasterVocabulariesTable _vocabIdTable(_$AppDatabase db) => db
      .masterVocabularies
      .createAlias('kanji_vocabs__vocab_id__master_vocabularies__id');

  $$MasterVocabulariesTableProcessedTableManager get vocabId {
    final $_column = $_itemColumn<String>('vocab_id')!;

    final manager = $$MasterVocabulariesTableTableManager(
      $_db,
      $_db.masterVocabularies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vocabIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$KanjiVocabsTableFilterComposer
    extends Composer<_$AppDatabase, $KanjiVocabsTable> {
  $$KanjiVocabsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterKanjisTableFilterComposer get kanjiId {
    final $$MasterKanjisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kanjiId,
      referencedTable: $db.masterKanjis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterKanjisTableFilterComposer(
            $db: $db,
            $table: $db.masterKanjis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterVocabulariesTableFilterComposer get vocabId {
    final $$MasterVocabulariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabId,
      referencedTable: $db.masterVocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterVocabulariesTableFilterComposer(
            $db: $db,
            $table: $db.masterVocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KanjiVocabsTableOrderingComposer
    extends Composer<_$AppDatabase, $KanjiVocabsTable> {
  $$KanjiVocabsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterKanjisTableOrderingComposer get kanjiId {
    final $$MasterKanjisTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kanjiId,
      referencedTable: $db.masterKanjis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterKanjisTableOrderingComposer(
            $db: $db,
            $table: $db.masterKanjis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterVocabulariesTableOrderingComposer get vocabId {
    final $$MasterVocabulariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabId,
      referencedTable: $db.masterVocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterVocabulariesTableOrderingComposer(
            $db: $db,
            $table: $db.masterVocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KanjiVocabsTableAnnotationComposer
    extends Composer<_$AppDatabase, $KanjiVocabsTable> {
  $$KanjiVocabsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterKanjisTableAnnotationComposer get kanjiId {
    final $$MasterKanjisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kanjiId,
      referencedTable: $db.masterKanjis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterKanjisTableAnnotationComposer(
            $db: $db,
            $table: $db.masterKanjis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterVocabulariesTableAnnotationComposer get vocabId {
    final $$MasterVocabulariesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.vocabId,
          referencedTable: $db.masterVocabularies,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MasterVocabulariesTableAnnotationComposer(
                $db: $db,
                $table: $db.masterVocabularies,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$KanjiVocabsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KanjiVocabsTable,
          KanjiVocab,
          $$KanjiVocabsTableFilterComposer,
          $$KanjiVocabsTableOrderingComposer,
          $$KanjiVocabsTableAnnotationComposer,
          $$KanjiVocabsTableCreateCompanionBuilder,
          $$KanjiVocabsTableUpdateCompanionBuilder,
          (KanjiVocab, $$KanjiVocabsTableReferences),
          KanjiVocab,
          PrefetchHooks Function({bool kanjiId, bool vocabId})
        > {
  $$KanjiVocabsTableTableManager(_$AppDatabase db, $KanjiVocabsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiVocabsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiVocabsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiVocabsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> kanjiId = const Value.absent(),
                Value<String> vocabId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KanjiVocabsCompanion(
                kanjiId: kanjiId,
                vocabId: vocabId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String kanjiId,
                required String vocabId,
                Value<int> rowid = const Value.absent(),
              }) => KanjiVocabsCompanion.insert(
                kanjiId: kanjiId,
                vocabId: vocabId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$KanjiVocabsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({kanjiId = false, vocabId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (kanjiId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.kanjiId,
                                referencedTable: $$KanjiVocabsTableReferences
                                    ._kanjiIdTable(db),
                                referencedColumn: $$KanjiVocabsTableReferences
                                    ._kanjiIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (vocabId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vocabId,
                                referencedTable: $$KanjiVocabsTableReferences
                                    ._vocabIdTable(db),
                                referencedColumn: $$KanjiVocabsTableReferences
                                    ._vocabIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$KanjiVocabsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KanjiVocabsTable,
      KanjiVocab,
      $$KanjiVocabsTableFilterComposer,
      $$KanjiVocabsTableOrderingComposer,
      $$KanjiVocabsTableAnnotationComposer,
      $$KanjiVocabsTableCreateCompanionBuilder,
      $$KanjiVocabsTableUpdateCompanionBuilder,
      (KanjiVocab, $$KanjiVocabsTableReferences),
      KanjiVocab,
      PrefetchHooks Function({bool kanjiId, bool vocabId})
    >;
typedef $$VocabGrammarsTableCreateCompanionBuilder =
    VocabGrammarsCompanion Function({
      required String vocabId,
      required String grammarId,
      Value<int> rowid,
    });
typedef $$VocabGrammarsTableUpdateCompanionBuilder =
    VocabGrammarsCompanion Function({
      Value<String> vocabId,
      Value<String> grammarId,
      Value<int> rowid,
    });

final class $$VocabGrammarsTableReferences
    extends BaseReferences<_$AppDatabase, $VocabGrammarsTable, VocabGrammar> {
  $$VocabGrammarsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MasterVocabulariesTable _vocabIdTable(_$AppDatabase db) => db
      .masterVocabularies
      .createAlias('vocab_grammars__vocab_id__master_vocabularies__id');

  $$MasterVocabulariesTableProcessedTableManager get vocabId {
    final $_column = $_itemColumn<String>('vocab_id')!;

    final manager = $$MasterVocabulariesTableTableManager(
      $_db,
      $_db.masterVocabularies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vocabIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MasterGrammarsTable _grammarIdTable(_$AppDatabase db) => db
      .masterGrammars
      .createAlias('vocab_grammars__grammar_id__master_grammars__id');

  $$MasterGrammarsTableProcessedTableManager get grammarId {
    final $_column = $_itemColumn<String>('grammar_id')!;

    final manager = $$MasterGrammarsTableTableManager(
      $_db,
      $_db.masterGrammars,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_grammarIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VocabGrammarsTableFilterComposer
    extends Composer<_$AppDatabase, $VocabGrammarsTable> {
  $$VocabGrammarsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterVocabulariesTableFilterComposer get vocabId {
    final $$MasterVocabulariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabId,
      referencedTable: $db.masterVocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterVocabulariesTableFilterComposer(
            $db: $db,
            $table: $db.masterVocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterGrammarsTableFilterComposer get grammarId {
    final $$MasterGrammarsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.grammarId,
      referencedTable: $db.masterGrammars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterGrammarsTableFilterComposer(
            $db: $db,
            $table: $db.masterGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabGrammarsTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabGrammarsTable> {
  $$VocabGrammarsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterVocabulariesTableOrderingComposer get vocabId {
    final $$MasterVocabulariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabId,
      referencedTable: $db.masterVocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterVocabulariesTableOrderingComposer(
            $db: $db,
            $table: $db.masterVocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterGrammarsTableOrderingComposer get grammarId {
    final $$MasterGrammarsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.grammarId,
      referencedTable: $db.masterGrammars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterGrammarsTableOrderingComposer(
            $db: $db,
            $table: $db.masterGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabGrammarsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabGrammarsTable> {
  $$VocabGrammarsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterVocabulariesTableAnnotationComposer get vocabId {
    final $$MasterVocabulariesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.vocabId,
          referencedTable: $db.masterVocabularies,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MasterVocabulariesTableAnnotationComposer(
                $db: $db,
                $table: $db.masterVocabularies,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$MasterGrammarsTableAnnotationComposer get grammarId {
    final $$MasterGrammarsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.grammarId,
      referencedTable: $db.masterGrammars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterGrammarsTableAnnotationComposer(
            $db: $db,
            $table: $db.masterGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabGrammarsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VocabGrammarsTable,
          VocabGrammar,
          $$VocabGrammarsTableFilterComposer,
          $$VocabGrammarsTableOrderingComposer,
          $$VocabGrammarsTableAnnotationComposer,
          $$VocabGrammarsTableCreateCompanionBuilder,
          $$VocabGrammarsTableUpdateCompanionBuilder,
          (VocabGrammar, $$VocabGrammarsTableReferences),
          VocabGrammar,
          PrefetchHooks Function({bool vocabId, bool grammarId})
        > {
  $$VocabGrammarsTableTableManager(_$AppDatabase db, $VocabGrammarsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabGrammarsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabGrammarsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabGrammarsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> vocabId = const Value.absent(),
                Value<String> grammarId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VocabGrammarsCompanion(
                vocabId: vocabId,
                grammarId: grammarId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String vocabId,
                required String grammarId,
                Value<int> rowid = const Value.absent(),
              }) => VocabGrammarsCompanion.insert(
                vocabId: vocabId,
                grammarId: grammarId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VocabGrammarsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vocabId = false, grammarId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vocabId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vocabId,
                                referencedTable: $$VocabGrammarsTableReferences
                                    ._vocabIdTable(db),
                                referencedColumn: $$VocabGrammarsTableReferences
                                    ._vocabIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (grammarId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.grammarId,
                                referencedTable: $$VocabGrammarsTableReferences
                                    ._grammarIdTable(db),
                                referencedColumn: $$VocabGrammarsTableReferences
                                    ._grammarIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VocabGrammarsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VocabGrammarsTable,
      VocabGrammar,
      $$VocabGrammarsTableFilterComposer,
      $$VocabGrammarsTableOrderingComposer,
      $$VocabGrammarsTableAnnotationComposer,
      $$VocabGrammarsTableCreateCompanionBuilder,
      $$VocabGrammarsTableUpdateCompanionBuilder,
      (VocabGrammar, $$VocabGrammarsTableReferences),
      VocabGrammar,
      PrefetchHooks Function({bool vocabId, bool grammarId})
    >;
typedef $$GrammarReadingsTableCreateCompanionBuilder =
    GrammarReadingsCompanion Function({
      required String grammarId,
      required String readingId,
      Value<int> rowid,
    });
typedef $$GrammarReadingsTableUpdateCompanionBuilder =
    GrammarReadingsCompanion Function({
      Value<String> grammarId,
      Value<String> readingId,
      Value<int> rowid,
    });

final class $$GrammarReadingsTableReferences
    extends
        BaseReferences<_$AppDatabase, $GrammarReadingsTable, GrammarReading> {
  $$GrammarReadingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MasterGrammarsTable _grammarIdTable(_$AppDatabase db) => db
      .masterGrammars
      .createAlias('grammar_readings__grammar_id__master_grammars__id');

  $$MasterGrammarsTableProcessedTableManager get grammarId {
    final $_column = $_itemColumn<String>('grammar_id')!;

    final manager = $$MasterGrammarsTableTableManager(
      $_db,
      $_db.masterGrammars,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_grammarIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MasterReadingsTable _readingIdTable(_$AppDatabase db) => db
      .masterReadings
      .createAlias('grammar_readings__reading_id__master_readings__id');

  $$MasterReadingsTableProcessedTableManager get readingId {
    final $_column = $_itemColumn<String>('reading_id')!;

    final manager = $$MasterReadingsTableTableManager(
      $_db,
      $_db.masterReadings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_readingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GrammarReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $GrammarReadingsTable> {
  $$GrammarReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterGrammarsTableFilterComposer get grammarId {
    final $$MasterGrammarsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.grammarId,
      referencedTable: $db.masterGrammars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterGrammarsTableFilterComposer(
            $db: $db,
            $table: $db.masterGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterReadingsTableFilterComposer get readingId {
    final $$MasterReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableFilterComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrammarReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $GrammarReadingsTable> {
  $$GrammarReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterGrammarsTableOrderingComposer get grammarId {
    final $$MasterGrammarsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.grammarId,
      referencedTable: $db.masterGrammars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterGrammarsTableOrderingComposer(
            $db: $db,
            $table: $db.masterGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterReadingsTableOrderingComposer get readingId {
    final $$MasterReadingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableOrderingComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrammarReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrammarReadingsTable> {
  $$GrammarReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterGrammarsTableAnnotationComposer get grammarId {
    final $$MasterGrammarsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.grammarId,
      referencedTable: $db.masterGrammars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterGrammarsTableAnnotationComposer(
            $db: $db,
            $table: $db.masterGrammars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterReadingsTableAnnotationComposer get readingId {
    final $$MasterReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrammarReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GrammarReadingsTable,
          GrammarReading,
          $$GrammarReadingsTableFilterComposer,
          $$GrammarReadingsTableOrderingComposer,
          $$GrammarReadingsTableAnnotationComposer,
          $$GrammarReadingsTableCreateCompanionBuilder,
          $$GrammarReadingsTableUpdateCompanionBuilder,
          (GrammarReading, $$GrammarReadingsTableReferences),
          GrammarReading,
          PrefetchHooks Function({bool grammarId, bool readingId})
        > {
  $$GrammarReadingsTableTableManager(
    _$AppDatabase db,
    $GrammarReadingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrammarReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GrammarReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrammarReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> grammarId = const Value.absent(),
                Value<String> readingId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrammarReadingsCompanion(
                grammarId: grammarId,
                readingId: readingId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String grammarId,
                required String readingId,
                Value<int> rowid = const Value.absent(),
              }) => GrammarReadingsCompanion.insert(
                grammarId: grammarId,
                readingId: readingId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GrammarReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({grammarId = false, readingId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (grammarId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.grammarId,
                                referencedTable:
                                    $$GrammarReadingsTableReferences
                                        ._grammarIdTable(db),
                                referencedColumn:
                                    $$GrammarReadingsTableReferences
                                        ._grammarIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (readingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.readingId,
                                referencedTable:
                                    $$GrammarReadingsTableReferences
                                        ._readingIdTable(db),
                                referencedColumn:
                                    $$GrammarReadingsTableReferences
                                        ._readingIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GrammarReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GrammarReadingsTable,
      GrammarReading,
      $$GrammarReadingsTableFilterComposer,
      $$GrammarReadingsTableOrderingComposer,
      $$GrammarReadingsTableAnnotationComposer,
      $$GrammarReadingsTableCreateCompanionBuilder,
      $$GrammarReadingsTableUpdateCompanionBuilder,
      (GrammarReading, $$GrammarReadingsTableReferences),
      GrammarReading,
      PrefetchHooks Function({bool grammarId, bool readingId})
    >;
typedef $$ReadingListeningsTableCreateCompanionBuilder =
    ReadingListeningsCompanion Function({
      required String readingId,
      required String listeningId,
      Value<int> rowid,
    });
typedef $$ReadingListeningsTableUpdateCompanionBuilder =
    ReadingListeningsCompanion Function({
      Value<String> readingId,
      Value<String> listeningId,
      Value<int> rowid,
    });

final class $$ReadingListeningsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ReadingListeningsTable,
          ReadingListening
        > {
  $$ReadingListeningsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MasterReadingsTable _readingIdTable(_$AppDatabase db) => db
      .masterReadings
      .createAlias('reading_listenings__reading_id__master_readings__id');

  $$MasterReadingsTableProcessedTableManager get readingId {
    final $_column = $_itemColumn<String>('reading_id')!;

    final manager = $$MasterReadingsTableTableManager(
      $_db,
      $_db.masterReadings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_readingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MasterListeningsTable _listeningIdTable(_$AppDatabase db) => db
      .masterListenings
      .createAlias('reading_listenings__listening_id__master_listenings__id');

  $$MasterListeningsTableProcessedTableManager get listeningId {
    final $_column = $_itemColumn<String>('listening_id')!;

    final manager = $$MasterListeningsTableTableManager(
      $_db,
      $_db.masterListenings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_listeningIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReadingListeningsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingListeningsTable> {
  $$ReadingListeningsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterReadingsTableFilterComposer get readingId {
    final $$MasterReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableFilterComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterListeningsTableFilterComposer get listeningId {
    final $$MasterListeningsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listeningId,
      referencedTable: $db.masterListenings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterListeningsTableFilterComposer(
            $db: $db,
            $table: $db.masterListenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingListeningsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingListeningsTable> {
  $$ReadingListeningsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterReadingsTableOrderingComposer get readingId {
    final $$MasterReadingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableOrderingComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterListeningsTableOrderingComposer get listeningId {
    final $$MasterListeningsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listeningId,
      referencedTable: $db.masterListenings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterListeningsTableOrderingComposer(
            $db: $db,
            $table: $db.masterListenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingListeningsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingListeningsTable> {
  $$ReadingListeningsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterReadingsTableAnnotationComposer get readingId {
    final $$MasterReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterListeningsTableAnnotationComposer get listeningId {
    final $$MasterListeningsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listeningId,
      referencedTable: $db.masterListenings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterListeningsTableAnnotationComposer(
            $db: $db,
            $table: $db.masterListenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingListeningsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingListeningsTable,
          ReadingListening,
          $$ReadingListeningsTableFilterComposer,
          $$ReadingListeningsTableOrderingComposer,
          $$ReadingListeningsTableAnnotationComposer,
          $$ReadingListeningsTableCreateCompanionBuilder,
          $$ReadingListeningsTableUpdateCompanionBuilder,
          (ReadingListening, $$ReadingListeningsTableReferences),
          ReadingListening,
          PrefetchHooks Function({bool readingId, bool listeningId})
        > {
  $$ReadingListeningsTableTableManager(
    _$AppDatabase db,
    $ReadingListeningsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingListeningsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingListeningsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingListeningsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> readingId = const Value.absent(),
                Value<String> listeningId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadingListeningsCompanion(
                readingId: readingId,
                listeningId: listeningId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String readingId,
                required String listeningId,
                Value<int> rowid = const Value.absent(),
              }) => ReadingListeningsCompanion.insert(
                readingId: readingId,
                listeningId: listeningId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReadingListeningsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({readingId = false, listeningId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (readingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.readingId,
                                referencedTable:
                                    $$ReadingListeningsTableReferences
                                        ._readingIdTable(db),
                                referencedColumn:
                                    $$ReadingListeningsTableReferences
                                        ._readingIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (listeningId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.listeningId,
                                referencedTable:
                                    $$ReadingListeningsTableReferences
                                        ._listeningIdTable(db),
                                referencedColumn:
                                    $$ReadingListeningsTableReferences
                                        ._listeningIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReadingListeningsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingListeningsTable,
      ReadingListening,
      $$ReadingListeningsTableFilterComposer,
      $$ReadingListeningsTableOrderingComposer,
      $$ReadingListeningsTableAnnotationComposer,
      $$ReadingListeningsTableCreateCompanionBuilder,
      $$ReadingListeningsTableUpdateCompanionBuilder,
      (ReadingListening, $$ReadingListeningsTableReferences),
      ReadingListening,
      PrefetchHooks Function({bool readingId, bool listeningId})
    >;
typedef $$KanjiReadingsTableCreateCompanionBuilder =
    KanjiReadingsCompanion Function({
      required String kanjiId,
      required String readingId,
      Value<int> rowid,
    });
typedef $$KanjiReadingsTableUpdateCompanionBuilder =
    KanjiReadingsCompanion Function({
      Value<String> kanjiId,
      Value<String> readingId,
      Value<int> rowid,
    });

final class $$KanjiReadingsTableReferences
    extends BaseReferences<_$AppDatabase, $KanjiReadingsTable, KanjiReading> {
  $$KanjiReadingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MasterKanjisTable _kanjiIdTable(_$AppDatabase db) => db.masterKanjis
      .createAlias('kanji_readings__kanji_id__master_kanjis__id');

  $$MasterKanjisTableProcessedTableManager get kanjiId {
    final $_column = $_itemColumn<String>('kanji_id')!;

    final manager = $$MasterKanjisTableTableManager(
      $_db,
      $_db.masterKanjis,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kanjiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MasterReadingsTable _readingIdTable(_$AppDatabase db) => db
      .masterReadings
      .createAlias('kanji_readings__reading_id__master_readings__id');

  $$MasterReadingsTableProcessedTableManager get readingId {
    final $_column = $_itemColumn<String>('reading_id')!;

    final manager = $$MasterReadingsTableTableManager(
      $_db,
      $_db.masterReadings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_readingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$KanjiReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $KanjiReadingsTable> {
  $$KanjiReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterKanjisTableFilterComposer get kanjiId {
    final $$MasterKanjisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kanjiId,
      referencedTable: $db.masterKanjis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterKanjisTableFilterComposer(
            $db: $db,
            $table: $db.masterKanjis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterReadingsTableFilterComposer get readingId {
    final $$MasterReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableFilterComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KanjiReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $KanjiReadingsTable> {
  $$KanjiReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterKanjisTableOrderingComposer get kanjiId {
    final $$MasterKanjisTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kanjiId,
      referencedTable: $db.masterKanjis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterKanjisTableOrderingComposer(
            $db: $db,
            $table: $db.masterKanjis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterReadingsTableOrderingComposer get readingId {
    final $$MasterReadingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableOrderingComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KanjiReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $KanjiReadingsTable> {
  $$KanjiReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterKanjisTableAnnotationComposer get kanjiId {
    final $$MasterKanjisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kanjiId,
      referencedTable: $db.masterKanjis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterKanjisTableAnnotationComposer(
            $db: $db,
            $table: $db.masterKanjis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterReadingsTableAnnotationComposer get readingId {
    final $$MasterReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KanjiReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KanjiReadingsTable,
          KanjiReading,
          $$KanjiReadingsTableFilterComposer,
          $$KanjiReadingsTableOrderingComposer,
          $$KanjiReadingsTableAnnotationComposer,
          $$KanjiReadingsTableCreateCompanionBuilder,
          $$KanjiReadingsTableUpdateCompanionBuilder,
          (KanjiReading, $$KanjiReadingsTableReferences),
          KanjiReading,
          PrefetchHooks Function({bool kanjiId, bool readingId})
        > {
  $$KanjiReadingsTableTableManager(_$AppDatabase db, $KanjiReadingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> kanjiId = const Value.absent(),
                Value<String> readingId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KanjiReadingsCompanion(
                kanjiId: kanjiId,
                readingId: readingId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String kanjiId,
                required String readingId,
                Value<int> rowid = const Value.absent(),
              }) => KanjiReadingsCompanion.insert(
                kanjiId: kanjiId,
                readingId: readingId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$KanjiReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({kanjiId = false, readingId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (kanjiId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.kanjiId,
                                referencedTable: $$KanjiReadingsTableReferences
                                    ._kanjiIdTable(db),
                                referencedColumn: $$KanjiReadingsTableReferences
                                    ._kanjiIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (readingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.readingId,
                                referencedTable: $$KanjiReadingsTableReferences
                                    ._readingIdTable(db),
                                referencedColumn: $$KanjiReadingsTableReferences
                                    ._readingIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$KanjiReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KanjiReadingsTable,
      KanjiReading,
      $$KanjiReadingsTableFilterComposer,
      $$KanjiReadingsTableOrderingComposer,
      $$KanjiReadingsTableAnnotationComposer,
      $$KanjiReadingsTableCreateCompanionBuilder,
      $$KanjiReadingsTableUpdateCompanionBuilder,
      (KanjiReading, $$KanjiReadingsTableReferences),
      KanjiReading,
      PrefetchHooks Function({bool kanjiId, bool readingId})
    >;
typedef $$VocabReadingsTableCreateCompanionBuilder =
    VocabReadingsCompanion Function({
      required String vocabId,
      required String readingId,
      Value<int> rowid,
    });
typedef $$VocabReadingsTableUpdateCompanionBuilder =
    VocabReadingsCompanion Function({
      Value<String> vocabId,
      Value<String> readingId,
      Value<int> rowid,
    });

final class $$VocabReadingsTableReferences
    extends BaseReferences<_$AppDatabase, $VocabReadingsTable, VocabReading> {
  $$VocabReadingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MasterVocabulariesTable _vocabIdTable(_$AppDatabase db) => db
      .masterVocabularies
      .createAlias('vocab_readings__vocab_id__master_vocabularies__id');

  $$MasterVocabulariesTableProcessedTableManager get vocabId {
    final $_column = $_itemColumn<String>('vocab_id')!;

    final manager = $$MasterVocabulariesTableTableManager(
      $_db,
      $_db.masterVocabularies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vocabIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MasterReadingsTable _readingIdTable(_$AppDatabase db) => db
      .masterReadings
      .createAlias('vocab_readings__reading_id__master_readings__id');

  $$MasterReadingsTableProcessedTableManager get readingId {
    final $_column = $_itemColumn<String>('reading_id')!;

    final manager = $$MasterReadingsTableTableManager(
      $_db,
      $_db.masterReadings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_readingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VocabReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $VocabReadingsTable> {
  $$VocabReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterVocabulariesTableFilterComposer get vocabId {
    final $$MasterVocabulariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabId,
      referencedTable: $db.masterVocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterVocabulariesTableFilterComposer(
            $db: $db,
            $table: $db.masterVocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterReadingsTableFilterComposer get readingId {
    final $$MasterReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableFilterComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabReadingsTable> {
  $$VocabReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterVocabulariesTableOrderingComposer get vocabId {
    final $$MasterVocabulariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabId,
      referencedTable: $db.masterVocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterVocabulariesTableOrderingComposer(
            $db: $db,
            $table: $db.masterVocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MasterReadingsTableOrderingComposer get readingId {
    final $$MasterReadingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableOrderingComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabReadingsTable> {
  $$VocabReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MasterVocabulariesTableAnnotationComposer get vocabId {
    final $$MasterVocabulariesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.vocabId,
          referencedTable: $db.masterVocabularies,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MasterVocabulariesTableAnnotationComposer(
                $db: $db,
                $table: $db.masterVocabularies,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$MasterReadingsTableAnnotationComposer get readingId {
    final $$MasterReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingId,
      referencedTable: $db.masterReadings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.masterReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VocabReadingsTable,
          VocabReading,
          $$VocabReadingsTableFilterComposer,
          $$VocabReadingsTableOrderingComposer,
          $$VocabReadingsTableAnnotationComposer,
          $$VocabReadingsTableCreateCompanionBuilder,
          $$VocabReadingsTableUpdateCompanionBuilder,
          (VocabReading, $$VocabReadingsTableReferences),
          VocabReading,
          PrefetchHooks Function({bool vocabId, bool readingId})
        > {
  $$VocabReadingsTableTableManager(_$AppDatabase db, $VocabReadingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> vocabId = const Value.absent(),
                Value<String> readingId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VocabReadingsCompanion(
                vocabId: vocabId,
                readingId: readingId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String vocabId,
                required String readingId,
                Value<int> rowid = const Value.absent(),
              }) => VocabReadingsCompanion.insert(
                vocabId: vocabId,
                readingId: readingId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VocabReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vocabId = false, readingId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vocabId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vocabId,
                                referencedTable: $$VocabReadingsTableReferences
                                    ._vocabIdTable(db),
                                referencedColumn: $$VocabReadingsTableReferences
                                    ._vocabIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (readingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.readingId,
                                referencedTable: $$VocabReadingsTableReferences
                                    ._readingIdTable(db),
                                referencedColumn: $$VocabReadingsTableReferences
                                    ._readingIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VocabReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VocabReadingsTable,
      VocabReading,
      $$VocabReadingsTableFilterComposer,
      $$VocabReadingsTableOrderingComposer,
      $$VocabReadingsTableAnnotationComposer,
      $$VocabReadingsTableCreateCompanionBuilder,
      $$VocabReadingsTableUpdateCompanionBuilder,
      (VocabReading, $$VocabReadingsTableReferences),
      VocabReading,
      PrefetchHooks Function({bool vocabId, bool readingId})
    >;
typedef $$StudySessionsTableCreateCompanionBuilder =
    StudySessionsCompanion Function({
      required String id,
      required DateTime date,
      required int durationSeconds,
      required String category,
      Value<int> rowid,
    });
typedef $$StudySessionsTableUpdateCompanionBuilder =
    StudySessionsCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<int> durationSeconds,
      Value<String> category,
      Value<int> rowid,
    });

class $$StudySessionsTableFilterComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudySessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudySessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);
}

class $$StudySessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudySessionsTable,
          StudySession,
          $$StudySessionsTableFilterComposer,
          $$StudySessionsTableOrderingComposer,
          $$StudySessionsTableAnnotationComposer,
          $$StudySessionsTableCreateCompanionBuilder,
          $$StudySessionsTableUpdateCompanionBuilder,
          (
            StudySession,
            BaseReferences<_$AppDatabase, $StudySessionsTable, StudySession>,
          ),
          StudySession,
          PrefetchHooks Function()
        > {
  $$StudySessionsTableTableManager(_$AppDatabase db, $StudySessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudySessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudySessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudySessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudySessionsCompanion(
                id: id,
                date: date,
                durationSeconds: durationSeconds,
                category: category,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required int durationSeconds,
                required String category,
                Value<int> rowid = const Value.absent(),
              }) => StudySessionsCompanion.insert(
                id: id,
                date: date,
                durationSeconds: durationSeconds,
                category: category,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudySessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudySessionsTable,
      StudySession,
      $$StudySessionsTableFilterComposer,
      $$StudySessionsTableOrderingComposer,
      $$StudySessionsTableAnnotationComposer,
      $$StudySessionsTableCreateCompanionBuilder,
      $$StudySessionsTableUpdateCompanionBuilder,
      (
        StudySession,
        BaseReferences<_$AppDatabase, $StudySessionsTable, StudySession>,
      ),
      StudySession,
      PrefetchHooks Function()
    >;
typedef $$DailyGoalsTableCreateCompanionBuilder =
    DailyGoalsCompanion Function({
      required String id,
      Value<int> targetSeconds,
      Value<int> completedSeconds,
      Value<int> targetItems,
      Value<int> completedItems,
      Value<int> rowid,
    });
typedef $$DailyGoalsTableUpdateCompanionBuilder =
    DailyGoalsCompanion Function({
      Value<String> id,
      Value<int> targetSeconds,
      Value<int> completedSeconds,
      Value<int> targetItems,
      Value<int> completedItems,
      Value<int> rowid,
    });

class $$DailyGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyGoalsTable> {
  $$DailyGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetSeconds => $composableBuilder(
    column: $table.targetSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedSeconds => $composableBuilder(
    column: $table.completedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetItems => $composableBuilder(
    column: $table.targetItems,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedItems => $composableBuilder(
    column: $table.completedItems,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyGoalsTable> {
  $$DailyGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetSeconds => $composableBuilder(
    column: $table.targetSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedSeconds => $composableBuilder(
    column: $table.completedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetItems => $composableBuilder(
    column: $table.targetItems,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedItems => $composableBuilder(
    column: $table.completedItems,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyGoalsTable> {
  $$DailyGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get targetSeconds => $composableBuilder(
    column: $table.targetSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedSeconds => $composableBuilder(
    column: $table.completedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetItems => $composableBuilder(
    column: $table.targetItems,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedItems => $composableBuilder(
    column: $table.completedItems,
    builder: (column) => column,
  );
}

class $$DailyGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyGoalsTable,
          DailyGoal,
          $$DailyGoalsTableFilterComposer,
          $$DailyGoalsTableOrderingComposer,
          $$DailyGoalsTableAnnotationComposer,
          $$DailyGoalsTableCreateCompanionBuilder,
          $$DailyGoalsTableUpdateCompanionBuilder,
          (
            DailyGoal,
            BaseReferences<_$AppDatabase, $DailyGoalsTable, DailyGoal>,
          ),
          DailyGoal,
          PrefetchHooks Function()
        > {
  $$DailyGoalsTableTableManager(_$AppDatabase db, $DailyGoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> targetSeconds = const Value.absent(),
                Value<int> completedSeconds = const Value.absent(),
                Value<int> targetItems = const Value.absent(),
                Value<int> completedItems = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyGoalsCompanion(
                id: id,
                targetSeconds: targetSeconds,
                completedSeconds: completedSeconds,
                targetItems: targetItems,
                completedItems: completedItems,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int> targetSeconds = const Value.absent(),
                Value<int> completedSeconds = const Value.absent(),
                Value<int> targetItems = const Value.absent(),
                Value<int> completedItems = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyGoalsCompanion.insert(
                id: id,
                targetSeconds: targetSeconds,
                completedSeconds: completedSeconds,
                targetItems: targetItems,
                completedItems: completedItems,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyGoalsTable,
      DailyGoal,
      $$DailyGoalsTableFilterComposer,
      $$DailyGoalsTableOrderingComposer,
      $$DailyGoalsTableAnnotationComposer,
      $$DailyGoalsTableCreateCompanionBuilder,
      $$DailyGoalsTableUpdateCompanionBuilder,
      (DailyGoal, BaseReferences<_$AppDatabase, $DailyGoalsTable, DailyGoal>),
      DailyGoal,
      PrefetchHooks Function()
    >;
typedef $$QuizResultsTableCreateCompanionBuilder =
    QuizResultsCompanion Function({
      required String id,
      required DateTime date,
      required int correctCount,
      required int totalCount,
      required String quizType,
      Value<int> rowid,
    });
typedef $$QuizResultsTableUpdateCompanionBuilder =
    QuizResultsCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<int> correctCount,
      Value<int> totalCount,
      Value<String> quizType,
      Value<int> rowid,
    });

class $$QuizResultsTableFilterComposer
    extends Composer<_$AppDatabase, $QuizResultsTable> {
  $$QuizResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quizType => $composableBuilder(
    column: $table.quizType,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuizResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuizResultsTable> {
  $$QuizResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quizType => $composableBuilder(
    column: $table.quizType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuizResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuizResultsTable> {
  $$QuizResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quizType =>
      $composableBuilder(column: $table.quizType, builder: (column) => column);
}

class $$QuizResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuizResultsTable,
          QuizResult,
          $$QuizResultsTableFilterComposer,
          $$QuizResultsTableOrderingComposer,
          $$QuizResultsTableAnnotationComposer,
          $$QuizResultsTableCreateCompanionBuilder,
          $$QuizResultsTableUpdateCompanionBuilder,
          (
            QuizResult,
            BaseReferences<_$AppDatabase, $QuizResultsTable, QuizResult>,
          ),
          QuizResult,
          PrefetchHooks Function()
        > {
  $$QuizResultsTableTableManager(_$AppDatabase db, $QuizResultsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuizResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuizResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuizResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> totalCount = const Value.absent(),
                Value<String> quizType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuizResultsCompanion(
                id: id,
                date: date,
                correctCount: correctCount,
                totalCount: totalCount,
                quizType: quizType,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required int correctCount,
                required int totalCount,
                required String quizType,
                Value<int> rowid = const Value.absent(),
              }) => QuizResultsCompanion.insert(
                id: id,
                date: date,
                correctCount: correctCount,
                totalCount: totalCount,
                quizType: quizType,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuizResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuizResultsTable,
      QuizResult,
      $$QuizResultsTableFilterComposer,
      $$QuizResultsTableOrderingComposer,
      $$QuizResultsTableAnnotationComposer,
      $$QuizResultsTableCreateCompanionBuilder,
      $$QuizResultsTableUpdateCompanionBuilder,
      (
        QuizResult,
        BaseReferences<_$AppDatabase, $QuizResultsTable, QuizResult>,
      ),
      QuizResult,
      PrefetchHooks Function()
    >;
typedef $$StudyPlansTableCreateCompanionBuilder =
    StudyPlansCompanion Function({
      required String id,
      required DateTime startDate,
      required DateTime targetDate,
      required double availableHours,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$StudyPlansTableUpdateCompanionBuilder =
    StudyPlansCompanion Function({
      Value<String> id,
      Value<DateTime> startDate,
      Value<DateTime> targetDate,
      Value<double> availableHours,
      Value<bool> isActive,
      Value<int> rowid,
    });

class $$StudyPlansTableFilterComposer
    extends Composer<_$AppDatabase, $StudyPlansTable> {
  $$StudyPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get availableHours => $composableBuilder(
    column: $table.availableHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudyPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyPlansTable> {
  $$StudyPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get availableHours => $composableBuilder(
    column: $table.availableHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyPlansTable> {
  $$StudyPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get availableHours => $composableBuilder(
    column: $table.availableHours,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$StudyPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudyPlansTable,
          StudyPlan,
          $$StudyPlansTableFilterComposer,
          $$StudyPlansTableOrderingComposer,
          $$StudyPlansTableAnnotationComposer,
          $$StudyPlansTableCreateCompanionBuilder,
          $$StudyPlansTableUpdateCompanionBuilder,
          (
            StudyPlan,
            BaseReferences<_$AppDatabase, $StudyPlansTable, StudyPlan>,
          ),
          StudyPlan,
          PrefetchHooks Function()
        > {
  $$StudyPlansTableTableManager(_$AppDatabase db, $StudyPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudyPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> targetDate = const Value.absent(),
                Value<double> availableHours = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyPlansCompanion(
                id: id,
                startDate: startDate,
                targetDate: targetDate,
                availableHours: availableHours,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime startDate,
                required DateTime targetDate,
                required double availableHours,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyPlansCompanion.insert(
                id: id,
                startDate: startDate,
                targetDate: targetDate,
                availableHours: availableHours,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudyPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudyPlansTable,
      StudyPlan,
      $$StudyPlansTableFilterComposer,
      $$StudyPlansTableOrderingComposer,
      $$StudyPlansTableAnnotationComposer,
      $$StudyPlansTableCreateCompanionBuilder,
      $$StudyPlansTableUpdateCompanionBuilder,
      (StudyPlan, BaseReferences<_$AppDatabase, $StudyPlansTable, StudyPlan>),
      StudyPlan,
      PrefetchHooks Function()
    >;
typedef $$PlannerTasksTableCreateCompanionBuilder =
    PlannerTasksCompanion Function({
      required String id,
      required DateTime date,
      required String itemType,
      required String itemId,
      Value<bool> isCompleted,
      Value<bool> isReview,
      Value<int> rowid,
    });
typedef $$PlannerTasksTableUpdateCompanionBuilder =
    PlannerTasksCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<String> itemType,
      Value<String> itemId,
      Value<bool> isCompleted,
      Value<bool> isReview,
      Value<int> rowid,
    });

class $$PlannerTasksTableFilterComposer
    extends Composer<_$AppDatabase, $PlannerTasksTable> {
  $$PlannerTasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isReview => $composableBuilder(
    column: $table.isReview,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlannerTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $PlannerTasksTable> {
  $$PlannerTasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isReview => $composableBuilder(
    column: $table.isReview,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlannerTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlannerTasksTable> {
  $$PlannerTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isReview =>
      $composableBuilder(column: $table.isReview, builder: (column) => column);
}

class $$PlannerTasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlannerTasksTable,
          PlannerTask,
          $$PlannerTasksTableFilterComposer,
          $$PlannerTasksTableOrderingComposer,
          $$PlannerTasksTableAnnotationComposer,
          $$PlannerTasksTableCreateCompanionBuilder,
          $$PlannerTasksTableUpdateCompanionBuilder,
          (
            PlannerTask,
            BaseReferences<_$AppDatabase, $PlannerTasksTable, PlannerTask>,
          ),
          PlannerTask,
          PrefetchHooks Function()
        > {
  $$PlannerTasksTableTableManager(_$AppDatabase db, $PlannerTasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlannerTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlannerTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlannerTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> itemType = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<bool> isReview = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlannerTasksCompanion(
                id: id,
                date: date,
                itemType: itemType,
                itemId: itemId,
                isCompleted: isCompleted,
                isReview: isReview,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required String itemType,
                required String itemId,
                Value<bool> isCompleted = const Value.absent(),
                Value<bool> isReview = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlannerTasksCompanion.insert(
                id: id,
                date: date,
                itemType: itemType,
                itemId: itemId,
                isCompleted: isCompleted,
                isReview: isReview,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlannerTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlannerTasksTable,
      PlannerTask,
      $$PlannerTasksTableFilterComposer,
      $$PlannerTasksTableOrderingComposer,
      $$PlannerTasksTableAnnotationComposer,
      $$PlannerTasksTableCreateCompanionBuilder,
      $$PlannerTasksTableUpdateCompanionBuilder,
      (
        PlannerTask,
        BaseReferences<_$AppDatabase, $PlannerTasksTable, PlannerTask>,
      ),
      PlannerTask,
      PrefetchHooks Function()
    >;
typedef $$ReviewItemsTableCreateCompanionBuilder =
    ReviewItemsCompanion Function({
      required String id,
      required String itemType,
      required String itemId,
      Value<int> stage,
      required DateTime nextReviewDate,
      required DateTime lastReviewDate,
      Value<int> rowid,
    });
typedef $$ReviewItemsTableUpdateCompanionBuilder =
    ReviewItemsCompanion Function({
      Value<String> id,
      Value<String> itemType,
      Value<String> itemId,
      Value<int> stage,
      Value<DateTime> nextReviewDate,
      Value<DateTime> lastReviewDate,
      Value<int> rowid,
    });

class $$ReviewItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewItemsTable> {
  $$ReviewItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextReviewDate => $composableBuilder(
    column: $table.nextReviewDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewDate => $composableBuilder(
    column: $table.lastReviewDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReviewItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewItemsTable> {
  $$ReviewItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextReviewDate => $composableBuilder(
    column: $table.nextReviewDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewDate => $composableBuilder(
    column: $table.lastReviewDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReviewItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewItemsTable> {
  $$ReviewItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<int> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<DateTime> get nextReviewDate => $composableBuilder(
    column: $table.nextReviewDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReviewDate => $composableBuilder(
    column: $table.lastReviewDate,
    builder: (column) => column,
  );
}

class $$ReviewItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewItemsTable,
          ReviewItem,
          $$ReviewItemsTableFilterComposer,
          $$ReviewItemsTableOrderingComposer,
          $$ReviewItemsTableAnnotationComposer,
          $$ReviewItemsTableCreateCompanionBuilder,
          $$ReviewItemsTableUpdateCompanionBuilder,
          (
            ReviewItem,
            BaseReferences<_$AppDatabase, $ReviewItemsTable, ReviewItem>,
          ),
          ReviewItem,
          PrefetchHooks Function()
        > {
  $$ReviewItemsTableTableManager(_$AppDatabase db, $ReviewItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> itemType = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<int> stage = const Value.absent(),
                Value<DateTime> nextReviewDate = const Value.absent(),
                Value<DateTime> lastReviewDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewItemsCompanion(
                id: id,
                itemType: itemType,
                itemId: itemId,
                stage: stage,
                nextReviewDate: nextReviewDate,
                lastReviewDate: lastReviewDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String itemType,
                required String itemId,
                Value<int> stage = const Value.absent(),
                required DateTime nextReviewDate,
                required DateTime lastReviewDate,
                Value<int> rowid = const Value.absent(),
              }) => ReviewItemsCompanion.insert(
                id: id,
                itemType: itemType,
                itemId: itemId,
                stage: stage,
                nextReviewDate: nextReviewDate,
                lastReviewDate: lastReviewDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReviewItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewItemsTable,
      ReviewItem,
      $$ReviewItemsTableFilterComposer,
      $$ReviewItemsTableOrderingComposer,
      $$ReviewItemsTableAnnotationComposer,
      $$ReviewItemsTableCreateCompanionBuilder,
      $$ReviewItemsTableUpdateCompanionBuilder,
      (
        ReviewItem,
        BaseReferences<_$AppDatabase, $ReviewItemsTable, ReviewItem>,
      ),
      ReviewItem,
      PrefetchHooks Function()
    >;
typedef $$UserStatsTableCreateCompanionBuilder =
    UserStatsCompanion Function({
      required String id,
      Value<int> xp,
      Value<int> coins,
      Value<int> rowid,
    });
typedef $$UserStatsTableUpdateCompanionBuilder =
    UserStatsCompanion Function({
      Value<String> id,
      Value<int> xp,
      Value<int> coins,
      Value<int> rowid,
    });

class $$UserStatsTableFilterComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<int> get coins =>
      $composableBuilder(column: $table.coins, builder: (column) => column);
}

class $$UserStatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserStatsTable,
          UserStat,
          $$UserStatsTableFilterComposer,
          $$UserStatsTableOrderingComposer,
          $$UserStatsTableAnnotationComposer,
          $$UserStatsTableCreateCompanionBuilder,
          $$UserStatsTableUpdateCompanionBuilder,
          (UserStat, BaseReferences<_$AppDatabase, $UserStatsTable, UserStat>),
          UserStat,
          PrefetchHooks Function()
        > {
  $$UserStatsTableTableManager(_$AppDatabase db, $UserStatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<int> coins = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserStatsCompanion(
                id: id,
                xp: xp,
                coins: coins,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int> xp = const Value.absent(),
                Value<int> coins = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserStatsCompanion.insert(
                id: id,
                xp: xp,
                coins: coins,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserStatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserStatsTable,
      UserStat,
      $$UserStatsTableFilterComposer,
      $$UserStatsTableOrderingComposer,
      $$UserStatsTableAnnotationComposer,
      $$UserStatsTableCreateCompanionBuilder,
      $$UserStatsTableUpdateCompanionBuilder,
      (UserStat, BaseReferences<_$AppDatabase, $UserStatsTable, UserStat>),
      UserStat,
      PrefetchHooks Function()
    >;
typedef $$AchievementsTableCreateCompanionBuilder =
    AchievementsCompanion Function({
      required String id,
      required String title,
      required String description,
      required int xpReward,
      required int coinReward,
      Value<bool> isUnlocked,
      Value<DateTime?> unlockedAt,
      Value<int> rowid,
    });
typedef $$AchievementsTableUpdateCompanionBuilder =
    AchievementsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<int> xpReward,
      Value<int> coinReward,
      Value<bool> isUnlocked,
      Value<DateTime?> unlockedAt,
      Value<int> rowid,
    });

class $$AchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coinReward => $composableBuilder(
    column: $table.coinReward,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coinReward => $composableBuilder(
    column: $table.coinReward,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xpReward =>
      $composableBuilder(column: $table.xpReward, builder: (column) => column);

  GeneratedColumn<int> get coinReward => $composableBuilder(
    column: $table.coinReward,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );
}

class $$AchievementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementsTable,
          Achievement,
          $$AchievementsTableFilterComposer,
          $$AchievementsTableOrderingComposer,
          $$AchievementsTableAnnotationComposer,
          $$AchievementsTableCreateCompanionBuilder,
          $$AchievementsTableUpdateCompanionBuilder,
          (
            Achievement,
            BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>,
          ),
          Achievement,
          PrefetchHooks Function()
        > {
  $$AchievementsTableTableManager(_$AppDatabase db, $AchievementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> xpReward = const Value.absent(),
                Value<int> coinReward = const Value.absent(),
                Value<bool> isUnlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsCompanion(
                id: id,
                title: title,
                description: description,
                xpReward: xpReward,
                coinReward: coinReward,
                isUnlocked: isUnlocked,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String description,
                required int xpReward,
                required int coinReward,
                Value<bool> isUnlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsCompanion.insert(
                id: id,
                title: title,
                description: description,
                xpReward: xpReward,
                coinReward: coinReward,
                isUnlocked: isUnlocked,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AchievementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementsTable,
      Achievement,
      $$AchievementsTableFilterComposer,
      $$AchievementsTableOrderingComposer,
      $$AchievementsTableAnnotationComposer,
      $$AchievementsTableCreateCompanionBuilder,
      $$AchievementsTableUpdateCompanionBuilder,
      (
        Achievement,
        BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>,
      ),
      Achievement,
      PrefetchHooks Function()
    >;
typedef $$WeeklyGoalsTableCreateCompanionBuilder =
    WeeklyGoalsCompanion Function({
      required String id,
      required int targetSeconds,
      Value<int> completedSeconds,
      required int targetItems,
      Value<int> completedItems,
      Value<bool> isClaimed,
      Value<int> rowid,
    });
typedef $$WeeklyGoalsTableUpdateCompanionBuilder =
    WeeklyGoalsCompanion Function({
      Value<String> id,
      Value<int> targetSeconds,
      Value<int> completedSeconds,
      Value<int> targetItems,
      Value<int> completedItems,
      Value<bool> isClaimed,
      Value<int> rowid,
    });

class $$WeeklyGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklyGoalsTable> {
  $$WeeklyGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetSeconds => $composableBuilder(
    column: $table.targetSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedSeconds => $composableBuilder(
    column: $table.completedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetItems => $composableBuilder(
    column: $table.targetItems,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedItems => $composableBuilder(
    column: $table.completedItems,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isClaimed => $composableBuilder(
    column: $table.isClaimed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeeklyGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklyGoalsTable> {
  $$WeeklyGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetSeconds => $composableBuilder(
    column: $table.targetSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedSeconds => $composableBuilder(
    column: $table.completedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetItems => $composableBuilder(
    column: $table.targetItems,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedItems => $composableBuilder(
    column: $table.completedItems,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isClaimed => $composableBuilder(
    column: $table.isClaimed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeeklyGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklyGoalsTable> {
  $$WeeklyGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get targetSeconds => $composableBuilder(
    column: $table.targetSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedSeconds => $composableBuilder(
    column: $table.completedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetItems => $composableBuilder(
    column: $table.targetItems,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedItems => $composableBuilder(
    column: $table.completedItems,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isClaimed =>
      $composableBuilder(column: $table.isClaimed, builder: (column) => column);
}

class $$WeeklyGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeeklyGoalsTable,
          WeeklyGoal,
          $$WeeklyGoalsTableFilterComposer,
          $$WeeklyGoalsTableOrderingComposer,
          $$WeeklyGoalsTableAnnotationComposer,
          $$WeeklyGoalsTableCreateCompanionBuilder,
          $$WeeklyGoalsTableUpdateCompanionBuilder,
          (
            WeeklyGoal,
            BaseReferences<_$AppDatabase, $WeeklyGoalsTable, WeeklyGoal>,
          ),
          WeeklyGoal,
          PrefetchHooks Function()
        > {
  $$WeeklyGoalsTableTableManager(_$AppDatabase db, $WeeklyGoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklyGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklyGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeklyGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> targetSeconds = const Value.absent(),
                Value<int> completedSeconds = const Value.absent(),
                Value<int> targetItems = const Value.absent(),
                Value<int> completedItems = const Value.absent(),
                Value<bool> isClaimed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyGoalsCompanion(
                id: id,
                targetSeconds: targetSeconds,
                completedSeconds: completedSeconds,
                targetItems: targetItems,
                completedItems: completedItems,
                isClaimed: isClaimed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int targetSeconds,
                Value<int> completedSeconds = const Value.absent(),
                required int targetItems,
                Value<int> completedItems = const Value.absent(),
                Value<bool> isClaimed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyGoalsCompanion.insert(
                id: id,
                targetSeconds: targetSeconds,
                completedSeconds: completedSeconds,
                targetItems: targetItems,
                completedItems: completedItems,
                isClaimed: isClaimed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeeklyGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeeklyGoalsTable,
      WeeklyGoal,
      $$WeeklyGoalsTableFilterComposer,
      $$WeeklyGoalsTableOrderingComposer,
      $$WeeklyGoalsTableAnnotationComposer,
      $$WeeklyGoalsTableCreateCompanionBuilder,
      $$WeeklyGoalsTableUpdateCompanionBuilder,
      (
        WeeklyGoal,
        BaseReferences<_$AppDatabase, $WeeklyGoalsTable, WeeklyGoal>,
      ),
      WeeklyGoal,
      PrefetchHooks Function()
    >;
typedef $$ReviewHistoryRecordsTableCreateCompanionBuilder =
    ReviewHistoryRecordsCompanion Function({
      required String id,
      required String itemId,
      required String itemType,
      required DateTime timestamp,
      required String result,
      required int timeTakenSeconds,
      required int prevInterval,
      required int nextInterval,
      Value<int> rowid,
    });
typedef $$ReviewHistoryRecordsTableUpdateCompanionBuilder =
    ReviewHistoryRecordsCompanion Function({
      Value<String> id,
      Value<String> itemId,
      Value<String> itemType,
      Value<DateTime> timestamp,
      Value<String> result,
      Value<int> timeTakenSeconds,
      Value<int> prevInterval,
      Value<int> nextInterval,
      Value<int> rowid,
    });

class $$ReviewHistoryRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewHistoryRecordsTable> {
  $$ReviewHistoryRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeTakenSeconds => $composableBuilder(
    column: $table.timeTakenSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prevInterval => $composableBuilder(
    column: $table.prevInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextInterval => $composableBuilder(
    column: $table.nextInterval,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReviewHistoryRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewHistoryRecordsTable> {
  $$ReviewHistoryRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeTakenSeconds => $composableBuilder(
    column: $table.timeTakenSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prevInterval => $composableBuilder(
    column: $table.prevInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextInterval => $composableBuilder(
    column: $table.nextInterval,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReviewHistoryRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewHistoryRecordsTable> {
  $$ReviewHistoryRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<int> get timeTakenSeconds => $composableBuilder(
    column: $table.timeTakenSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get prevInterval => $composableBuilder(
    column: $table.prevInterval,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextInterval => $composableBuilder(
    column: $table.nextInterval,
    builder: (column) => column,
  );
}

class $$ReviewHistoryRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewHistoryRecordsTable,
          ReviewHistoryRecord,
          $$ReviewHistoryRecordsTableFilterComposer,
          $$ReviewHistoryRecordsTableOrderingComposer,
          $$ReviewHistoryRecordsTableAnnotationComposer,
          $$ReviewHistoryRecordsTableCreateCompanionBuilder,
          $$ReviewHistoryRecordsTableUpdateCompanionBuilder,
          (
            ReviewHistoryRecord,
            BaseReferences<
              _$AppDatabase,
              $ReviewHistoryRecordsTable,
              ReviewHistoryRecord
            >,
          ),
          ReviewHistoryRecord,
          PrefetchHooks Function()
        > {
  $$ReviewHistoryRecordsTableTableManager(
    _$AppDatabase db,
    $ReviewHistoryRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewHistoryRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewHistoryRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ReviewHistoryRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> itemType = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> result = const Value.absent(),
                Value<int> timeTakenSeconds = const Value.absent(),
                Value<int> prevInterval = const Value.absent(),
                Value<int> nextInterval = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewHistoryRecordsCompanion(
                id: id,
                itemId: itemId,
                itemType: itemType,
                timestamp: timestamp,
                result: result,
                timeTakenSeconds: timeTakenSeconds,
                prevInterval: prevInterval,
                nextInterval: nextInterval,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String itemId,
                required String itemType,
                required DateTime timestamp,
                required String result,
                required int timeTakenSeconds,
                required int prevInterval,
                required int nextInterval,
                Value<int> rowid = const Value.absent(),
              }) => ReviewHistoryRecordsCompanion.insert(
                id: id,
                itemId: itemId,
                itemType: itemType,
                timestamp: timestamp,
                result: result,
                timeTakenSeconds: timeTakenSeconds,
                prevInterval: prevInterval,
                nextInterval: nextInterval,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReviewHistoryRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewHistoryRecordsTable,
      ReviewHistoryRecord,
      $$ReviewHistoryRecordsTableFilterComposer,
      $$ReviewHistoryRecordsTableOrderingComposer,
      $$ReviewHistoryRecordsTableAnnotationComposer,
      $$ReviewHistoryRecordsTableCreateCompanionBuilder,
      $$ReviewHistoryRecordsTableUpdateCompanionBuilder,
      (
        ReviewHistoryRecord,
        BaseReferences<
          _$AppDatabase,
          $ReviewHistoryRecordsTable,
          ReviewHistoryRecord
        >,
      ),
      ReviewHistoryRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MasterKanjisTableTableManager get masterKanjis =>
      $$MasterKanjisTableTableManager(_db, _db.masterKanjis);
  $$UserKanjisTableTableManager get userKanjis =>
      $$UserKanjisTableTableManager(_db, _db.userKanjis);
  $$MasterVocabulariesTableTableManager get masterVocabularies =>
      $$MasterVocabulariesTableTableManager(_db, _db.masterVocabularies);
  $$UserVocabulariesTableTableManager get userVocabularies =>
      $$UserVocabulariesTableTableManager(_db, _db.userVocabularies);
  $$MasterGrammarsTableTableManager get masterGrammars =>
      $$MasterGrammarsTableTableManager(_db, _db.masterGrammars);
  $$UserGrammarsTableTableManager get userGrammars =>
      $$UserGrammarsTableTableManager(_db, _db.userGrammars);
  $$MasterReadingsTableTableManager get masterReadings =>
      $$MasterReadingsTableTableManager(_db, _db.masterReadings);
  $$UserReadingsTableTableManager get userReadings =>
      $$UserReadingsTableTableManager(_db, _db.userReadings);
  $$MasterListeningsTableTableManager get masterListenings =>
      $$MasterListeningsTableTableManager(_db, _db.masterListenings);
  $$UserListeningsTableTableManager get userListenings =>
      $$UserListeningsTableTableManager(_db, _db.userListenings);
  $$KanjiVocabsTableTableManager get kanjiVocabs =>
      $$KanjiVocabsTableTableManager(_db, _db.kanjiVocabs);
  $$VocabGrammarsTableTableManager get vocabGrammars =>
      $$VocabGrammarsTableTableManager(_db, _db.vocabGrammars);
  $$GrammarReadingsTableTableManager get grammarReadings =>
      $$GrammarReadingsTableTableManager(_db, _db.grammarReadings);
  $$ReadingListeningsTableTableManager get readingListenings =>
      $$ReadingListeningsTableTableManager(_db, _db.readingListenings);
  $$KanjiReadingsTableTableManager get kanjiReadings =>
      $$KanjiReadingsTableTableManager(_db, _db.kanjiReadings);
  $$VocabReadingsTableTableManager get vocabReadings =>
      $$VocabReadingsTableTableManager(_db, _db.vocabReadings);
  $$StudySessionsTableTableManager get studySessions =>
      $$StudySessionsTableTableManager(_db, _db.studySessions);
  $$DailyGoalsTableTableManager get dailyGoals =>
      $$DailyGoalsTableTableManager(_db, _db.dailyGoals);
  $$QuizResultsTableTableManager get quizResults =>
      $$QuizResultsTableTableManager(_db, _db.quizResults);
  $$StudyPlansTableTableManager get studyPlans =>
      $$StudyPlansTableTableManager(_db, _db.studyPlans);
  $$PlannerTasksTableTableManager get plannerTasks =>
      $$PlannerTasksTableTableManager(_db, _db.plannerTasks);
  $$ReviewItemsTableTableManager get reviewItems =>
      $$ReviewItemsTableTableManager(_db, _db.reviewItems);
  $$UserStatsTableTableManager get userStats =>
      $$UserStatsTableTableManager(_db, _db.userStats);
  $$AchievementsTableTableManager get achievements =>
      $$AchievementsTableTableManager(_db, _db.achievements);
  $$WeeklyGoalsTableTableManager get weeklyGoals =>
      $$WeeklyGoalsTableTableManager(_db, _db.weeklyGoals);
  $$ReviewHistoryRecordsTableTableManager get reviewHistoryRecords =>
      $$ReviewHistoryRecordsTableTableManager(_db, _db.reviewHistoryRecords);
}
