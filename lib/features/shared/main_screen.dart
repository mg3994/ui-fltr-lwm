import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:linkwithmentor/core/state/app_state.dart';
import 'package:linkwithmentor/features/mentee/home/home_screen.dart';
import 'package:linkwithmentor/features/mentor/dashboard/mentor_dashboard_screen.dart';
import 'package:linkwithmentor/features/shared/chat/chat_list_screen.dart';
import 'package:linkwithmentor/features/shared/profile/profile_screen.dart';
import 'package:linkwithmentor/features/shared/sessions_screen.dart';

class MainScreen extends HookWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    final isMentor = appState.isMentorMode.watch(context);

    final screens = [
      isMentor ? const MentorDashboardScreen() : const HomeScreen(),
      const SessionsScreen(),
      const ChatListScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: screens[selectedIndex.value],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex.value,
        onDestinationSelected: (index) => selectedIndex.value = index,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: isMentor ? 'Dashboard' : 'Discover',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Sessions',
          ),
          NavigationDestination(
            icon: Icon(Icons.message_outlined),
            selectedIcon: Icon(Icons.message),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
