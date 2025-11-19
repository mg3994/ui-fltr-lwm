import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class AchievementsScreen extends HookWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final achievements = [
      {
        'id': 1,
        'title': 'First Session',
        'description': 'Complete your first mentoring session',
        'icon': Icons.video_call,
        'color': Colors.blue,
        'unlocked': true,
        'progress': 1.0,
        'date': 'Jan 15, 2024',
      },
      {
        'id': 2,
        'title': '10 Sessions Milestone',
        'description': 'Complete 10 mentoring sessions',
        'icon': Icons.military_tech,
        'color': Colors.purple,
        'unlocked': true,
        'progress': 1.0,
        'date': 'Feb 20, 2024',
      },
      {
        'id': 3,
        'title': '5-Star Mentor',
        'description': 'Receive a 5-star rating',
        'icon': Icons.star,
        'color': Colors.amber,
        'unlocked': true,
        'progress': 1.0,
        'date': 'Jan 28, 2024',
      },
      {
        'id': 4,
        'title': 'Early Bird',
        'description': 'Complete 5 sessions before 9 AM',
        'icon': Icons.wb_sunny,
        'color': Colors.orange,
        'unlocked': false,
        'progress': 0.6,
        'current': 3,
        'total': 5,
      },
      {
        'id': 5,
        'title': 'Knowledge Sharer',
        'description': 'Answer 20 community questions',
        'icon': Icons.forum,
        'color': Colors.green,
        'unlocked': false,
        'progress': 0.35,
        'current': 7,
        'total': 20,
      },
      {
        'id': 6,
        'title': 'Marathon Mentor',
        'description': 'Complete 50 sessions',
        'icon': Icons.emoji_events,
        'color': Colors.red,
        'unlocked': false,
        'progress': 0.48,
        'current': 24,
        'total': 50,
      },
    ];

    final unlockedCount = achievements
        .where((a) => a['unlocked'] == true)
        .length;
    final totalCount = achievements.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Achievements')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Progress Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Progress',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$unlockedCount / $totalCount',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  LinearProgressIndicator(
                    value: unlockedCount / totalCount,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  const Gap(8),
                  Text(
                    '${((unlockedCount / totalCount) * 100).toInt()}% Complete',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Gap(24),

          // Achievements List
          ...achievements.map((achievement) {
            final unlocked = achievement['unlocked'] as bool;
            return _AchievementCard(
              achievement: achievement,
              unlocked: unlocked,
            );
          }),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final Map<String, dynamic> achievement;
  final bool unlocked;

  const _AchievementCard({required this.achievement, required this.unlocked});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: unlocked
                    ? (achievement['color'] as Color).withOpacity(0.2)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                achievement['icon'] as IconData,
                size: 32,
                color: unlocked
                    ? achievement['color'] as Color
                    : Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant.withOpacity(0.5),
              ),
            ),
            const Gap(16),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: unlocked
                          ? null
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    achievement['description'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (!unlocked) ...[
                    const Gap(12),
                    LinearProgressIndicator(
                      value: achievement['progress'] as double,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    const Gap(4),
                    Text(
                      '${achievement['current']} / ${achievement['total']}',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ] else ...[
                    const Gap(8),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: achievement['color'] as Color,
                        ),
                        const Gap(4),
                        Text(
                          'Unlocked on ${achievement['date']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: achievement['color'] as Color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
