import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FabConfig {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const FabConfig({
    required this.label,
    required this.icon,
    required this.onPressed,
  });
}

final activeFabProvider = StateProvider<FabConfig?>((ref) => null);

class ResponsiveNavigationShell extends ConsumerWidget {
  final Widget child;
  final String location;

  const ResponsiveNavigationShell({
    super.key,
    required this.child,
    required this.location,
  });

  int _locationToTabIndex(String location) {
    if (location.startsWith('/study')) return 1;
    if (location.startsWith('/review')) return 2;
    if (location.startsWith('/planner')) return 3;
    if (location.startsWith('/analytics')) return 4;
    return 0; // default to dashboard / home
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
        context.go('/review');
        break;
      case 3:
        context.go('/planner');
        break;
      case 4:
        context.go('/analytics');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int selectedIndex = _locationToTabIndex(location);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth >= 700;
    final fabConfig = ref.watch(activeFabProvider);

    final destinations = const [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(Icons.menu_book_outlined),
        selectedIcon: Icon(Icons.menu_book_rounded),
        label: 'Learn',
      ),
      NavigationDestination(
        icon: Icon(Icons.psychology_outlined),
        selectedIcon: Icon(Icons.psychology_alt_rounded),
        label: 'Review',
      ),
      NavigationDestination(
        icon: Icon(Icons.calendar_month_outlined),
        selectedIcon: Icon(Icons.calendar_month_rounded),
        label: 'Planner',
      ),
      NavigationDestination(
        icon: Icon(Icons.insights_outlined),
        selectedIcon: Icon(Icons.insights_rounded),
        label: 'Progress',
      ),
    ];

    Widget? buildFab() {
      if (fabConfig == null) return null;
      return FloatingActionButton.extended(
        key: ValueKey(fabConfig.label),
        onPressed: fabConfig.onPressed,
        label: Text(fabConfig.label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        icon: Icon(fabConfig.icon, color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
    }

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
        floatingActionButton: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: buildFab() ?? const SizedBox.shrink(),
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
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: buildFab() ?? const SizedBox.shrink(),
      ),
    );
  }
}
