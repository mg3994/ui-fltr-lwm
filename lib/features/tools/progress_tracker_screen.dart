import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class ProgressTrackerScreen extends HookWidget {
  const ProgressTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPeriod = useState('This Month');
    final periods = ['This Week', 'This Month', 'This Year', 'All Time'];

    final stats = {
      'totalSessions': 24,
      'completedGoals': 8,
      'skillsLearned': 12,
      'hoursInvested': 48,
      'streakDays': 15,
      'certificatesEarned': 3,
    };

    final milestones = [
      {
        'title': 'First Session Completed',
        'date': 'Nov 1, 2024',
        'icon': Icons.video_call,
        'color': Colors.blue,
        'achieved': true,
      },
      {
        'title': '10 Sessions Milestone',
        'date': 'Nov 10, 2024',
        'icon': Icons.celebration,
        'color': Colors.purple,
        'achieved': true,
      },
      {
        'title': 'First Skill Mastered',
        'date': 'Nov 15, 2024',
        'icon': Icons.emoji_events,
        'color': Colors.amber,
        'achieved': true,
      },
      {
        'title': '50 Sessions Milestone',
        'date': 'In Progress',
        'icon': Icons.star,
        'color': Colors.grey,
        'achieved': false,
        'progress': 0.48,
      },
    ];

    final weeklyProgress = [
      {'day': 'Mon', 'hours': 2.5, 'sessions': 1},
      {'day': 'Tue', 'hours': 3.0, 'sessions': 2},
      {'day': 'Wed', 'hours': 1.5, 'sessions': 1},
      {'day': 'Thu', 'hours': 4.0, 'sessions': 2},
      {'day': 'Fri', 'hours': 2.0, 'sessions': 1},
      {'day': 'Sat', 'hours': 0.0, 'sessions': 0},
      {'day': 'Sun', 'hours': 3.5, 'sessions': 2},
    ];

    final skillProgress = [
      {'skill': 'Flutter Development', 'progress': 0.85, 'level': 'Advanced'},
      {'skill': 'State Management', 'progress': 0.65, 'level': 'Intermediate'},
      {'skill': 'UI/UX Design', 'progress': 0.45, 'level': 'Beginner'},
      {'skill': 'API Integration', 'progress': 0.75, 'level': 'Intermediate'},
    ];

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
                'Progress Tracker',
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
            actions: [
              PopupMenuButton<String>(
                initialValue: selectedPeriod.value,
                onSelected: (value) => selectedPeriod.value = value,
                itemBuilder: (context) => periods
                    .map(
                      (period) =>
                          PopupMenuItem(value: period, child: Text(period)),
                    )
                    .toList(),
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedPeriod.value,
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const Gap(4),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Stats Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,
                  children: [
                    _StatCard(
                      icon: Icons.video_call,
                      value: '${stats['totalSessions']}',
                      label: 'Sessions',
                      color: Colors.blue,
                    ),
                    _StatCard(
                      icon: Icons.check_circle,
                      value: '${stats['completedGoals']}',
                      label: 'Goals',
                      color: Colors.green,
                    ),
                    _StatCard(
                      icon: Icons.school,
                      value: '${stats['skillsLearned']}',
                      label: 'Skills',
                      color: Colors.purple,
                    ),
                    _StatCard(
                      icon: Icons.access_time,
                      value: '${stats['hoursInvested']}h',
                      label: 'Hours',
                      color: Colors.orange,
                    ),
                  ],
                ),

                const Gap(24),

                // Weekly Activity Chart
                Text(
                  'Weekly Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).shadowColor.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: weeklyProgress.map((day) {
                            final hours = day['hours'] as double;
                            final maxHeight = 150.0;
                            final barHeight = (hours / 4.0) * maxHeight;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (hours > 0)
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 4),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '${hours}h',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                Container(
                                  width: 32,
                                  height: barHeight,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).colorScheme.primary,
                                        Theme.of(context).colorScheme.primary
                                            .withValues(alpha: 0.6),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  day['day'] as String,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(24),

                // Skill Progress
                Text(
                  'Skill Progress',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(16),
                ...skillProgress.map((skill) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.outlineVariant.withValues(alpha: 0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).shadowColor.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                skill['skill'] as String,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getLevelColor(
                                  skill['level'] as String,
                                ).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                skill['level'] as String,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: _getLevelColor(
                                    skill['level'] as String,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(12),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: skill['progress'] as double,
                                minHeight: 8,
                                borderRadius: BorderRadius.circular(4),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                                color: _getLevelColor(skill['level'] as String),
                              ),
                            ),
                            const Gap(12),
                            Text(
                              '${((skill['progress'] as double) * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _getLevelColor(skill['level'] as String),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),

                const Gap(24),

                // Milestones
                Text(
                  'Milestones',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(16),
                ...milestones.map((milestone) {
                  final isAchieved = milestone['achieved'] as bool;
                  final color = milestone['color'] as Color;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isAchieved
                          ? color.withValues(alpha: 0.1)
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isAchieved
                            ? color.withValues(alpha: 0.3)
                            : Theme.of(context).colorScheme.outlineVariant
                                  .withValues(alpha: 0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).shadowColor.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            milestone['icon'] as IconData,
                            color: color,
                            size: 24,
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: isAchieved
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                milestone['date'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                              if (!isAchieved &&
                                  milestone.containsKey('progress')) ...[
                                const Gap(8),
                                LinearProgressIndicator(
                                  value: milestone['progress'] as double,
                                  minHeight: 4,
                                  borderRadius: BorderRadius.circular(2),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHighest,
                                  color: color,
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (isAchieved)
                          Icon(Icons.check_circle, color: color, size: 28),
                      ],
                    ),
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

  Color _getLevelColor(String level) {
    switch (level) {
      case 'Advanced':
        return Colors.purple;
      case 'Intermediate':
        return Colors.blue;
      case 'Beginner':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const Gap(8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
