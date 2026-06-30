// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/main.dart';

void main() {
  testWidgets('App boot and smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: ShinkaTrackApp(),
      ),
    );

    // Verify that the dashboard header is present
    expect(find.text('Good Morning, Mridul'), findsOneWidget);
  });
}
