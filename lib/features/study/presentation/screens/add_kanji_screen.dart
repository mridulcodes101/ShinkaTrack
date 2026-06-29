import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';

class AddKanjiScreen extends ConsumerStatefulWidget {
  final String? editId;
  const AddKanjiScreen({super.key, this.editId});

  @override
  ConsumerState<AddKanjiScreen> createState() => _AddKanjiScreenState();
}

class _AddKanjiScreenState extends ConsumerState<AddKanjiScreen> {
  final _formKey = GlobalKey<FormState>();

  final _kanjiController = TextEditingController();
  final _meaningController = TextEditingController();
  final _onyomiController = TextEditingController();
  final _kunyomiController = TextEditingController();
  final _radicalsController = TextEditingController();
  final _strokeCountController = TextEditingController();
  final _notesController = TextEditingController();
  final _exampleInputController = TextEditingController();

  int _jlptLevel = 3;
  int? _gradeLevel;
  String _unicode = '';
  final List<String> _examples = [];
  File? _selectedImage;

  bool _isDuplicateError = false;
  KanjiEntity? _existingKanji;

  @override
  void initState() {
    super.initState();
    if (widget.editId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final kanjis = ref.read(kanjiListProvider).value ?? [];
        final matched = kanjis.firstWhere((k) => k.id == widget.editId);
        setState(() {
          _existingKanji = matched;
          _kanjiController.text = matched.kanji;
          _meaningController.text = matched.meaning;
          _onyomiController.text = matched.onYomi.join(', ');
          _kunyomiController.text = matched.kunYomi.join(', ');
          _radicalsController.text = matched.radicals == '-' ? '' : matched.radicals;
          _strokeCountController.text = matched.strokeCount.toString();
          _notesController.text = matched.notes;
          _jlptLevel = matched.jlptLevel;
          _gradeLevel = matched.gradeLevel;
          _unicode = matched.unicode == '-' ? '' : matched.unicode;
          _examples.addAll(matched.examples);
          if (matched.strokeOrderDiagramPath != null) {
            _selectedImage = File(matched.strokeOrderDiagramPath!);
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _kanjiController.dispose();
    _meaningController.dispose();
    _onyomiController.dispose();
    _kunyomiController.dispose();
    _radicalsController.dispose();
    _strokeCountController.dispose();
    _notesController.dispose();
    _exampleInputController.dispose();
    super.dispose();
  }

  // Check if form is dirty (has modifications)
  bool _isDirty() {
    if (widget.editId != null && _existingKanji != null) {
      final k = _existingKanji!;
      final radicalsVal = _radicalsController.text.trim().isEmpty ? '-' : _radicalsController.text.trim();
      final unicodeVal = _unicode.isEmpty ? '-' : _unicode;
      final onyomiList = _onyomiController.text.split(RegExp(r'[,、\s]+')).where((s) => s.isNotEmpty).toList();
      final kunyomiList = _kunyomiController.text.split(RegExp(r'[,、\s]+')).where((s) => s.isNotEmpty).toList();

      return _kanjiController.text.trim() != k.kanji ||
          _meaningController.text.trim() != k.meaning ||
          _notesController.text.trim() != k.notes ||
          radicalsVal != k.radicals ||
          _strokeCountController.text.trim() != k.strokeCount.toString() ||
          _jlptLevel != k.jlptLevel ||
          _gradeLevel != k.gradeLevel ||
          unicodeVal != k.unicode ||
          _selectedImage?.path != k.strokeOrderDiagramPath ||
          !_listsEqual(onyomiList, k.onYomi) ||
          !_listsEqual(kunyomiList, k.kunYomi) ||
          !_listsEqual(_examples, k.examples);
    }

    return _kanjiController.text.isNotEmpty ||
        _meaningController.text.isNotEmpty ||
        _onyomiController.text.isNotEmpty ||
        _kunyomiController.text.isNotEmpty ||
        _radicalsController.text.isNotEmpty ||
        _strokeCountController.text.isNotEmpty ||
        _notesController.text.isNotEmpty ||
        _examples.isNotEmpty ||
        _selectedImage != null;
  }

  bool _listsEqual(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  // Confirm discard when backing out
  Future<bool> _onWillPop() async {
    if (_isDirty()) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          return AlertDialog(
            backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Discard Changes?', style: TextStyle(fontWeight: FontWeight.bold)),
            content: const Text('You have unsaved details in your custom Kanji card. Are you sure you want to discard them?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Keep Editing', style: TextStyle(color: PremiumDesignSystem.primaryBlue, fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Discard', style: TextStyle(color: Colors.redAccent)),
              ),
            ],
          );
        },
      );
      return confirm ?? false;
    }
    return true;
  }

  // Image Upload Sheet
  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load image: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Select Diagram Source',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.file_present_outlined),
                title: const Text('Files'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery); // Fallback to system file picker gallery wrapper
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _addExampleWord() {
    final word = _exampleInputController.text.trim();
    if (word.isNotEmpty) {
      if (!_examples.contains(word)) {
        setState(() {
          _examples.add(word);
          _exampleInputController.clear();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Word already added to examples list.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // Validate duplicate against current DB collection
  bool _checkDuplicate(String char) {
    if (widget.editId != null && _existingKanji != null && _existingKanji!.kanji == char) {
      return false;
    }
    final kanjiState = ref.read(kanjiListProvider);
    final kanjis = kanjiState.value ?? [];
    return kanjis.any((k) => k.character == char);
  }

  void _saveKanji() {
    setState(() {
      _isDuplicateError = false;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final char = _kanjiController.text.trim();
      if (_checkDuplicate(char)) {
        setState(() {
          _isDuplicateError = true;
        });
        return;
      }

      final onyomiList = _onyomiController.text.split(RegExp(r'[,、\s]+')).where((s) => s.isNotEmpty).toList();
      final kunyomiList = _kunyomiController.text.split(RegExp(r'[,、\s]+')).where((s) => s.isNotEmpty).toList();

      final newKanji = KanjiEntity(
        id: widget.editId ?? 'custom_kanji_${DateTime.now().millisecondsSinceEpoch}',
        kanji: char,
        kunYomi: kunyomiList,
        onYomi: onyomiList,
        meaning: _meaningController.text.trim(),
        radicals: _radicalsController.text.trim().isEmpty ? '-' : _radicalsController.text.trim(),
        strokeCount: int.parse(_strokeCountController.text.trim()),
        strokeOrderDiagramPath: _selectedImage?.path,
        jlptLevel: _jlptLevel,
        gradeLevel: _gradeLevel,
        unicode: _unicode.isEmpty ? '-' : _unicode,
        notes: _notesController.text.trim(),
        examples: _examples,
        isLearned: _existingKanji?.isLearned ?? false,
        isFavorite: _existingKanji?.isFavorite ?? false,
        createdAt: _existingKanji?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        lastReviewed: _existingKanji?.lastReviewed,
        reviewCount: _existingKanji?.reviewCount ?? 0,
        easeFactor: _existingKanji?.easeFactor ?? 2.5,
        nextReview: _existingKanji?.nextReview,
      );

      ref.read(kanjiListProvider.notifier).addKanji(newKanji);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"$char" saved successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
        appBar: AppBar(
          title: const Text('Add Custom Kanji', style: TextStyle(fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              final shouldPop = await _onWillPop();
              if (shouldPop && context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Card(
                    color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'General Information',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),

                          // Kanji Input Field
                          TextFormField(
                            controller: _kanjiController,
                            maxLength: 3,
                            style: const TextStyle(fontSize: 18),
                            decoration: const InputDecoration(
                              labelText: 'Kanji Character *',
                              hintText: 'e.g. 愛',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.title),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Character is required';
                              }
                              return null;
                            },
                          ),

                          // Animated Duplicate Check Error Label
                          AnimatedSize(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            child: _isDuplicateError
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.error_outline, color: Colors.redAccent, size: 16),
                                        SizedBox(width: 8),
                                        Text(
                                          'This Kanji already exists in your collection!',
                                          style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 12),

                          // Meaning Input Field
                          TextFormField(
                            controller: _meaningController,
                            decoration: const InputDecoration(
                              labelText: 'Meaning *',
                              hintText: 'e.g. Love, affection',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.info_outline),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Meaning is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            'Readings & Metadata',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),

                          // Onyomi
                          TextFormField(
                            controller: _onyomiController,
                            decoration: const InputDecoration(
                              labelText: 'Onyomi',
                              hintText: 'e.g. アイ (comma-separated)',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.translate),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Kunyomi
                          TextFormField(
                            controller: _kunyomiController,
                            decoration: const InputDecoration(
                              labelText: 'Kunyomi',
                              hintText: 'e.g. いと.しい (comma-separated)',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.abc),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Radicals
                          TextFormField(
                            controller: _radicalsController,
                            decoration: const InputDecoration(
                              labelText: 'Radicals',
                              hintText: 'e.g. 心 (heart)',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.category_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Stroke Count
                          TextFormField(
                            controller: _strokeCountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: const InputDecoration(
                              labelText: 'Stroke Count *',
                              hintText: 'e.g. 13',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.edit_road_outlined),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                    return 'Stroke count is required';
                                  }
                                  if (int.tryParse(val.trim()) == null) {
                                    return 'Enter a valid number';
                                  }
                                  return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // JLPT Level Dropdown
                          DropdownButtonFormField<int>(
                            initialValue: 3,
                            decoration: const InputDecoration(
                              labelText: 'JLPT Level',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.school_outlined),
                            ),
                            items: const [
                              DropdownMenuItem(value: 5, child: Text('N5')),
                              DropdownMenuItem(value: 4, child: Text('N4')),
                              DropdownMenuItem(value: 3, child: Text('N3')),
                              DropdownMenuItem(value: 2, child: Text('N2')),
                              DropdownMenuItem(value: 1, child: Text('N1')),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _jlptLevel = val;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 16),

                          // Grade Level Dropdown
                          DropdownButtonFormField<int?>(
                            initialValue: _gradeLevel,
                            decoration: const InputDecoration(
                              labelText: 'Grade Level (optional)',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.auto_awesome_outlined),
                            ),
                            items: const [
                              DropdownMenuItem(value: null, child: Text('None (N/A)')),
                              DropdownMenuItem(value: 1, child: Text('Grade 1')),
                              DropdownMenuItem(value: 2, child: Text('Grade 2')),
                              DropdownMenuItem(value: 3, child: Text('Grade 3')),
                              DropdownMenuItem(value: 4, child: Text('Grade 4')),
                              DropdownMenuItem(value: 5, child: Text('Grade 5')),
                              DropdownMenuItem(value: 6, child: Text('Grade 6')),
                              DropdownMenuItem(value: 7, child: Text('Junior High')),
                            ],
                            onChanged: (val) {
                              setState(() {
                                _gradeLevel = val;
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          // Unicode
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Unicode',
                              hintText: 'e.g. U+611B',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.code_outlined),
                            ),
                            onSaved: (val) => _unicode = val?.trim() ?? '',
                          ),
                          const SizedBox(height: 24),

                          const Text(
                            'Additional Study Data',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),

                          // Notes
                          TextFormField(
                            controller: _notesController,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              labelText: 'Notes',
                              hintText: 'Add your study tricks, mnemonics, or warnings...',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.note_alt_outlined),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Example Words List Builder
                          const Text(
                            'Example Words',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _exampleInputController,
                                  decoration: const InputDecoration(
                                    hintText: 'e.g. 愛情 (Aijou)',
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  onSubmitted: (_) => _addExampleWord(),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton.filled(
                                onPressed: _addExampleWord,
                                icon: const Icon(Icons.add),
                                style: IconButton.styleFrom(
                                  backgroundColor: PremiumDesignSystem.primaryBlue,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Chips view
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            child: _examples.isEmpty
                                ? Text(
                                    'No example words added yet.',
                                    style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline, fontStyle: FontStyle.italic),
                                  )
                                : Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: _examples.map((word) {
                                      return InputChip(
                                        label: Text(word, style: const TextStyle(fontSize: 13)),
                                        onDeleted: () {
                                          setState(() {
                                            _examples.remove(word);
                                          });
                                        },
                                        deleteIconColor: Colors.redAccent,
                                      );
                                    }).toList(),
                                  ),
                          ),
                          const SizedBox(height: 24),

                          const Text(
                            'Stroke Order Diagram',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),

                          // Stroke Order Diagram Image Preview & Button
                          GestureDetector(
                            onTap: _showImagePickerOptions,
                            child: Container(
                              width: double.infinity,
                              height: 180,
                              decoration: BoxDecoration(
                                color: isDark ? Colors.black26 : Colors.grey[100],
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: _selectedImage != null
                                  ? Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(16),
                                          child: Image.file(
                                            _selectedImage!,
                                            width: double.infinity,
                                            height: 180,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.black54,
                                            child: IconButton(
                                              icon: const Icon(Icons.close, color: Colors.white, size: 20),
                                              onPressed: () {
                                                setState(() {
                                                  _selectedImage = null;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add_photo_alternate_outlined, size: 40, color: PremiumDesignSystem.primaryBlue),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Upload Diagram Image',
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Supports Camera, Gallery & Files',
                                          style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Fixed Save Button Bottom Panel
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              decoration: BoxDecoration(
                color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        final shouldPop = await _onWillPop();
                        if (shouldPop && context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveKanji,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PremiumDesignSystem.primaryBlue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Save Kanji',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
