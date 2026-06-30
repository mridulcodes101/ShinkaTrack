import 'package:flutter/material.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';

class FilterDialog extends StatefulWidget {
  final List<int> initialJlpt;
  final List<int> initialGrade;
  final String? initialStrokeBucket;
  final bool? initialIsAdded;
  final bool isUserCollection; // true hides master collection filters

  const FilterDialog({
    super.key,
    required this.initialJlpt,
    required this.initialGrade,
    required this.initialStrokeBucket,
    required this.initialIsAdded,
    this.isUserCollection = false,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late List<int> _selectedJlpt;
  late List<int> _selectedGrade;
  String? _selectedStrokeBucket;
  bool? _selectedIsAdded;

  @override
  void initState() {
    super.initState();
    _selectedJlpt = List.from(widget.initialJlpt);
    _selectedGrade = List.from(widget.initialGrade);
    _selectedStrokeBucket = widget.initialStrokeBucket;
    _selectedIsAdded = widget.initialIsAdded;
  }

  void _reset() {
    setState(() {
      _selectedJlpt = [];
      _selectedGrade = [];
      _selectedStrokeBucket = null;
      _selectedIsAdded = null;
    });
  }

  void _apply() {
    Navigator.pop(context, {
      'jlpt': _selectedJlpt,
      'grade': _selectedGrade,
      'strokeBucket': _selectedStrokeBucket,
      'isAdded': _selectedIsAdded,
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
                    'Filter Kanji',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: _reset,
                    child: const Text('Reset All'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Scrollable Filter Sections
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

                      // Grade Level Section
                      _buildSectionTitle('School Grade'),
                      Wrap(
                        spacing: 8,
                        children: [1, 2, 3, 4, 5, 6].map((grd) {
                          final isSelected = _selectedGrade.contains(grd);
                          return FilterChip(
                            label: Text('Grade $grd'),
                            selected: isSelected,
                            selectedColor: PremiumDesignSystem.secondaryPink.withValues(alpha: 0.15),
                            checkmarkColor: PremiumDesignSystem.secondaryPink,
                            onSelected: (val) {
                              setState(() {
                                if (val) {
                                  _selectedGrade.add(grd);
                                } else {
                                  _selectedGrade.remove(grd);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),

                      // Stroke Count Section
                      _buildSectionTitle('Stroke Count'),
                      Wrap(
                        spacing: 8,
                        children: ['1-5', '6-10', '11-15', '16+'].map((bucket) {
                          final isSelected = _selectedStrokeBucket == bucket;
                          return ChoiceChip(
                            label: Text(bucket),
                            selected: isSelected,
                            selectedColor: PremiumDesignSystem.forestEmerald.withValues(alpha: 0.15),
                            onSelected: (val) {
                              setState(() {
                                _selectedStrokeBucket = val ? bucket : null;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),

                      // Status Section (Only for Master Library)
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Action Buttons
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
