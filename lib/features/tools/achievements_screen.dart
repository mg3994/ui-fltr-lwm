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
        'title': 'Night Owl',
        'description': 'Complete 5 sessions after 8 PM',
        'icon': Icons.nightlight,
        'color': Colors.indigo,
        'unlocked': false,
        'progress': 0.4,
        'current': 2,
        'total': 5,
      },
      {
        'id': 6,
        'title': 'Community Helper',
        'description': 'Answer 25 forum questions',
        'icon': Icons.help_outline,
        'color': Colors.green,
        'unlocked': false,
        'progress': 0.32,
        'current': 8,
        'total': 25,
      },
    ];

    final unlockedCount = achievements
        .where((a) => a['unlocked'] == true)
        .length;
    final totalCount = achievements.length;
    final overallProgress = unlockedCount / totalCount;

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
                'Achievements',
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
                // Progress Card
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
                          Theme.of(context).colorScheme.secondaryContainer,
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.emoji_events,
                                color: Theme.of(context).colorScheme.primary,
                                size: 32,
                              ),
                            ),
                            const Gap(20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Achievement Progress',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(8),
                                  Text(
                                    '$unlockedCount of $totalCount unlocked',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: overallProgress),
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.easeOut,
                          builder: (context, value, _) {
                            return Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value: value,
                                    minHeight: 12,
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHighest,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                const Gap(12),
                                Text(
                                  '${(value * 100).toInt()}% Complete',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(32),

                const Text(
                  'All Achievements',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(16),

                // Achievements List
                ...achievements.asMap().entries.map((entry) {
                  final index = entry.key;
                  final achievement = entry.value;
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
                    child: _AchievementCard(achievement: achievement),
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

class _AchievementCard extends StatelessWidget {
  final Map<String, dynamic> achievement;

  const _AchievementCard({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final unlocked = achievement['unlocked'] as bool;
    final progress = achievement['progress'] as double;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: unlocked
                ? (achievement['color'] as Color).withValues(alpha: 0.15)
                : Theme.of(context).shadowColor.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: unlocked
              ? (achievement['color'] as Color).withValues(alpha: 0.3)
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
                    (achievement['color'] as Color).withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              )
            : null,
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // Achievement Icon
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: unlocked
                    ? (achievement['color'] as Color).withValues(alpha: 0.15)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                border: Border.all(
                  color: unlocked
                      ? achievement['color'] as Color
                      : Theme.of(context).colorScheme.outlineVariant,
                  width: 3,
                ),
                boxShadow: unlocked
                    ? [
                        BoxShadow(
                          color: (achievement['color'] as Color).withValues(
                            alpha: 0.3,
                          ),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                achievement['icon'] as IconData,
                size: 32,
                color: unlocked
                    ? achievement['color'] as Color
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const Gap(16),

            // Achievement Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement['title'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: unlocked
                          ? null
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Gap(6),
                  Text(
                    achievement['description'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (unlocked) ...[
                    const Gap(10),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: achievement['color'] as Color,
                        ),
                        const Gap(6),
                        Text(
                          'Unlocked on ${achievement['date']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: achievement['color'] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    const Gap(12),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: progress),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOut,
                      builder: (context, value, _) {
                        return Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: value,
                                minHeight: 6,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  achievement['color'] as Color,
                                ),
                              ),
                            ),
                            const Gap(6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${achievement['current']} / ${achievement['total']}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${(value * 100).toInt()}%',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: achievement['color'] as Color,
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
}
