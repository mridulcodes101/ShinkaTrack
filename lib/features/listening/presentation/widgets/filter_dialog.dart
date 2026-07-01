import 'package:flutter/material.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';

class ListeningFilterDialog extends StatefulWidget {
  final List<int> initialJlpt;
  final String? initialDifficulty;
  final String? initialDuration;
  final bool? initialBookmarked;
  final String? initialStatus;

  const ListeningFilterDialog({
    super.key,
    required this.initialJlpt,
    required this.initialDifficulty,
    required this.initialDuration,
    required this.initialBookmarked,
    required this.initialStatus,
  });

  @override
  State<ListeningFilterDialog> createState() => _ListeningFilterDialogState();
}

class _ListeningFilterDialogState extends State<ListeningFilterDialog> {
  late List<int> _selectedJlpt;
  String? _selectedDifficulty;
  String? _selectedDuration;
  bool? _selectedBookmarked;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedJlpt = List.from(widget.initialJlpt);
    _selectedDifficulty = widget.initialDifficulty;
    _selectedDuration = widget.initialDuration;
    _selectedBookmarked = widget.initialBookmarked;
    _selectedStatus = widget.initialStatus;
  }

  void _reset() {
    setState(() {
      _selectedJlpt = [];
      _selectedDifficulty = null;
      _selectedDuration = null;
      _selectedBookmarked = null;
      _selectedStatus = null;
    });
  }

  void _apply() {
    Navigator.pop(context, {
      'jlpt': _selectedJlpt,
      'difficulty': _selectedDifficulty,
      'duration': _selectedDuration,
      'bookmarked': _selectedBookmarked,
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
                    'Filter Lessons',
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
                      // JLPT Level
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

                      // Duration Section
                      _buildSectionTitle('Duration'),
                      Wrap(
                        spacing: 8,
                        children: ['0–2 minutes', '2–5 minutes', '5–10 minutes', '10+ minutes'].map((dur) {
                          final isSelected = _selectedDuration == dur;
                          return ChoiceChip(
                            label: Text(dur),
                            selected: isSelected,
                            onSelected: (val) {
                              setState(() {
                                _selectedDuration = val ? dur : null;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),

                      // Completion Status Section
                      _buildSectionTitle('Completion Status'),
                      Wrap(
                        spacing: 8,
                        children: ['unlearned', 'reading', 'completed'].map((st) {
                          final isSelected = _selectedStatus == st;
                          String label = 'Unread';
                          if (st == 'reading') label = 'In Progress';
                          if (st == 'completed') label = 'Completed';
                          return ChoiceChip(
                            label: Text(label),
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

                      // Bookmarked Toggle
                      _buildSectionTitle('Bookmarks'),
                      ChoiceChip(
                        label: const Text('Bookmarked Only'),
                        selected: _selectedBookmarked == true,
                        onSelected: (val) {
                          setState(() {
                            _selectedBookmarked = val ? true : null;
                          });
                        },
                      ),
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
