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

import 'package:linkwithmentor/features/tools/goals_screen.dart';
import 'package:linkwithmentor/features/tools/interview_prep_screen.dart';

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
import 'package:linkwithmentor/features/tools/project_collaboration_screen.dart';
import 'package:linkwithmentor/features/community/networking_hub_screen.dart';
import 'package:linkwithmentor/features/community/virtual_office_screen.dart';
import 'package:linkwithmentor/features/community/audio_room_screen.dart';
import 'package:linkwithmentor/features/shared/settings_screen.dart';
import 'package:linkwithmentor/features/shared/help_support_screen.dart';
import 'package:linkwithmentor/features/gamification/rewards_screen.dart';
import 'package:linkwithmentor/features/gamification/challenges_screen.dart'
    as gamification;
import 'package:linkwithmentor/features/community/mentor_matching_screen.dart';
import 'package:linkwithmentor/features/tools/reflection_journal_screen.dart';
import 'package:linkwithmentor/features/community/virtual_coffee_screen.dart';
import 'package:linkwithmentor/features/tools/code_review_screen.dart';
import 'package:linkwithmentor/features/community/peer_learning_screen.dart';
import 'package:linkwithmentor/features/tools/startup_incubator_screen.dart';
import 'package:linkwithmentor/features/tools/daily_standup_screen.dart';
import 'package:linkwithmentor/features/tools/analytics_dashboard_screen.dart';
import 'package:linkwithmentor/features/community/hackathon_hub_screen.dart';
import 'package:linkwithmentor/features/community/skill_exchange_screen.dart';
import 'package:linkwithmentor/features/community/community_insights_screen.dart';
import 'package:linkwithmentor/features/community/community_polls_screen.dart';
import 'package:linkwithmentor/features/community/mentor_spotlight_screen.dart';
import 'package:linkwithmentor/features/community/alumni_network_screen.dart';
import 'package:linkwithmentor/features/community/company_page_screen.dart';
import 'package:linkwithmentor/features/community/networking_events_screen.dart';
import 'package:linkwithmentor/features/community/success_stories_screen.dart';
import 'package:linkwithmentor/features/community/knowledge_base_screen.dart';
import 'package:linkwithmentor/features/tools/mock_interview_screen.dart';
import 'package:linkwithmentor/features/tools/salary_negotiation_screen.dart';
import 'package:linkwithmentor/features/tools/career_roadmap_screen.dart';
import 'package:linkwithmentor/features/tools/skill_gap_analyzer_screen.dart';
import 'package:linkwithmentor/features/tools/certificates_screen.dart';
import 'package:linkwithmentor/features/tools/referral_screen.dart';
import 'package:linkwithmentor/features/tools/milestones_screen.dart';
import 'package:linkwithmentor/features/tools/progress_tracker_screen.dart';
import 'package:linkwithmentor/features/tools/stats_screen.dart';
import 'package:linkwithmentor/features/tools/premium_insights_screen.dart';
import 'package:linkwithmentor/features/tools/growth_dashboard_screen.dart';
import 'package:linkwithmentor/features/tools/career_insights_screen.dart';
import 'package:linkwithmentor/features/tools/ai_mentor_match_screen.dart';
import 'package:linkwithmentor/features/tools/learning_analytics_screen.dart';
import 'package:linkwithmentor/features/tools/skill_marketplace_screen.dart';
import 'package:linkwithmentor/features/tools/live_coding_sessions_screen.dart';
import 'package:linkwithmentor/features/tools/career_roadmap_visualizer_screen.dart';
import 'package:linkwithmentor/features/tools/mentorship_matching_algorithm_screen.dart';
import 'package:linkwithmentor/features/tools/knowledge_base_resources_screen.dart';
import 'package:linkwithmentor/features/tools/peer_feedback_review_screen.dart';
import 'package:linkwithmentor/features/tools/time_tracking_productivity_screen.dart';
import 'package:linkwithmentor/features/tools/one_on_one_sessions_screen.dart';
import 'package:linkwithmentor/features/tools/skill_endorsements_screen.dart';
import 'package:linkwithmentor/features/tools/mentorship_goals_milestones_screen.dart';
import 'package:linkwithmentor/features/tools/networking_events_workshops_screen.dart';
import 'package:linkwithmentor/features/tools/salary_negotiation_screen.dart';
import 'package:linkwithmentor/features/tools/skill_gap_analyzer_screen.dart';
import 'package:linkwithmentor/features/tools/skill_exchange_screen.dart'
    as tools;

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
                'Tools & Growth',
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
              const SkillAssessmentScreen(),
            ),
            _buildDrawerItem(context, 'Goals', Icons.flag, const GoalsScreen()),
            _buildDrawerItem(
              context,
              'Learning Paths',
              Icons.school,
              const LearningPathScreen(),
            ),
            _buildDrawerItem(
              context,
              'Project Collaboration',
              Icons.folder_shared,
              const ProjectCollaborationScreen(),
            ),
            _buildDrawerItem(
              context,
              'Reflection Journal',
              Icons.book,
              const ReflectionJournalScreen(),
            ),
            _buildDrawerItem(
              context,
              'Code Review',
              Icons.rate_review,
              const CodeReviewScreen(),
            ),
            _buildDrawerItem(
              context,
              'Startup Incubator',
              Icons.lightbulb_outline,
              const StartupIncubatorScreen(),
            ),
            _buildDrawerItem(
              context,
              'Daily Standup',
              Icons.history,
              const DailyStandupScreen(),
            ),
            _buildDrawerItem(
              context,
              'Analytics',
              Icons.analytics,
              const AnalyticsDashboardScreen(),
            ),
            _buildDrawerItem(
              context,
              'Mock Interviews',
              Icons.videocam_outlined,
              const MockInterviewScreen(),
            ),
            _buildDrawerItem(
              context,
              'Salary Negotiation',
              Icons.monetization_on_outlined,
              const SalaryNegotiationScreen(),
            ),
            _buildDrawerItem(
              context,
              'Career Roadmap',
              Icons.map_outlined,
              const CareerRoadmapScreen(),
            ),
            _buildDrawerItem(
              context,
              'Skill Gap Analyzer',
              Icons.difference_outlined,
              const SkillGapAnalyzerScreen(),
            ),
            _buildDrawerItem(
              context,
              'Certificates',
              Icons.workspace_premium_outlined,
              const CertificatesScreen(),
            ),
            _buildDrawerItem(
              context,
              'Referral Program',
              Icons.person_add_alt_1_outlined,
              const ReferralScreen(),
            ),
            _buildDrawerItem(
              context,
              'Milestones',
              Icons.flag_outlined,
              const MilestonesScreen(),
            ),
            _buildDrawerItem(
              context,
              'Progress Tracker',
              Icons.bar_chart_outlined,
              const ProgressTrackerScreen(),
            ),
            _buildDrawerItem(
              context,
              'Stats',
              Icons.query_stats,
              const StatsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Premium Insights',
              Icons.insights,
              const PremiumInsightsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Growth Dashboard',
              Icons.trending_up,
              const GrowthDashboardScreen(),
            ),
            _buildDrawerItem(
              context,
              'Career Insights',
              Icons.psychology,
              const CareerInsightsScreen(),
            ),
            _buildDrawerItem(
              context,
              'AI Mentor Match',
              Icons.people_alt,
              const AiMentorMatchScreen(),
            ),
            _buildDrawerItem(
              context,
              'Learning Analytics',
              Icons.analytics,
              const LearningAnalyticsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Skill Marketplace',
              Icons.storefront,
              const SkillMarketplaceScreen(),
            ),
            _buildDrawerItem(
              context,
              'Live Coding Sessions',
              Icons.live_tv,
              const LiveCodingSessionsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Career Roadmap',
              Icons.route,
              const CareerRoadmapVisualizerScreen(),
            ),
            _buildDrawerItem(
              context,
              'Matching Algorithm',
              Icons.psychology,
              const MentorshipMatchingAlgorithmScreen(),
            ),
            _buildDrawerItem(
              context,
              'Knowledge Base',
              Icons.library_books,
              const KnowledgeBaseResourcesScreen(),
            ),
            _buildDrawerItem(
              context,
              'Peer Feedback',
              Icons.rate_review,
              const PeerFeedbackReviewScreen(),
            ),
            _buildDrawerItem(
              context,
              'Time Tracking',
              Icons.timer,
              const TimeTrackingProductivityScreen(),
            ),
            _buildDrawerItem(
              context,
              '1-on-1 Sessions',
              Icons.video_call,
              const OneOnOneSessionsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Skill Endorsements',
              Icons.verified,
              const SkillEndorsementsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Goals & Milestones',
              Icons.flag,
              const MentorshipGoalsMilestonesScreen(),
            ),
            _buildDrawerItem(
              context,
              'Events & Workshops',
              Icons.event,
              const NetworkingEventsWorkshopsScreen(),
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
              'Virtual Coffee',
              Icons.coffee,
              const VirtualCoffeeScreen(),
            ),
            _buildDrawerItem(
              context,
              'Peer Learning',
              Icons.groups_2,
              const PeerLearningScreen(),
            ),
            _buildDrawerItem(
              context,
              'Mentor Matching',
              Icons.people_alt,
              const MentorMatchingScreen(),
            ),
            _buildDrawerItem(
              context,
              'Networking Hub',
              Icons.hub,
              const NetworkingHubScreen(),
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
              'Hackathons',
              Icons.emoji_events_outlined,
              const HackathonHubScreen(),
            ),
            _buildDrawerItem(
              context,
              'Skill Exchange',
              Icons.swap_horiz,
              const SkillExchangeScreen(),
            ),
            _buildDrawerItem(
              context,
              'Insights',
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
              'Alumni Network',
              Icons.school_outlined,
              const AlumniNetworkScreen(),
            ),
            _buildDrawerItem(
              context,
              'Company Pages',
              Icons.business_center_outlined,
              const CompanyPageScreen(),
            ),
            _buildDrawerItem(
              context,
              'Networking Events',
              Icons.event_available,
              const NetworkingEventsScreen(),
            ),
            _buildDrawerItem(
              context,
              'Success Stories',
              Icons.auto_awesome,
              const SuccessStoriesScreen(),
            ),
            _buildDrawerItem(
              context,
              'Knowledge Base',
              Icons.library_books_outlined,
              const KnowledgeBaseScreen(),
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
              const gamification.ChallengesScreen(),
            ),
            _buildDrawerItem(
              context,
              'Rewards',
              Icons.card_giftcard,
              const RewardsScreen(),
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
