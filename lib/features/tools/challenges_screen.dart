import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class ChallengesScreen extends HookWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    final challenges = [
      {
        'id': 1,
        'title': '30-Day Flutter Challenge',
        'description': 'Build 30 Flutter widgets in 30 days',
        'difficulty': 'Intermediate',
        'participants': 1234,
        'duration': '30 days',
        'reward': '500 points',
        'progress': 0.6,
        'daysLeft': 12,
        'status': 'In Progress',
        'color': Colors.blue,
        'icon': Icons.code,
        'tasks': [
          {'name': 'Build a custom button', 'completed': true},
          {'name': 'Create an animated card', 'completed': true},
          {'name': 'Design a form validator', 'completed': false},
        ],
      },
      {
        'id': 2,
        'title': 'UI/UX Design Sprint',
        'description': 'Complete 5 design challenges',
        'difficulty': 'Beginner',
        'participants': 856,
        'duration': '7 days',
        'reward': '300 points',
        'progress': 0.0,
        'daysLeft': 7,
        'status': 'Not Started',
        'color': Colors.pink,
        'icon': Icons.palette,
        'tasks': [
          {'name': 'Design a login screen', 'completed': false},
          {'name': 'Create a color palette', 'completed': false},
          {'name': 'Build a component library', 'completed': false},
        ],
      },
      {
        'id': 3,
        'title': 'State Management Mastery',
        'description': 'Master 3 state management solutions',
        'difficulty': 'Advanced',
        'participants': 567,
        'duration': '14 days',
        'reward': '750 points',
        'progress': 1.0,
        'daysLeft': 0,
        'status': 'Completed',
        'color': Colors.green,
        'icon': Icons.settings_applications,
        'tasks': [
          {'name': 'Implement Provider', 'completed': true},
          {'name': 'Build with Riverpod', 'completed': true},
          {'name': 'Master BLoC pattern', 'completed': true},
        ],
      },
      {
        'id': 4,
        'title': 'API Integration Challenge',
        'description': 'Integrate 10 different APIs',
        'difficulty': 'Intermediate',
        'participants': 923,
        'duration': '21 days',
        'reward': '600 points',
        'progress': 0.3,
        'daysLeft': 15,
        'status': 'In Progress',
        'color': Colors.orange,
        'icon': Icons.api,
        'tasks': [
          {'name': 'REST API integration', 'completed': true},
          {'name': 'GraphQL setup', 'completed': true},
          {'name': 'WebSocket connection', 'completed': false},
        ],
      },
    ];

    final activeChallenges = challenges.where((c) => c['status'] == 'In Progress').toList();
    final completedChallenges = challenges.where((c) => c['status'] == 'Completed').toList();
    final availableChallenges = challenges.where((c) => c['status'] == 'Not Started').toList();

    final displayChallenges = selectedTab.value == 0
        ? activeChallenges
        : selectedTab.value == 1
            ? availableChallenges
            : completedChallenges;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                'Challenges',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.emoji_events),
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5),
                ),
              ),
              const Gap(8),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Tabs
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _TabButton(
                          label: 'Active (${activeChallenges.length})',
                          isSelected: selectedTab.value == 0,
                          onTap: () => selectedTab.value = 0,
                        ),
                      ),
                      Expanded(
                        child: _TabButton(
                          label: 'Available (${availableChallenges.length})',
                          isSelected: selectedTab.value == 1,
                          onTap: () => selectedTab.value = 1,
                        ),
                      ),
                      Expanded(
                        child: _TabButton(
                          label: 'Completed (${completedChallenges.length})',
                          isSelected: selectedTab.value == 2,
                          onTap: () => selectedTab.value = 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final challenge = displayChallenges[index];
                  return _ChallengeCard(challenge: challenge);
                },
                childCount: displayChallenges.length,
              ),
            ),
          ),
          const SliverGap(80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Create Challenge'),
        elevation: 2,
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final Map<String, dynamic> challenge;

  const _ChallengeCard({required this.challenge});

  @override
  Widget build(BuildContext context) {
    final color = challenge['color'] as Color;
    final progress = challenge['progress'] as double;
    final status = challenge['status'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.15),
                  color.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        challenge['icon'] as IconData,
                        color: color,
                        size: 24,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            challenge['title'] as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            challenge['description'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        challenge['difficulty'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats
                Row(
                  children: [
                    _StatChip(
                      icon: Icons.people,
                      label: '${challenge['participants']} joined',
                      color: color,
                    ),
                    const Gap(8),
                    _StatChip(
                      icon: Icons.access_time,
                      label: challenge['duration'] as String,
                      color: color,
                    ),
                    const Gap(8),
                    _StatChip(
                      icon: Icons.stars,
                      label: challenge['reward'] as String,
                      color: Colors.amber,
                    ),
                  ],
                ),
                const Gap(16),
                // Progress
                if (status != 'Not Started') ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    color: color,
                  ),
                  const Gap(16),
                ],
                // Tasks
                Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(8),
                ...(challenge['tasks'] as List<Map<String, dynamic>>).map((task) {
                  final isCompleted = task['completed'] as bool;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                          size: 20,
                          color: isCompleted ? color : Theme.of(context).colorScheme.outlineVariant,
                        ),
                        const Gap(8),
                        Expanded(
                          child: Text(
                            task['name'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              decoration: isCompleted ? TextDecoration.lineThrough : null,
                              color: isCompleted
                                  ? Theme.of(context).colorScheme.onSurfaceVariant
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const Gap(16),
                // Action Button
                if (status == 'Not Started')
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('Join Challenge'),
                  )
                else if (status == 'In Progress')
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(color: color),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            '${challenge['daysLeft']} days left',
                            style: TextStyle(color: color),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text('Continue'),
                        ),
                      ),
                    ],
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.emoji_events, color: Colors.green),
                        const Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Challenge Completed!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                'You earned ${challenge['reward']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
