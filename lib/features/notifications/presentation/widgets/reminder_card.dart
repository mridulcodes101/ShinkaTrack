import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/notifications/domain/models/notification_rule.dart';
import 'package:shinka_track_n3/features/notifications/application/notifications_notifier.dart';

class ReminderCard extends ConsumerWidget {
  const ReminderCard({super.key});

  IconData _mapIcon(String type) {
    switch (type) {
      case 'study':
        return Icons.menu_book;
      case 'review':
        return Icons.rate_review;
      case 'achievement':
        return Icons.verified;
      case 'planner':
        return Icons.calendar_today;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingAsync = ref.watch(pendingNotificationsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return pendingAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (err, stack) => const SizedBox.shrink(),
      data: (list) {
        if (list.isEmpty) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.withValues(alpha: 0.1),
                    child: const Icon(Icons.notifications_none, color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('All Caught Up!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        SizedBox(height: 4),
                        Text('No pending smart notifications scheduled.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

        final item = list.first;
        final timeStr = DateFormat('jm').format(item.scheduledTime);

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          elevation: 3,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              // Action trigger or dismiss
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.15),
                        foregroundColor: PremiumDesignSystem.primaryBlue,
                        child: Icon(_mapIcon(item.type), size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Scheduled for $timeStr',
                              style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.body,
                    style: TextStyle(fontSize: 13, color: isDark ? Colors.grey[300] : Colors.grey[800], height: 1.4),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
