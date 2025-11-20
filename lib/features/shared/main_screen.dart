import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:linkwithmentor/core/state/app_state.dart';
import 'package:linkwithmentor/features/mentee/home/home_screen.dart';
import 'package:linkwithmentor/features/mentor/dashboard/mentor_dashboard_screen.dart';
import 'package:linkwithmentor/features/shared/chat/chat_list_screen.dart';
import 'package:linkwithmentor/features/shared/profile/profile_screen.dart';
import 'package:linkwithmentor/features/shared/sessions_screen.dart';
import 'package:linkwithmentor/features/notifications/notifications_screen.dart';
import 'package:linkwithmentor/features/shared/search_screen.dart';
import 'package:linkwithmentor/features/community/create_post_screen.dart';
import 'package:linkwithmentor/features/tools/career_path_screen.dart';
import 'package:linkwithmentor/features/tools/certifications_screen.dart';
import 'package:linkwithmentor/features/tools/goals_screen.dart';
import 'package:linkwithmentor/features/tools/interview_prep_screen.dart';
import 'package:linkwithmentor/features/tools/job_board_screen.dart';
import 'package:linkwithmentor/features/tools/referral_screen.dart';
import 'package:linkwithmentor/features/tools/resume_builder_screen.dart';
import 'package:linkwithmentor/features/tools/portfolio_builder_screen.dart';
import 'package:linkwithmentor/features/tools/badges_screen.dart';
import 'package:linkwithmentor/features/tools/streaks_screen.dart';
import 'package:linkwithmentor/features/tools/achievements_screen.dart';

class MainScreen extends HookWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    final isMentor = appState.isMentorMode.watch(context);

    // Main bottom nav screens
    final screens = [
      isMentor ? const MentorDashboardScreen() : const HomeScreen(),
      const SessionsScreen(),
      const ChatListScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(isMentor ? 'Mentor Dashboard' : 'LinkWithMentor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: const Badge(
              label: Text('3'),
              child: Icon(Icons.notifications_outlined),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Manish'),
              accountEmail: const Text('manish@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  'M',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_box_outlined),
              title: const Text('Create Post'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreatePostScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Tools & Resources',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            _buildDrawerItem(
              context,
              'Career Path',
              Icons.timeline,
              const CareerPathScreen(),
            ),
            _buildDrawerItem(
              context,
              'Resume Builder',
              Icons.description,
              const ResumeBuilderScreen(),
            ),
            _buildDrawerItem(
              context,
              'Portfolio Builder',
              Icons.folder_special,
              const PortfolioBuilderScreen(),
            ),
            _buildDrawerItem(
              context,
              'Interview Prep',
              Icons.question_answer,
              const InterviewPrepScreen(),
            ),
            _buildDrawerItem(
              context,
              'Job Board',
              Icons.work,
              const JobBoardScreen(),
            ),
            _buildDrawerItem(
              context,
              'Certifications',
              Icons.workspace_premium,
              const CertificationsScreen(),
            ),
            _buildDrawerItem(context, 'Goals', Icons.flag, const GoalsScreen()),
            _buildDrawerItem(
              context,
              'Referrals',
              Icons.people_outline,
              const ReferralScreen(),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Gamification',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            _buildDrawerItem(
              context,
              'Badges',
              Icons.military_tech,
              const BadgesScreen(),
            ),
            _buildDrawerItem(
              context,
              'Streaks',
              Icons.local_fire_department,
              const StreaksScreen(),
            ),
            _buildDrawerItem(
              context,
              'Achievements',
              Icons.emoji_events,
              const AchievementsScreen(),
            ),
          ],
        ),
      ),
      body: screens[selectedIndex.value],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex.value,
        onDestinationSelected: (index) => selectedIndex.value = index,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: isMentor ? 'Dashboard' : 'Home',
          ),
          const NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Sessions',
          ),
          const NavigationDestination(
            icon: Icon(Icons.message_outlined),
            selectedIcon: Icon(Icons.message),
            label: 'Messages',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}
