import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class BadgesScreen extends HookWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final badges = [
      {
        'name': 'Early Adopter',
        'description': 'Joined LinkWithMentor in the first month',
        'icon': Icons.rocket_launch,
        'color': Colors.purple,
        'unlocked': true,
        'rarity': 'Legendary',
        'date': 'Jan 1, 2024',
      },
      {
        'name': 'Session Master',
        'description': 'Completed 100 mentoring sessions',
        'icon': Icons.video_call,
        'color': Colors.blue,
        'unlocked': true,
        'rarity': 'Epic',
        'date': 'Feb 15, 2024',
      },
      {
        'name': 'Knowledge Guru',
        'description': 'Answered 50 community questions',
        'icon': Icons.school,
        'color': Colors.green,
        'unlocked': true,
        'rarity': 'Rare',
        'date': 'Jan 28, 2024',
      },
      {
        'name': 'Perfect Rating',
        'description': 'Maintained 5.0 rating for 3 months',
        'icon': Icons.star,
        'color': Colors.amber,
        'unlocked': true,
        'rarity': 'Epic',
        'date': 'Mar 1, 2024',
      },
      {
        'name': 'Community Leader',
        'description': 'Create and manage 3 study groups',
        'icon': Icons.groups,
        'color': Colors.orange,
        'unlocked': false,
        'rarity': 'Rare',
        'progress': 0.66,
        'current': 2,
        'total': 3,
      },
      {
        'name': 'Referral Champion',
        'description': 'Refer 10 new users',
        'icon': Icons.people_alt,
        'color': Colors.pink,
        'unlocked': false,
        'rarity': 'Common',
        'progress': 0.3,
        'current': 3,
        'total': 10,
      },
      {
        'name': 'Streak Legend',
        'description': 'Maintain 30-day activity streak',
        'icon': Icons.local_fire_department,
        'color': Colors.red,
        'unlocked': false,
        'rarity': 'Epic',
        'progress': 0.23,
        'current': 7,
        'total': 30,
      },
      {
        'name': 'Skill Collector',
        'description': 'Complete assessments in 5 different skills',
        'icon': Icons.collections_bookmark,
        'color': Colors.teal,
        'unlocked': false,
        'rarity': 'Rare',
        'progress': 0.6,
        'current': 3,
        'total': 5,
      },
    ];

    final unlockedBadges = badges.where((b) => b['unlocked'] == true).toList();
    final lockedBadges = badges.where((b) => b['unlocked'] == false).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Badges')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stats Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatColumn(
                    label: 'Unlocked',
                    value: '${unlockedBadges.length}',
                    icon: Icons.verified,
                    color: Colors.green,
                  ),
                  Container(
                    width: 1,
                    height: 50,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  _StatColumn(
                    label: 'In Progress',
                    value: '${lockedBadges.length}',
                    icon: Icons.hourglass_empty,
                    color: Colors.orange,
                  ),
                  Container(
                    width: 1,
                    height: 50,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  _StatColumn(
                    label: 'Total',
                    value: '${badges.length}',
                    icon: Icons.emoji_events,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),

          const Gap(24),

          // Unlocked Badges
          const Text(
            'Unlocked Badges',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(16),

          ...unlockedBadges.map(
            (badge) => _BadgeCard(badge: badge, unlocked: true),
          ),

          const Gap(24),

          // Locked Badges
          const Text(
            'In Progress',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(16),

          ...lockedBadges.map(
            (badge) => _BadgeCard(badge: badge, unlocked: false),
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
  final Color color;

  const _StatColumn({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
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

class _BadgeCard extends StatelessWidget {
  final Map<String, dynamic> badge;
  final bool unlocked;

  const _BadgeCard({required this.badge, required this.unlocked});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Badge Icon
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: unlocked
                    ? (badge['color'] as Color).withValues(alpha: 0.2)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                border: Border.all(
                  color: unlocked
                      ? badge['color'] as Color
                      : Theme.of(context).colorScheme.outlineVariant,
                  width: 3,
                ),
              ),
              child: Icon(
                badge['icon'] as IconData,
                size: 36,
                color: unlocked
                    ? badge['color'] as Color
                    : Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
            const Gap(16),

            // Badge Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          badge['name'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: unlocked
                                ? null
                                : Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getRarityColor(
                            badge['rarity'] as String,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          badge['rarity'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getRarityColor(badge['rarity'] as String),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Text(
                    badge['description'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (unlocked) ...[
                    const Gap(8),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: badge['color'] as Color,
                        ),
                        const Gap(4),
                        Text(
                          'Unlocked on ${badge['date']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: badge['color'] as Color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    const Gap(12),
                    LinearProgressIndicator(
                      value: badge['progress'] as double,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    const Gap(4),
                    Text(
                      '${badge['current']} / ${badge['total']}',
                      style: const TextStyle(fontSize: 11),
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

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case 'Legendary':
        return Colors.purple;
      case 'Epic':
        return Colors.deepPurple;
      case 'Rare':
        return Colors.blue;
      case 'Common':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}

