import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/core/navigation/router.dart';
import 'package:shinka_track_n3/core/design/app_theme.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinka_track_n3/core/services/admin_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await NotificationService.init();
  //await NotificationService.rescheduleAll();

  final prefs = await SharedPreferences.getInstance();
  final int themeIdx = prefs.getInt('theme_mode') ?? 0;
  final ThemeMode initialThemeMode = ThemeMode.values[themeIdx];
  final String initialThemeColor = prefs.getString('theme_color') ?? 'indigo';
  final double initialFontSize = prefs.getDouble('font_size_scale') ?? 1.0;

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        themeModeProvider.overrideWith((ref) => initialThemeMode),
        themeColorProvider.overrideWith((ref) => initialThemeColor),
        fontSizeProvider.overrideWith((ref) => initialFontSize),
      ],
      child: const ShinkaTrackApp(),
    ),
  );
}

class ShinkaTrackApp extends ConsumerWidget {
  const ShinkaTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = goRouter;
    final themeMode = ref.watch(themeModeProvider);
    final themeColor = ref.watch(themeColorProvider);
    final fontSize = ref.watch(fontSizeProvider);

    return MaterialApp.router(
      title: 'ShinkaTrack N3',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.lightTheme(themeColor),
      darkTheme: AppTheme.darkTheme(themeColor),
      routerConfig: router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(fontSize),
          ),
          child: child!,
        );
      },
    );
  }
}
