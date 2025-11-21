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
import 'package:linkwithmentor/features/tools/skill_assessment_screen.dart';
import 'package:linkwithmentor/features/community/forum_screen.dart';
import 'package:linkwithmentor/features/community/study_groups_screen.dart';
import 'package:linkwithmentor/features/community/events_screen.dart';
import 'package:linkwithmentor/features/community/resources_screen.dart';
import 'package:linkwithmentor/features/community/leaderboard_screen.dart';
import 'package:linkwithmentor/features/tools/learning_path_screen.dart';
import 'package:linkwithmentor/features/tools/mentorship_goals_screen.dart';
import 'package:linkwithmentor/features/tools/progress_tracker_screen.dart';
import 'package:linkwithmentor/features/tools/challenges_screen.dart';
import 'package:linkwithmentor/features/community/community_insights_screen.dart';
import 'package:linkwithmentor/features/community/community_polls_screen.dart';
import 'package:linkwithmentor/features/community/mentor_spotlight_screen.dart';
import 'package:linkwithmentor/features/community/networking_events_screen.dart';
import 'package:linkwithmentor/features/community/skill_exchange_screen.dart';
import 'package:linkwithmentor/features/community/success_stories_screen.dart';
import 'package:linkwithmentor/features/community/networking_hub_screen.dart';
import 'package:linkwithmentor/features/tools/project_collaboration_screen.dart';
import 'package:linkwithmentor/features/community/knowledge_base_screen.dart';
import 'package:linkwithmentor/features/community/hackathon_hub_screen.dart';
import 'package:linkwithmentor/features/tools/daily_standup_screen.dart';
import 'package:linkwithmentor/features/community/virtual_office_screen.dart';
import 'package:linkwithmentor/features/community/audio_room_screen.dart';
import 'package:linkwithmentor/features/community/alumni_network_screen.dart';
import 'package:linkwithmentor/features/community/company_page_screen.dart';
import 'package:linkwithmentor/features/community/wellness_hub_screen.dart';
import 'package:linkwithmentor/features/tools/startup_incubator_screen.dart';
import 'package:linkwithmentor/features/shared/settings_screen.dart';
import 'package:linkwithmentor/features/shared/help_support_screen.dart';

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
            _buildDrawerItem(
              context,
              'Skill Assessment',
              Icons.assessment,
              const SkillAssessmentScreen(),
            ),
            _buildDrawerItem(context, 'Goals', Icons.flag, const GoalsScreen()),
            _buildDrawerItem(
              context,
              'Referrals',
              Icons.people_outline,
              const ReferralScreen(),
            ),
            _buildDrawerItem(
              context,
              'Learning Paths',
              Icons.school,
              const LearningPathScreen(),
            ),
            _buildDrawerItem(
              context,
              'Mentorship Goals',
              Icons.track_changes,
              const MentorshipGoalsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Progress Tracker',
              Icons.bar_chart,
              const ProgressTrackerScreen(),
            ),
            _buildDrawerItem(
              context,
              'Project Collaboration',
              Icons.folder_shared,
              const ProjectCollaborationScreen(),
            ),
            _buildDrawerItem(
              context,
              'Daily Standup',
              Icons.today,
              const DailyStandupScreen(),
            ),
            _buildDrawerItem(
              context,
              'Startup Incubator',
              Icons.rocket_launch,
              const StartupIncubatorScreen(),
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
            _buildDrawerItem(
              context,
              'Challenges',
              Icons.sports_score,
              const ChallengesScreen(),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Community',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            _buildDrawerItem(
              context,
              'Q&A Forum',
              Icons.forum,
              const ForumScreen(),
            ),
            _buildDrawerItem(
              context,
              'Study Groups',
              Icons.groups,
              const StudyGroupsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Events',
              Icons.event,
              const EventsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Resources',
              Icons.library_books,
              const ResourcesScreen(),
            ),
            _buildDrawerItem(
              context,
              'Leaderboard',
              Icons.leaderboard,
              const LeaderboardScreen(),
            ),
            _buildDrawerItem(
              context,
              'Community Insights',
              Icons.insights,
              const CommunityInsightsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Polls',
              Icons.poll,
              const CommunityPollsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Mentor Spotlight',
              Icons.star_border,
              const MentorSpotlightScreen(),
            ),
            _buildDrawerItem(
              context,
              'Networking Events',
              Icons.connect_without_contact,
              const NetworkingEventsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Skill Exchange',
              Icons.swap_horiz,
              const SkillExchangeScreen(),
            ),
            _buildDrawerItem(
              context,
              'Success Stories',
              Icons.auto_awesome,
              const SuccessStoriesScreen(),
            ),
            _buildDrawerItem(
              context,
              'Networking Hub',
              Icons.people_alt,
              const NetworkingHubScreen(),
            ),
            _buildDrawerItem(
              context,
              'Knowledge Base',
              Icons.menu_book,
              const KnowledgeBaseScreen(),
            ),
            _buildDrawerItem(
              context,
              'Hackathon Hub',
              Icons.code,
              const HackathonHubScreen(),
            ),
            _buildDrawerItem(
              context,
              'Virtual Office',
              Icons.business,
              const VirtualOfficeScreen(),
            ),
            _buildDrawerItem(
              context,
              'Audio Rooms',
              Icons.mic,
              const AudioRoomScreen(),
            ),
            _buildDrawerItem(
              context,
              'Alumni Network',
              Icons.school,
              const AlumniNetworkScreen(),
            ),
            _buildDrawerItem(
              context,
              'Company Pages',
              Icons.business_center,
              const CompanyPageScreen(),
            ),
            _buildDrawerItem(
              context,
              'Wellness Hub',
              Icons.self_improvement,
              const WellnessHubScreen(),
            ),
            const Divider(),
            _buildDrawerItem(
              context,
              'Settings',
              Icons.settings,
              const SettingsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Help & Support',
              Icons.help_outline,
              const HelpSupportScreen(),
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
