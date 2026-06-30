import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/navigation/responsive_layout.dart';
import 'package:shinka_track_n3/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/study_screen.dart';
import 'package:shinka_track_n3/features/timer/presentation/screens/timer_screen.dart';
import 'package:shinka_track_n3/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:shinka_track_n3/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:shinka_track_n3/features/settings/presentation/screens/settings_screen.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/planner_setup_screen.dart';

import 'package:shinka_track_n3/features/study/presentation/screens/add_kanji_screen.dart';

import 'package:shinka_track_n3/features/study/presentation/screens/kanji_details_screen.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/admin_dashboard_screen.dart';
import 'package:shinka_track_n3/features/settings/presentation/screens/developer_options_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/developer_options',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const DeveloperOptionsScreen(),
    ),
    GoRoute(
      path: '/add_kanji',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final editId = state.uri.queryParameters['id'];
        return AddKanjiScreen(editId: editId);
      },
    ),
    GoRoute(
      path: '/admin',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AdminDashboardScreen(),
    ),
    GoRoute(
      path: '/kanji_details',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.uri.queryParameters['id']!;
        return KanjiDetailsScreen(kanjiId: id);
      },
    ),
    ShellRoute(
      builder: (context, state, child) {
        return ResponsiveNavigationShell(
          location: state.uri.toString(),
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/study',
          builder: (context, state) => const StudyScreen(),
        ),
        GoRoute(
          path: '/timer',
          builder: (context, state) => const TimerScreen(),
        ),
        GoRoute(
          path: '/quiz',
          builder: (context, state) => const QuizScreen(),
        ),
        GoRoute(
          path: '/analytics',
          builder: (context, state) => const AnalyticsScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/planner',
          builder: (context, state) => const PlannerSetupScreen(),
        ),
      ],
    ),
  ],
);
