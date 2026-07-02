import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/achievements/domain/models/achievement_model.dart';
import 'package:shinka_track_n3/features/achievements/domain/models/progression_config.dart';
import 'package:shinka_track_n3/features/achievements/application/achievements_notifier.dart';

class AchievementsScreen extends ConsumerStatefulWidget {
  const AchievementsScreen({super.key});

  @override
  ConsumerState<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends ConsumerState<AchievementsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _categories = [
    'all',
    'learning',
    'consistency',
    'review',
    'collection',
    'planner',
    'hidden'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  IconData _mapIcon(String name) {
    switch (name) {
      case 'menu_book':
        return Icons.menu_book;
      case 'translate':
        return Icons.translate;
      case 'g_translate':
        return Icons.g_translate;
      case 'chrome_reader_mode':
        return Icons.chrome_reader_mode;
      case 'audiotrack':
        return Icons.audiotrack;
      case 'trending_up':
        return Icons.trending_up;
      case 'rate_review':
        return Icons.rate_review;
      case 'verified':
        return Icons.verified;
      case 'favorite':
        return Icons.favorite;
      case 'calendar_today':
        return Icons.calendar_today;
      default:
        return Icons.help_outline;
    }
  }

  Color _mapDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Legendary':
        return PremiumDesignSystem.secondaryPink;
      case 'Hard':
        return Colors.orange;
      case 'Medium':
        return PremiumDesignSystem.primaryBlue;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final xpAsync = ref.watch(userXpProvider);
    final listAsync = ref.watch(achievementsListProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Achievements & Progression', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: xpAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => const Center(child: Text('Error loading user progression.')),
        data: (totalXp) {
          final level = ProgressionConfig.calculateLevelFromXp(totalXp);
          final currentLevelXp = ProgressionConfig.xpRequiredForLevel(level);
          final nextLevelXp = ProgressionConfig.xpRequiredForLevel(level + 1);
          final xpProgress = totalXp - currentLevelXp;
          final xpNeeded = nextLevelXp - currentLevelXp;
          final progressPercent = xpNeeded > 0 ? (xpProgress / xpNeeded).clamp(0.0, 1.0) : 1.0;

          return listAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Center(child: Text('Error loading achievements.')),
            data: (achievements) {
              final unlocked = achievements.where((a) => a.isUnlocked).toList();
              final recentUnlocks = List<AchievementModel>.from(unlocked)
                ..sort((a, b) => (b.unlockedAt ?? DateTime.now()).compareTo(a.unlockedAt ?? DateTime.now()));

              final completionPercent = achievements.isNotEmpty 
                  ? (unlocked.length / achievements.length * 100).round()
                  : 0;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Level card representation
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.15),
                                  foregroundColor: PremiumDesignSystem.primaryBlue,
                                  child: Text('Lvl $level', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Progression Rank',
                                        style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Shinka Scholar',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('$totalXp XP Total', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                                Text('${nextLevelXp - totalXp} XP to Next Level', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: progressPercent,
                                minHeight: 8,
                                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                                valueColor: const AlwaysStoppedAnimation(PremiumDesignSystem.primaryBlue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Quick Stats grid
                    Row(
                      children: [
                        _buildStatBox(context, 'Unlocked', '${unlocked.length}/${achievements.length}', Icons.lock_open),
                        const SizedBox(width: 12),
                        _buildStatBox(context, 'Completion', '$completionPercent%', Icons.donut_large),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Recently Unlocked horizontal list
                    if (recentUnlocks.isNotEmpty) ...[
                      const Text(
                        'RECENTLY UNLOCKED',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 96,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: recentUnlocks.length.clamp(0, 5),
                          itemBuilder: (context, index) {
                            final item = recentUnlocks[index];
                            return _buildRecentCard(context, item);
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Categories Tab view
                    TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      indicatorColor: PremiumDesignSystem.primaryBlue,
                      labelColor: isDark ? Colors.white : Colors.black,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      tabs: _categories.map((c) => Tab(text: c.toUpperCase())).toList(),
                    ),
                    const SizedBox(height: 16),

                    // List of matching Achievements
                    AnimatedBuilder(
                      animation: _tabController,
                      builder: (context, child) {
                        final activeCat = _categories[_tabController.index];
                        final filtered = achievements.where((a) {
                          if (activeCat == 'all') return true;
                          return a.category == activeCat;
                        }).toList();

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final item = filtered[index];
                            return _buildAchievementTile(context, item);
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatBox(BuildContext context, String title, String val, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          child: Row(
            children: [
              Icon(icon, color: PremiumDesignSystem.primaryBlue, size: 24),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                  const SizedBox(height: 4),
                  Text(val, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentCard(BuildContext context, AchievementModel item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: const EdgeInsets.only(right: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: PremiumDesignSystem.secondaryPink.withValues(alpha: 0.1),
              foregroundColor: PremiumDesignSystem.secondaryPink,
              child: Icon(_mapIcon(item.icon), size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 4),
                Text(
                  item.unlockedAt != null ? DateFormat('MMM dd').format(item.unlockedAt!) : 'Unlocked',
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementTile(BuildContext context, AchievementModel item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLockedHidden = item.hidden && !item.isUnlocked;

    final titleStr = isLockedHidden ? '???' : item.title;
    final descStr = isLockedHidden ? 'Unlock this hidden milestone to reveal requirements.' : item.description;
    final iconData = isLockedHidden ? Icons.help_outline : _mapIcon(item.icon);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      elevation: item.isUnlocked ? 2 : 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: item.isUnlocked 
                      ? PremiumDesignSystem.primaryBlue.withValues(alpha: 0.15)
                      : Colors.grey.withValues(alpha: 0.1),
                  foregroundColor: item.isUnlocked 
                      ? PremiumDesignSystem.primaryBlue
                      : Colors.grey,
                  child: Icon(iconData, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(titleStr, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _mapDifficultyColor(item.difficulty).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item.difficulty,
                              style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: _mapDifficultyColor(item.difficulty)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(descStr, style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.3)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '+${item.xpReward} XP Reward',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: PremiumDesignSystem.primaryBlue),
                ),
                Text(
                  '${item.progress}/${item.target}',
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: item.target > 0 ? (item.progress / item.target).clamp(0.0, 1.0) : 0.0,
                minHeight: 4,
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(item.isUnlocked ? PremiumDesignSystem.primaryBlue : Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
