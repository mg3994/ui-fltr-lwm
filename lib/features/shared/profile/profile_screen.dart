import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:linkwithmentor/core/state/app_state.dart';
import 'package:linkwithmentor/features/community/forum_screen.dart';
import 'package:linkwithmentor/features/tools/resume_builder_screen.dart';
import 'package:linkwithmentor/features/tools/portfolio_builder_screen.dart';
import 'package:linkwithmentor/features/auth/login_screen.dart';
import 'package:linkwithmentor/features/mentor/dashboard/payouts_screen.dart';
import 'package:linkwithmentor/features/shared/profile/edit_profile_screen.dart';
import 'package:linkwithmentor/features/shared/profile/help_support_screen.dart';
import 'package:linkwithmentor/features/shared/profile/settings_screen.dart';
import 'package:linkwithmentor/features/tools/goals_screen.dart';
import 'package:linkwithmentor/features/mentor/analytics/analytics_screen.dart';

class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMentor = appState.isMentorMode.watch(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(appState.userAvatar.value),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EditProfileScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                Text(
                  appState.userName.value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(4),
                Text(
                  isMentor ? 'Senior Flutter Developer' : 'Aspiring Developer',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const Gap(32),

          // Mode Toggle Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isMentor
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  isMentor ? Icons.school : Icons.person_outline,
                  size: 32,
                  color: isMentor
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isMentor ? 'Mentor Mode' : 'Mentee Mode',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        isMentor
                            ? 'Switch to find mentors'
                            : 'Switch to teach & earn',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: isMentor,
                  onChanged: (value) {
                    appState.isMentorMode.value = value;
                  },
                ),
              ],
            ),
          ),

          const Gap(24),

          // Menu Items
          const _SectionHeader(title: 'Account'),
          _ProfileMenuItem(
            icon: Icons.person_outline,
            title: 'Personal Information',
            onTap: () {},
          ),
          _ProfileMenuItem(
            icon: Icons.payment_outlined,
            title: 'Payments & Payouts',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PayoutsScreen()),
              );
            },
          ),
          _ProfileMenuItem(
            icon: Icons.security_outlined,
            title: 'Security',
            onTap: () {},
          ),

          const Gap(24),
          const _SectionHeader(title: 'Community & Tools'),
          _ProfileMenuItem(
            icon: Icons.forum_outlined,
            title: 'Community Forum',
            subtitle: 'Ask questions & share knowledge',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ForumScreen()),
              );
            },
          ),
          _ProfileMenuItem(
            icon: Icons.description_outlined,
            title: 'Resume Builder',
            subtitle: 'Create a professional resume',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ResumeBuilderScreen()),
              );
            },
          ),
          _ProfileMenuItem(
            icon: Icons.collections_outlined,
            title: 'Portfolio Builder',
            subtitle: 'Showcase your projects',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PortfolioBuilderScreen(),
                ),
              );
            },
          ),
          _ProfileMenuItem(
            icon: Icons.flag_outlined,
            title: 'My Goals',
            subtitle: 'Track your learning progress',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GoalsScreen()),
              );
            },
          ),
          if (isMentor)
            _ProfileMenuItem(
              icon: Icons.analytics_outlined,
              title: 'Analytics',
              subtitle: 'View your performance metrics',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
                );
              },
            ),
          _ProfileMenuItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
              );
            },
          ),

          const Gap(24),
          OutlinedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(Icons.chevron_right, size: 16),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}
