import 'package:flutter/material.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';

class GrammarFilterDialog extends StatefulWidget {
  final List<int> initialJlpt;
  final String? initialDifficulty;
  final bool? initialIsAdded;
  final String? initialStatus;
  final bool isUserCollection;

  const GrammarFilterDialog({
    super.key,
    required this.initialJlpt,
    required this.initialDifficulty,
    required this.initialIsAdded,
    required this.initialStatus,
    this.isUserCollection = false,
  });

  @override
  State<GrammarFilterDialog> createState() => _GrammarFilterDialogState();
}

class _GrammarFilterDialogState extends State<GrammarFilterDialog> {
  late List<int> _selectedJlpt;
  String? _selectedDifficulty;
  bool? _selectedIsAdded;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedJlpt = List.from(widget.initialJlpt);
    _selectedDifficulty = widget.initialDifficulty;
    _selectedIsAdded = widget.initialIsAdded;
    _selectedStatus = widget.initialStatus;
  }

  void _reset() {
    setState(() {
      _selectedJlpt = [];
      _selectedDifficulty = null;
      _selectedIsAdded = null;
      _selectedStatus = null;
    });
  }

  void _apply() {
    Navigator.pop(context, {
      'jlpt': _selectedJlpt,
      'difficulty': _selectedDifficulty,
      'isAdded': _selectedIsAdded,
      'status': _selectedStatus,
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter Grammar',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: _reset,
                    child: const Text('Reset All'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Scrollable filter conditions
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // JLPT Level Section
                      _buildSectionTitle('JLPT Level'),
                      Wrap(
                        spacing: 8,
                        children: [5, 4, 3, 2, 1].map((lvl) {
                          final isSelected = _selectedJlpt.contains(lvl);
                          return FilterChip(
                            label: Text('N$lvl'),
                            selected: isSelected,
                            selectedColor: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.15),
                            checkmarkColor: PremiumDesignSystem.primaryBlue,
                            onSelected: (val) {
                              setState(() {
                                if (val) {
                                  _selectedJlpt.add(lvl);
                                } else {
                                  _selectedJlpt.remove(lvl);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),

                      // Difficulty Section
                      _buildSectionTitle('Difficulty'),
                      Wrap(
                        spacing: 8,
                        children: ['Easy', 'Medium', 'Hard'].map((diff) {
                          final isSelected = _selectedDifficulty == diff;
                          return ChoiceChip(
                            label: Text(diff),
                            selected: isSelected,
                            selectedColor: PremiumDesignSystem.secondaryPink.withValues(alpha: 0.15),
                            onSelected: (val) {
                              setState(() {
                                _selectedDifficulty = val ? diff : null;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),

                      // Collection status (Master Library only)
                      if (!widget.isUserCollection) ...[
                        _buildSectionTitle('Collection Status'),
                        Wrap(
                          spacing: 8,
                          children: [
                            ChoiceChip(
                              label: const Text('Added'),
                              selected: _selectedIsAdded == true,
                              onSelected: (val) {
                                setState(() {
                                  _selectedIsAdded = val ? true : null;
                                });
                              },
                            ),
                            ChoiceChip(
                              label: const Text('Not Added'),
                              selected: _selectedIsAdded == false,
                              onSelected: (val) {
                                setState(() {
                                  _selectedIsAdded = val ? false : null;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Study status (User Collection only)
                      if (widget.isUserCollection) ...[
                        _buildSectionTitle('Study Progress Status'),
                        Wrap(
                          spacing: 8,
                          children: ['unlearned', 'learning', 'mastered'].map((st) {
                            final isSelected = _selectedStatus == st;
                            return ChoiceChip(
                              label: Text(st.toUpperCase()),
                              selected: isSelected,
                              onSelected: (val) {
                                setState(() {
                                  _selectedStatus = val ? st : null;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PremiumDesignSystem.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _apply,
                      child: const Text('Apply Filters', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
      ),
    );
  }
}
