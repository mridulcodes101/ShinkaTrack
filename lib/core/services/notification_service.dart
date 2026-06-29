import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static const String _prefStudyHourKey = 'notification_study_hour';
  static const String _prefStudyMinuteKey = 'notification_study_minute';
  static const String _prefMorningEnabledKey = 'notification_morning_enabled';
  static const String _prefStudyEnabledKey = 'notification_study_enabled';
  static const String _prefReviewEnabledKey = 'notification_review_enabled';
  static const String _prefMissedEnabledKey = 'notification_missed_enabled';
  static const String _prefWeeklyEnabledKey = 'notification_weekly_enabled';

  static Future<void> init() async {
    if (kIsWeb) return;

    tz.initializeTimeZones();
    // Default fallback to UTC if local timezone detection is not initialized
    try {
      final String localName = 'Asia/Kolkata'; // Fallback default
      tz.setLocalLocation(tz.getLocation(localName));
    } catch (_) {
      // Fallback
    }

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification click if needed
      },
    );
  }

  static Future<void> requestPermissions() async {
    if (kIsWeb) return;

    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // --- SAVE / LOAD CONFIGS ---

  static Future<void> saveStudyTime(int hour, int minute) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefStudyHourKey, hour);
    await prefs.setInt(_prefStudyMinuteKey, minute);
    await rescheduleAll();
  }

  static Future<Map<String, dynamic>> getConfig() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'studyHour': prefs.getInt(_prefStudyHourKey) ?? 19, // 7 PM default
      'studyMinute': prefs.getInt(_prefStudyMinuteKey) ?? 0,
      'morningEnabled': prefs.getBool(_prefMorningEnabledKey) ?? true,
      'studyEnabled': prefs.getBool(_prefStudyEnabledKey) ?? true,
      'reviewEnabled': prefs.getBool(_prefReviewEnabledKey) ?? true,
      'missedEnabled': prefs.getBool(_prefMissedEnabledKey) ?? true,
      'weeklyEnabled': prefs.getBool(_prefWeeklyEnabledKey) ?? true,
    };
  }

  static Future<void> setToggle(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    String prefKey = '';
    if (key == 'morning') prefKey = _prefMorningEnabledKey;
    if (key == 'study') prefKey = _prefStudyEnabledKey;
    if (key == 'review') prefKey = _prefReviewEnabledKey;
    if (key == 'missed') prefKey = _prefMissedEnabledKey;
    if (key == 'weekly') prefKey = _prefWeeklyEnabledKey;

    if (prefKey.isNotEmpty) {
      await prefs.setBool(prefKey, value);
      await rescheduleAll();
    }
  }

  // --- SCHEDULING LOGIC ---

  static Future<void> rescheduleAll() async {
    if (kIsWeb) return;

    // Clear all previously scheduled notifications
    await _plugin.cancelAll();

    final config = await getConfig();
    final bool morning = config['morningEnabled'] as bool;
    final bool study = config['studyEnabled'] as bool;
    final bool review = config['reviewEnabled'] as bool;
    final bool missed = config['missedEnabled'] as bool;
    final bool weekly = config['weeklyEnabled'] as bool;
    final int studyHour = config['studyHour'] as int;
    final int studyMinute = config['studyMinute'] as int;

    // 1. Morning Reminder (8:00 AM Daily)
    if (morning) {
      await _scheduleDaily(
        id: 100,
        title: '🌅 Good Morning! Ready to learn?',
        body: "Start your morning with a quick N3 lesson. Let's make today count!",
        hour: 8,
        minute: 0,
      );
    }

    // 2. Study Reminder (User Selected Time Daily)
    if (study) {
      await _scheduleDaily(
        id: 101,
        title: '📚 Daily Study Time!',
        body: "It is time for your scheduled N3 study session. Let's hit our daily goals!",
        hour: studyHour,
        minute: studyMinute,
      );
    }

    // 3. Review Reminder (Scheduled for 2 hours from now if review is toggled)
    if (review) {
      await _scheduleOnceInFuture(
        id: 102,
        title: '📝 Spaced Repetition Reviews Due',
        body: 'You have N3 review items waiting for you. Complete them to lock in your memory!',
        delay: const Duration(hours: 2),
      );
    }

    // 4. Missed Day Reminder (Scheduled for 36 hours from now)
    if (missed) {
      await _scheduleOnceInFuture(
        id: 103,
        title: "⚠️ Don't lose your streak!",
        body: 'We missed you yesterday! Spend just 5 minutes today to keep your progress alive.',
        delay: const Duration(hours: 36),
      );
    }

    // 5. Weekly Review Reminder (Scheduled for Sunday at 9:00 AM)
    if (weekly) {
      await _scheduleWeekly(
        id: 104,
        title: '🍀 Sunday Review Day',
        body: "It's Sunday! No new lessons scheduled. Review this week's material now.",
        dayOfWeek: DateTime.sunday,
        hour: 9,
        minute: 0,
      );
    }
  }

  // --- HELPER METHODS FOR LOCAL NOTIFICATION SCHEDULING ---

  static Future<void> _scheduleDaily({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'daily_reminders_channel',
      'Daily Reminders',
      channelDescription: 'Regular daily study and motivation alerts',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> _scheduleWeekly({
    required int id,
    required String title,
    required String body,
    required int dayOfWeek,
    required int hour,
    required int minute,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    // Shift to matching day of the week
    while (scheduledDate.weekday != dayOfWeek) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'weekly_reminders_channel',
      'Weekly Reminders',
      channelDescription: 'Weekly milestone and review day reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  static Future<void> _scheduleOnceInFuture({
    required int id,
    required String title,
    required String body,
    required Duration delay,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime scheduledDate = now.add(delay);

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'timed_reminders_channel',
      'Timed Reminders',
      channelDescription: 'Alerts for pending reviews or missed days',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
