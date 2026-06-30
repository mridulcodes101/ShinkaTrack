import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';

class ExportCenterScreen extends ConsumerStatefulWidget {
  const ExportCenterScreen({super.key});

  @override
  ConsumerState<ExportCenterScreen> createState() => _ExportCenterScreenState();
}

class _ExportCenterScreenState extends ConsumerState<ExportCenterScreen> {
  String _itemType = 'Kanji'; // Kanji, Vocabulary, Grammar, Reading, Listening
  String _format = 'JSON'; // JSON, CSV
  
  bool _filterByStatus = false;
  String _selectedStatus = 'Published'; // Published, Draft, Archived

  bool _filterByJlpt = false;
  int _selectedJlpt = 3;

  String _exportedText = '';

  Future<void> _processExport() async {
    final repo = ref.read(repositoryProvider);
    _exportedText = '';
    
    try {
      List<dynamic> items = [];
      if (_itemType == 'Kanji') items = await repo.getMasterKanjisSpec();
      if (_itemType == 'Vocabulary') items = await repo.getMasterVocabulariesSpec();
      if (_itemType == 'Grammar') items = await repo.getMasterGrammarsSpec();
      if (_itemType == 'Reading') items = await repo.getMasterReadingsSpec();
      if (_itemType == 'Listening') items = await repo.getMasterListeningsSpec();

      // Apply filters
      var filtered = items.where((item) {
        if (_filterByStatus && (item as dynamic).status != _selectedStatus) {
          return false;
        }
        if (_filterByJlpt) {
          final dynamic dynItem = item;
          final int itemJlpt = dynItem.toJson()['jlpt'] ?? dynItem.toJson()['jlptLevel'] ?? 3;
          if (itemJlpt != _selectedJlpt) return false;
        }
        return true;
      }).toList();

      if (filtered.isEmpty) {
        setState(() {
          _exportedText = 'No items found matching the selected filters.';
        });
        return;
      }

      if (_format == 'JSON') {
        final List<Map<String, dynamic>> jsonList = filtered.map((e) => e.toJson() as Map<String, dynamic>).toList();
        setState(() {
          _exportedText = const JsonEncoder.withIndent('  ').convert(jsonList);
        });
      } else {
        // CSV export
        if (filtered.isEmpty) return;
        final headers = filtered.first.toJson().keys.toList() as List<String>;
        final csvBuf = StringBuffer();
        csvBuf.writeln(headers.join(','));
        for (var item in filtered) {
          final row = (item as dynamic).toCsvRow(headers) as List<dynamic>;
          csvBuf.writeln(row.map((val) {
            final str = val.toString().replaceAll('"', '""');
            if (str.contains(',') || str.contains('\n') || str.contains('"')) {
              return '"$str"';
            }
            return str;
          }).join(','));
        }
        setState(() {
          _exportedText = csvBuf.toString();
        });
      }
    } catch (e) {
      setState(() {
        _exportedText = 'Error generating export: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('CMS Export Center', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Export Configuration
            _buildConfigCard(isDark),
            const SizedBox(height: 16),
            
            // Actions
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PremiumDesignSystem.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.cloud_download),
                label: const Text('Generate Export', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: _processExport,
              ),
            ),
            const SizedBox(height: 20),

            // Export Output
            if (_exportedText.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Export Output', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey)),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 18),
                    tooltip: 'Copy to Clipboard',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _exportedText));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied export output to clipboard.')),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 250,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black26 : Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    _exportedText,
                    style: const TextStyle(color: Colors.greenAccent, fontFamily: 'monospace', fontSize: 11, height: 1.4),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildConfigCard(bool isDark) {
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
          children: [
            Row(
              children: [
                const Expanded(child: Text('Item Type', style: TextStyle(fontWeight: FontWeight.bold))),
                DropdownButton<String>(
                  value: _itemType,
                  items: ['Kanji', 'Vocabulary', 'Grammar', 'Reading', 'Listening'].map((t) {
                    return DropdownMenuItem(value: t, child: Text(t));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _itemType = val);
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(child: Text('Format', style: TextStyle(fontWeight: FontWeight.bold))),
                DropdownButton<String>(
                  value: _format,
                  items: ['JSON', 'CSV'].map((f) {
                    return DropdownMenuItem(value: f, child: Text(f));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _format = val);
                  },
                ),
              ],
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Filter by Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              value: _filterByStatus,
              contentPadding: EdgeInsets.zero,
              onChanged: (val) => setState(() => _filterByStatus = val),
            ),
            if (_filterByStatus)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Select Status:  '),
                  DropdownButton<String>(
                    value: _selectedStatus,
                    items: ['Published', 'Draft', 'Archived'].map((s) {
                      return DropdownMenuItem(value: s, child: Text(s));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedStatus = val);
                    },
                  ),
                ],
              ),
            const Divider(),
            SwitchListTile(
              title: const Text('Filter by JLPT Level', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              value: _filterByJlpt,
              contentPadding: EdgeInsets.zero,
              onChanged: (val) => setState(() => _filterByJlpt = val),
            ),
            if (_filterByJlpt)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Select JLPT:  '),
                  DropdownButton<int>(
                    value: _selectedJlpt,
                    items: [5, 4, 3, 2, 1].map((l) {
                      return DropdownMenuItem(value: l, child: Text('N$l'));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedJlpt = val);
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
