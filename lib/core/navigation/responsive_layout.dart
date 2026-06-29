import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResponsiveNavigationShell extends StatelessWidget {
  final Widget child;
  final String location;

  const ResponsiveNavigationShell({
    super.key,
    required this.child,
    required this.location,
  });

  int _locationToTabIndex(String location) {
    if (location.startsWith('/study')) return 1;
    if (location.startsWith('/timer')) return 2;
    if (location.startsWith('/quiz')) return 3;
    if (location.startsWith('/analytics')) return 4;
    if (location.startsWith('/settings')) return 5;
    return 0; // default to dashboard
  }

  void _onTabSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/study');
        break;
      case 2:
        context.go('/timer');
        break;
      case 3:
        context.go('/quiz');
        break;
      case 4:
        context.go('/analytics');
        break;
      case 5:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _locationToTabIndex(location);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth >= 700;

    final destinations = const [
      NavigationDestination(
        icon: Icon(Icons.dashboard_outlined),
        selectedIcon: Icon(Icons.dashboard),
        label: 'Dashboard',
      ),
      NavigationDestination(
        icon: Icon(Icons.menu_book_outlined),
        selectedIcon: Icon(Icons.menu_book),
        label: 'Study',
      ),
      NavigationDestination(
        icon: Icon(Icons.timer_outlined),
        selectedIcon: Icon(Icons.timer),
        label: 'Timer',
      ),
      NavigationDestination(
        icon: Icon(Icons.psychology_outlined),
        selectedIcon: Icon(Icons.psychology),
        label: 'Quiz',
      ),
      NavigationDestination(
        icon: Icon(Icons.analytics_outlined),
        selectedIcon: Icon(Icons.analytics),
        label: 'Progress',
      ),
      NavigationDestination(
        icon: Icon(Icons.settings_outlined),
        selectedIcon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ];

    if (isWideScreen) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: (idx) => _onTabSelected(context, idx),
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  child: const Text('進化', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              destinations: destinations
                  .map((d) => NavigationRailDestination(
                        icon: d.icon,
                        selectedIcon: d.selectedIcon,
                        label: Text(d.label),
                      ))
                  .toList(),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: ClipRect(
                child: child,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (idx) => _onTabSelected(context, idx),
        destinations: destinations,
      ),
    );
  }
}
