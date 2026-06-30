import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/core/content/models/kanji_spec.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/study/domain/repositories/study_repository.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/kanji_manager_screen.dart';

class AddEditKanjiScreen extends ConsumerStatefulWidget {
  final KanjiSpec? initialSpec; // non-null means we are editing
  const AddEditKanjiScreen({super.key, this.initialSpec});

  @override
  ConsumerState<AddEditKanjiScreen> createState() => _AddEditKanjiScreenState();
}

class _AddEditKanjiScreenState extends ConsumerState<AddEditKanjiScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  late TextEditingController _idController;
  late TextEditingController _characterController;
  late TextEditingController _unicodeController;
  late TextEditingController _meaningController;
  late TextEditingController _onyomiController;
  late TextEditingController _kunyomiController;
  late TextEditingController _jlptController;
  late TextEditingController _gradeController;
  late TextEditingController _frequencyController;
  late TextEditingController _strokeCountController;
  late TextEditingController _radicalsController;
  late TextEditingController _exampleWordsController;
  late TextEditingController _exampleSentencesController;
  late TextEditingController _notesController;
  late TextEditingController _tagsController;
  late TextEditingController _audioController;
  late TextEditingController _svgStrokeController;

  String _status = 'Published';

  @override
  void initState() {
    super.initState();
    final spec = widget.initialSpec;
    
    _idController = TextEditingController(text: spec?.id ?? '');
    _characterController = TextEditingController(text: spec?.character ?? '');
    _unicodeController = TextEditingController(text: spec?.unicode ?? '');
    _meaningController = TextEditingController(text: spec?.meaning ?? '');
    _onyomiController = TextEditingController(text: spec?.onyomi.join('; ') ?? '');
    _kunyomiController = TextEditingController(text: spec?.kunyomi.join('; ') ?? '');
    _jlptController = TextEditingController(text: spec?.jlptLevel.toString() ?? '3');
    _gradeController = TextEditingController(text: spec?.gradeLevel.toString() ?? '1');
    _frequencyController = TextEditingController(text: spec?.frequencyRank.toString() ?? '0');
    _strokeCountController = TextEditingController(text: spec?.strokeCount.toString() ?? '1');
    _radicalsController = TextEditingController(text: spec?.radicals ?? '');
    _exampleWordsController = TextEditingController(text: spec?.exampleWords.join('; ') ?? '');
    _exampleSentencesController = TextEditingController(text: spec?.exampleSentences.join('; ') ?? '');
    _notesController = TextEditingController(text: spec?.personalNotes ?? '');
    _tagsController = TextEditingController(text: spec?.tags.join('; ') ?? '');
    _audioController = TextEditingController(text: spec?.audio ?? '');
    _svgStrokeController = TextEditingController(text: spec?.svgStrokeOrder ?? '');

    _status = spec?.status ?? 'Published';
  }

  @override
  void dispose() {
    _idController.dispose();
    _characterController.dispose();
    _unicodeController.dispose();
    _meaningController.dispose();
    _onyomiController.dispose();
    _kunyomiController.dispose();
    _jlptController.dispose();
    _gradeController.dispose();
    _frequencyController.dispose();
    _strokeCountController.dispose();
    _radicalsController.dispose();
    _exampleWordsController.dispose();
    _exampleSentencesController.dispose();
    _notesController.dispose();
    _tagsController.dispose();
    _audioController.dispose();
    _svgStrokeController.dispose();
    super.dispose();
  }

  List<String> _splitBySeparator(String val) {
    if (val.trim().isEmpty) return [];
    return val.split(';').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  }

  KanjiSpec _buildSpecFromForm() {
    return KanjiSpec(
      id: _idController.text.trim().isNotEmpty ? _idController.text.trim() : 'k_${DateTime.now().millisecondsSinceEpoch}',
      character: _characterController.text.trim(),
      unicode: _unicodeController.text.trim(),
      meaning: _meaningController.text.trim(),
      onyomi: _splitBySeparator(_onyomiController.text),
      kunyomi: _splitBySeparator(_kunyomiController.text),
      jlptLevel: int.tryParse(_jlptController.text.trim()) ?? 3,
      gradeLevel: int.tryParse(_gradeController.text.trim()) ?? 1,
      strokeCount: int.tryParse(_strokeCountController.text.trim()) ?? 1,
      radicals: _radicalsController.text.trim(),
      primaryRadical: _radicalsController.text.trim().isNotEmpty ? _radicalsController.text.trim()[0] : '',
      frequencyRank: int.tryParse(_frequencyController.text.trim()) ?? 0,
      joyoStatus: _status,
      exampleWords: _splitBySeparator(_exampleWordsController.text),
      exampleSentences: _splitBySeparator(_exampleSentencesController.text),
      relatedKanji: [],
      tags: _splitBySeparator(_tagsController.text),
      difficulty: 1.0,
      createdAt: widget.initialSpec?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
      status: _status,
      schemaVersion: 1,
      contentVersion: (widget.initialSpec?.contentVersion ?? 0) + 1,
      lastUpdated: DateTime.now(),
      personalNotes: _notesController.text.trim(),
      svgStrokeOrder: _svgStrokeController.text.trim(),
      audio: _audioController.text.trim(),
    );
  }

  Future<void> _validateAndSave() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(repositoryProvider);
    final spec = _buildSpecFromForm();

    // Uniqueness validation checks
    final list = await repo.getMasterKanjisSpec();
    final duplicateChar = list.any((item) => item.character == spec.character && item.id != spec.id);
    final duplicateUnicode = list.any((item) => item.unicode == spec.unicode && item.id != spec.id && spec.unicode.isNotEmpty);

    if (duplicateChar) {
      _showErrorSnackBar('Duplicate Error: Kanji "${spec.character}" already exists in the database.');
      return;
    }
    if (duplicateUnicode) {
      _showErrorSnackBar('Duplicate Error: Unicode "${spec.unicode}" already exists in the database.');
      return;
    }

    if (widget.initialSpec != null) {
      _showEditDiffPreview(spec);
    } else {
      _showCreatePreview(spec);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  void _showCreatePreview(KanjiSpec spec) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm New Kanji'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Character: ${spec.character}', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Meaning: ${spec.meaning}'),
            Text('JLPT: N${spec.jlptLevel}'),
            Text('Strokes: ${spec.strokeCount}'),
            Text('Status: ${spec.status}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(cmsKanjisProvider.notifier).saveKanji(spec);
              Navigator.pop(context); // close Form screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kanji saved successfully.')),
              );
            },
            child: const Text('Confirm Save'),
          ),
        ],
      ),
    );
  }

  void _showEditDiffPreview(KanjiSpec updatedSpec) {
    final old = widget.initialSpec!;
    final List<Widget> diffs = [];

    void addDiff(String label, String oldVal, String newVal) {
      if (oldVal != newVal) {
        diffs.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
              Text('Old: $oldVal', style: const TextStyle(color: Colors.red, fontSize: 13)),
              Text('New: $newVal', style: const TextStyle(color: Colors.green, fontSize: 13)),
              const Divider(),
            ],
          ),
        ));
      }
    }

    addDiff('Kanji Character', old.character, updatedSpec.character);
    addDiff('Meaning', old.meaning, updatedSpec.meaning);
    addDiff('Unicode', old.unicode, updatedSpec.unicode);
    addDiff('JLPT Level', old.jlptLevel.toString(), updatedSpec.jlptLevel.toString());
    addDiff('Strokes', old.strokeCount.toString(), updatedSpec.strokeCount.toString());
    addDiff('Status', old.status, updatedSpec.status);
    addDiff('Onyomi', old.onyomi.join('; '), updatedSpec.onyomi.join('; '));
    addDiff('Kunyomi', old.kunyomi.join('; '), updatedSpec.kunyomi.join('; '));
    addDiff('Examples Words', old.exampleWords.join('; '), updatedSpec.exampleWords.join('; '));

    if (diffs.isEmpty) {
      diffs.add(const Text('No changes detected.'));
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Review Edits / Differences'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: diffs,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(cmsKanjisProvider.notifier).saveKanji(updatedSpec);
              Navigator.pop(context); // close Form screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edits saved successfully.')),
              );
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEditing = widget.initialSpec != null;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Kanji' : 'Add New Kanji', style: const TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionCard(
                title: 'Basic Information',
                children: [
                  TextFormField(
                    controller: _idController,
                    decoration: const InputDecoration(labelText: 'Unique ID (e.g. k501)'),
                    validator: (val) => val == null || val.trim().isEmpty ? 'ID is required' : null,
                    enabled: !isEditing, // cannot edit existing ID
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _characterController,
                          decoration: const InputDecoration(labelText: 'Kanji Character *'),
                          maxLength: 1,
                          validator: (val) => val == null || val.trim().isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _unicodeController,
                          decoration: const InputDecoration(labelText: 'Unicode (e.g. U+66F8)'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _meaningController,
                    decoration: const InputDecoration(labelText: 'Meaning *'),
                    validator: (val) => val == null || val.trim().isEmpty ? 'Meaning is required' : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _jlptController,
                          decoration: const InputDecoration(labelText: 'JLPT Level (1-5) *'),
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            final i = int.tryParse(val ?? '');
                            if (i == null || i < 1 || i > 5) return '1-5 required';
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _strokeCountController,
                          decoration: const InputDecoration(labelText: 'Stroke Count *'),
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            final i = int.tryParse(val ?? '');
                            if (i == null || i < 1) return 'Must be >= 1';
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _gradeController,
                          decoration: const InputDecoration(labelText: 'School Grade'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _frequencyController,
                          decoration: const InputDecoration(labelText: 'Frequency Rank'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _radicalsController,
                    decoration: const InputDecoration(labelText: 'Radicals'),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _status,
                    decoration: const InputDecoration(labelText: 'Status'),
                    items: ['Published', 'Draft', 'Archived'].map((s) {
                      return DropdownMenuItem(value: s, child: Text(s));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _status = val);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSectionCard(
                title: 'Readings (separate multiple with semicolon \';\')',
                children: [
                  TextFormField(
                    controller: _onyomiController,
                    decoration: const InputDecoration(labelText: 'Onyomi (Chinese readings)'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _kunyomiController,
                    decoration: const InputDecoration(labelText: 'Kunyomi (Japanese readings)'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSectionCard(
                title: 'Examples (separate multiple with semicolon \';\')',
                children: [
                  TextFormField(
                    controller: _exampleWordsController,
                    decoration: const InputDecoration(labelText: 'Example Words'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _exampleSentencesController,
                    decoration: const InputDecoration(labelText: 'Example Sentences'),
                    maxLines: 3,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSectionCard(
                title: 'Media & Notes',
                children: [
                  TextFormField(
                    controller: _audioController,
                    decoration: const InputDecoration(labelText: 'Audio Path'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _svgStrokeController,
                    decoration: const InputDecoration(labelText: 'Stroke Order SVG Path'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(labelText: 'Developer/Editorial Notes'),
                    maxLines: 3,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PremiumDesignSystem.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: _validateAndSave,
                  child: const Text('Save Record', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black.withOpacity(0.05)),
      ),
      color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}
