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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                'Badges',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Stats Card
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutBack,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: 0.95 + (0.05 * value),
                      child: Opacity(opacity: value, child: child),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primaryContainer,
                          Theme.of(context).colorScheme.tertiaryContainer,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(24.0),
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

                const Gap(32),

                // Unlocked Badges
                const Text(
                  'Unlocked Badges',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(16),

                ...unlockedBadges.asMap().entries.map((entry) {
                  final index = entry.key;
                  final badge = entry.value;
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 400 + (index * 100)),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: _BadgeCard(badge: badge, unlocked: true),
                  );
                }),

                const Gap(32),

                // Locked Badges
                const Text(
                  'In Progress',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(16),

                ...lockedBadges.asMap().entries.map((entry) {
                  final index = entry.key;
                  final badge = entry.value;
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 600 + (index * 100)),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: _BadgeCard(badge: badge, unlocked: false),
                  );
                }),
                const Gap(80),
              ]),
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
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const Gap(12),
        Text(
          value,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const Gap(4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: unlocked
                ? (badge['color'] as Color).withValues(alpha: 0.15)
                : Theme.of(context).shadowColor.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: unlocked
              ? (badge['color'] as Color).withValues(alpha: 0.3)
              : Theme.of(
                  context,
                ).colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: unlocked ? 2 : 1,
        ),
      ),
      child: Container(
        decoration: unlocked
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.surface,
                    (badge['color'] as Color).withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              )
            : null,
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // Badge Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: unlocked
                    ? (badge['color'] as Color).withValues(alpha: 0.15)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                border: Border.all(
                  color: unlocked
                      ? badge['color'] as Color
                      : Theme.of(context).colorScheme.outlineVariant,
                  width: 3,
                ),
                boxShadow: unlocked
                    ? [
                        BoxShadow(
                          color: (badge['color'] as Color).withValues(
                            alpha: 0.3,
                          ),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                badge['icon'] as IconData,
                size: 40,
                color: unlocked
                    ? badge['color'] as Color
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const Gap(20),

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
                            fontSize: 18,
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
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getRarityColor(
                            badge['rarity'] as String,
                          ).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _getRarityColor(
                              badge['rarity'] as String,
                            ).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          badge['rarity'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _getRarityColor(badge['rarity'] as String),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Text(
                    badge['description'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (unlocked) ...[
                    const Gap(12),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: badge['color'] as Color,
                        ),
                        const Gap(6),
                        Text(
                          'Unlocked on ${badge['date']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: badge['color'] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    const Gap(16),
                    TweenAnimationBuilder<double>(
                      tween: Tween(
                        begin: 0.0,
                        end: badge['progress'] as double,
                      ),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOut,
                      builder: (context, value, _) {
                        return Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: value,
                                minHeight: 8,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  badge['color'] as Color,
                                ),
                              ),
                            ),
                            const Gap(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${badge['current']} / ${badge['total']}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${(value * 100).toInt()}%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: badge['color'] as Color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
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
