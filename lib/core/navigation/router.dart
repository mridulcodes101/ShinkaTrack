import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/core/navigation/responsive_layout.dart';
import 'package:shinka_track_n3/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/study_screen.dart';
import 'package:shinka_track_n3/features/timer/presentation/screens/timer_screen.dart';
import 'package:shinka_track_n3/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:shinka_track_n3/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:shinka_track_n3/features/settings/presentation/screens/settings_screen.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/planner_setup_screen.dart';

import 'package:shinka_track_n3/features/study/presentation/screens/add_kanji_screen.dart';
import 'package:shinka_track_n3/features/kanji/presentation/screens/master_library_screen.dart';
import 'package:shinka_track_n3/features/kanji/presentation/screens/user_collection_screen.dart';
import 'package:shinka_track_n3/features/kanji/presentation/screens/kanji_details_screen.dart' as new_kanji;
import 'package:shinka_track_n3/features/vocabulary/presentation/screens/master_library_screen.dart' as v_lib;
import 'package:shinka_track_n3/features/vocabulary/presentation/screens/user_collection_screen.dart' as v_coll;
import 'package:shinka_track_n3/features/vocabulary/presentation/screens/vocabulary_details_screen.dart' as v_details;
import 'package:shinka_track_n3/features/grammar/presentation/screens/master_library_screen.dart' as g_lib;
import 'package:shinka_track_n3/features/grammar/presentation/screens/user_collection_screen.dart' as g_coll;
import 'package:shinka_track_n3/features/grammar/presentation/screens/grammar_details_screen.dart' as g_details;
import 'package:shinka_track_n3/features/reading/presentation/screens/master_library_screen.dart' as r_lib;
import 'package:shinka_track_n3/features/reading/presentation/screens/user_collection_screen.dart' as r_coll;
import 'package:shinka_track_n3/features/reading/presentation/screens/reading_details_screen.dart' as r_details;
import 'package:shinka_track_n3/features/reading/presentation/screens/reading_mode_screen.dart' as r_mode;
import 'package:shinka_track_n3/features/listening/presentation/screens/master_library_screen.dart' as l_lib;
import 'package:shinka_track_n3/features/listening/presentation/screens/user_collection_screen.dart' as l_coll;
import 'package:shinka_track_n3/features/listening/presentation/screens/lesson_details_screen.dart' as l_details;
import 'package:shinka_track_n3/features/listening/presentation/screens/listening_player_screen.dart' as l_player;
import 'package:shinka_track_n3/features/study/presentation/screens/admin_dashboard_screen.dart';
import 'package:shinka_track_n3/features/settings/presentation/screens/developer_options_screen.dart';
import 'package:shinka_track_n3/features/review/presentation/screens/review_home_screen.dart' as rev_home;
import 'package:shinka_track_n3/features/review/presentation/screens/review_session_screen.dart' as rev_session;
import 'package:shinka_track_n3/features/review/presentation/screens/session_complete_screen.dart' as rev_complete;
import 'package:shinka_track_n3/features/planner/presentation/screens/planner_dashboard_screen.dart' as p_dash;
import 'package:shinka_track_n3/features/planner/presentation/screens/planner_setup_wizard_screen.dart' as p_wizard;
import 'package:shinka_track_n3/core/search/presentation/screens/search_screen.dart' as search_screen;
import 'package:shinka_track_n3/features/achievements/presentation/screens/achievements_screen.dart' as achievements;
import 'package:shinka_track_n3/features/onboarding/presentation/screens/onboarding_screen.dart' as onboarding;
import 'package:shinka_track_n3/features/onboarding/application/onboarding_notifier.dart';
import 'package:shinka_track_n3/features/study_session/presentation/screens/study_session_screen.dart' as study_session;

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  redirect: (context, state) {
    try {
      final container = ProviderScope.containerOf(context);
      final onboardingCompleted = container.read(onboardingCompletedProvider);
      final onOnboarding = state.uri.path == '/onboarding';

      if (!onboardingCompleted) {
        return '/onboarding';
      }
      if (onOnboarding) {
        return '/';
      }
    } catch (_) {
      // Fail-safe default
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/onboarding',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const onboarding.OnboardingScreen(),
    ),
    GoRoute(
      path: '/study_session',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final type = state.uri.queryParameters['type'] ?? 'guided';
        final modules = state.uri.queryParameters['modules']?.split(',') ?? ['Kanji'];
        return study_session.StudySessionScreen(sessionType: type, modules: modules);
      },
    ),
    GoRoute(
      path: '/settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SettingsScreen(),
    ),
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
        return new_kanji.KanjiDetailsScreen(kanjiId: id);
      },
    ),
    GoRoute(
      path: '/kanji/library',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const MasterLibraryScreen(),
    ),
    GoRoute(
      path: '/kanji/collection',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const UserCollectionScreen(),
    ),
    GoRoute(
      path: '/vocabulary_details',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.uri.queryParameters['id']!;
        return v_details.VocabularyDetailsScreen(vocabId: id);
      },
    ),
    GoRoute(
      path: '/vocabulary/library',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const v_lib.MasterLibraryScreen(),
    ),
    GoRoute(
      path: '/vocabulary/collection',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const v_coll.UserCollectionScreen(),
    ),
    GoRoute(
      path: '/grammar_details',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.uri.queryParameters['id']!;
        return g_details.GrammarDetailsScreen(grammarId: id);
      },
    ),
    GoRoute(
      path: '/grammar/library',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const g_lib.MasterLibraryScreen(),
    ),
    GoRoute(
      path: '/grammar/collection',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const g_coll.UserCollectionScreen(),
    ),
    GoRoute(
      path: '/reading_details',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.uri.queryParameters['id']!;
        return r_details.ReadingDetailsScreen(readingId: id);
      },
    ),
    GoRoute(
      path: '/reading_mode',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.uri.queryParameters['id']!;
        return r_mode.ReadingModeScreen(readingId: id);
      },
    ),
    GoRoute(
      path: '/reading/library',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const r_lib.MasterLibraryScreen(),
    ),
    GoRoute(
      path: '/reading/collection',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const r_coll.UserCollectionScreen(),
    ),
    GoRoute(
      path: '/listening_details',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.uri.queryParameters['id']!;
        return l_details.LessonDetailsScreen(lessonId: id);
      },
    ),
    GoRoute(
      path: '/listening_player',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.uri.queryParameters['id']!;
        return l_player.ListeningPlayerScreen(lessonId: id);
      },
    ),
    GoRoute(
      path: '/listening/library',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const l_lib.MasterLibraryScreen(),
    ),
    GoRoute(
      path: '/listening/collection',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const l_coll.UserCollectionScreen(),
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
          path: '/review',
          builder: (context, state) => const rev_home.ReviewHomeScreen(),
        ),
        GoRoute(
          path: '/review/session',
          builder: (context, state) => const rev_session.ReviewSessionScreen(),
        ),
        GoRoute(
          path: '/review/complete',
          builder: (context, state) => const rev_complete.SessionCompleteScreen(),
        ),
        GoRoute(
          path: '/planner',
          builder: (context, state) => const p_dash.PlannerDashboardScreen(),
        ),
        GoRoute(
          path: '/planner/setup',
          builder: (context, state) => const p_wizard.PlannerSetupWizardScreen(),
        ),
        GoRoute(
          path: '/analytics',
          builder: (context, state) => const AnalyticsScreen(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const search_screen.SearchScreen(),
        ),
        GoRoute(
          path: '/achievements',
          builder: (context, state) => const achievements.AchievementsScreen(),
        ),
      ],
    ),
  ],
);
