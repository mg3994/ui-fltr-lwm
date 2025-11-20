import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class StreaksScreen extends HookWidget {
  const StreaksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStreak = 7;
    final longestStreak = 21;
    final totalDays = 45;

    final streakHistory = List.generate(30, (index) {
      // Simulate activity pattern
      return {
        'day': DateTime.now().subtract(Duration(days: 29 - index)),
        'active':
            index < 7 ||
            (index >= 10 && index < 15) ||
            (index >= 20 && index < 28),
      };
    });

    final milestones = [
      {
        'days': 7,
        'title': '7-Day Streak',
        'reward': '10 points',
        'achieved': true,
        'icon': Icons.local_fire_department,
        'color': Colors.orange,
      },
      {
        'days': 14,
        'title': '2-Week Warrior',
        'reward': '25 points',
        'achieved': false,
        'icon': Icons.military_tech,
        'color': Colors.blue,
      },
      {
        'days': 30,
        'title': 'Monthly Master',
        'reward': '50 points',
        'achieved': false,
        'icon': Icons.emoji_events,
        'color': Colors.purple,
      },
      {
        'days': 100,
        'title': 'Century Club',
        'reward': '200 points',
        'achieved': false,
        'icon': Icons.stars,
        'color': Colors.amber,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Activity Streaks')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Current Streak Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    size: 64,
                    color: Colors.orange,
                  ),
                  const Gap(16),
                  Text(
                    '$currentStreak',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const Text('Day Streak', style: TextStyle(fontSize: 18)),
                  const Gap(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatColumn(
                        label: 'Longest',
                        value: '$longestStreak',
                        icon: Icons.trending_up,
                      ),
                      _StatColumn(
                        label: 'Total Days',
                        value: '$totalDays',
                        icon: Icons.calendar_today,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Gap(24),

          // Calendar View
          const Text(
            'Last 30 Days',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: streakHistory.length,
                itemBuilder: (context, index) {
                  final day = streakHistory[index];
                  final isActive = day['active'] as bool;
                  final date = day['day'] as DateTime;

                  return Container(
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.orange.withValues(alpha: 0.8)
                          : Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isActive
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const Gap(24),

          // Milestones
          const Text(
            'Streak Milestones',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(16),

          ...milestones.map(
            (milestone) => _MilestoneCard(milestone: milestone),
          ),

          const Gap(24),

          // Tips Card
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const Gap(12),
                      Text(
                        'Keep Your Streak Alive!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  Text(
                    '• Complete at least one session per day\n'
                    '• Answer community questions\n'
                    '• Practice interview questions\n'
                    '• Update your learning goals',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatColumn({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const Gap(8),
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _MilestoneCard extends StatelessWidget {
  final Map<String, dynamic> milestone;

  const _MilestoneCard({required this.milestone});

  @override
  Widget build(BuildContext context) {
    final achieved = milestone['achieved'] as bool;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: achieved
                    ? (milestone['color'] as Color).withValues(alpha: 0.2)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                milestone['icon'] as IconData,
                color: achieved
                    ? milestone['color'] as Color
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                size: 28,
              ),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    milestone['title'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: achieved
                          ? null
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    '${milestone['days']} day streak • ${milestone['reward']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (achieved)
              const Icon(Icons.check_circle, color: Colors.green, size: 28)
            else
              const Icon(Icons.lock_outline, size: 28),
          ],
        ),
      ),
    );
  }
}
