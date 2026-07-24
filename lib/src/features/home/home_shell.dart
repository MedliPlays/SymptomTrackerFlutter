import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/providers.dart';
import '../charts/charts_screen.dart';
import '../onboarding/onboarding_screen.dart';
import '../settings/settings_screen.dart';
import '../symptoms/symptoms_screen.dart';
import '../symptoms/today_screen.dart';
import '../types/types_screen.dart';

/// Root scaffold with the five primary destinations.
class HomeShell extends HookConsumerWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // START_TAB is a compile-time testing hook; defaults to Today (0).
    final index = useState(const int.fromEnvironment('START_TAB'));
    final shown = useRef(false);

    // On first launch (onboarding not completed), present it once.
    final completed = ref.watch(onboardingCompletedProvider);
    useEffect(() {
      if (!shown.value && completed.asData?.value == false) {
        shown.value = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) openOnboarding(context, autoLaunched: true);
        });
      }
      return null;
    }, [completed]);

    const pages = [
      TodayScreen(),
      SymptomsScreen(),
      ChartsScreen(),
      TypesScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: index.value, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index.value,
        onDestinationSelected: (i) => index.value = i,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.today_outlined),
              selectedIcon: Icon(Icons.today),
              label: 'Today'),
          NavigationDestination(
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              label: 'Symptoms'),
          NavigationDestination(
              icon: Icon(Icons.insights_outlined),
              selectedIcon: Icon(Icons.insights),
              label: 'Charts'),
          NavigationDestination(
              icon: Icon(Icons.bolt_outlined),
              selectedIcon: Icon(Icons.bolt),
              label: 'Types'),
          NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Settings'),
        ],
      ),
    );
  }
}
