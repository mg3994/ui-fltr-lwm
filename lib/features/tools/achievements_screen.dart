import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class AchievementsScreen extends HookWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCategory = useState('All');
    final categories = ['All', 'Sessions', 'Learning', 'Social', 'Milestones'];

    final achievements = [
      {
        'title': 'First Session',
        'description': 'Complete your first mentoring session',
        'icon': Icons.star,
        'color': Colors.amber,
        'progress': 1.0,
        'unlocked': true,
        'category': 'Sessions',
        'points': 100,
        'date': '2 days ago',
      },
      {
        'title': '10 Sessions Milestone',
        'description': 'Complete 10 mentoring sessions',
        'icon': Icons.workspace_premium,
        'color': Colors.purple,
        'progress': 0.7,
        'unlocked': false,
        'category': 'Sessions',
        'points': 500,
        'current': 7,
        'target': 10,
      },
      {
        'title': 'Knowledge Seeker',
        'description': 'Complete 5 courses',
        'icon': Icons.school,
        'color': Colors.blue,
        'progress': 1.0,
        'unlocked': true,
        'category': 'Learning',
        'points': 300,
        'date': '1 week ago',
      },
      {
        'title': 'Social Butterfly',
        'description': 'Connect with 20 mentors',
        'icon': Icons.people,
        'color': Colors.pink,
        'progress': 0.85,
        'unlocked': false,
        'category': 'Social',
        'points': 250,
        'current': 17,
        'target': 20,
      },
      {
        'title': 'Early Bird',
        'description': 'Join 5 morning sessions',
        'icon': Icons.wb_sunny,
        'color': Colors.orange,
        'progress': 0.4,
        'unlocked': false,
        'category': 'Milestones',
        'points': 150,
        'current': 2,
        'target': 5,
      },
      {
        'title': 'Feedback Champion',
        'description': 'Receive 50 five-star reviews',
        'icon': Icons.reviews,
        'color': Colors.green,
        'progress': 0.92,
        'unlocked': false,
        'category': 'Social',
        'points': 750,
        'current': 46,
        'target': 50,
      },
    ];

    final filteredAchievements = selectedCategory.value == 'All'
        ? achievements
        : achievements
              .where((a) => a['category'] == selectedCategory.value)
              .toList();

    final unlockedCount = achievements
        .where((a) => a['unlocked'] == true)
        .length;
    final totalPoints = achievements
        .where((a) => a['unlocked'] == true)
        .fold<int>(0, (sum, a) => sum + (a['points'] as int));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
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
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
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
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatCard(
                            label: 'Unlocked',
                            value: '$unlockedCount/${achievements.length}',
                            icon: Icons.lock_open,
                            color: Colors.green,
                          ),
                          _StatCard(
                            label: 'Total Points',
                            value: totalPoints.toString(),
                            icon: Icons.stars,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: categories.map((category) {
                  final isSelected = selectedCategory.value == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) selectedCategory.value = category;
                      },
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      selectedColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? Colors.transparent
                            : Theme.of(context).colorScheme.outlineVariant
                                  .withValues(alpha: 0.5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final achievement = filteredAchievements[index];
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.scale(
                        scale: 0.8 + (0.2 * value),
                        child: child,
                      ),
                    );
                  },
                  child: _AchievementCard(achievement: achievement),
                );
              }, childCount: filteredAchievements.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
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
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
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

class _AchievementCard extends StatelessWidget {
  final Map<String, dynamic> achievement;

  const _AchievementCard({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final unlocked = achievement['unlocked'] as bool;
    final progress = achievement['progress'] as double;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: unlocked
                ? (achievement['color'] as Color).withValues(alpha: 0.15)
                : Theme.of(context).colorScheme.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: unlocked
                  ? (achievement['color'] as Color).withValues(alpha: 0.5)
                  : Theme.of(
                      context,
                    ).colorScheme.outlineVariant.withValues(alpha: 0.5),
              width: unlocked ? 2 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: unlocked
                          ? [
                              (achievement['color'] as Color).withValues(
                                alpha: 0.3,
                              ),
                              (achievement['color'] as Color).withValues(
                                alpha: 0.1,
                              ),
                            ]
                          : [
                              Colors.grey.withValues(alpha: 0.2),
                              Colors.grey.withValues(alpha: 0.1),
                            ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    achievement['icon'] as IconData,
                    size: 40,
                    color: unlocked
                        ? (achievement['color'] as Color)
                        : Colors.grey,
                  ),
                ),
                const Gap(12),
                // Title
                Text(
                  achievement['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: unlocked ? null : Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(6),
                // Description
                Text(
                  achievement['description'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: unlocked
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                // Progress or Date
                if (unlocked) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: (achievement['color'] as Color).withValues(
                        alpha: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: achievement['color'] as Color,
                        ),
                        const Gap(4),
                        Text(
                          achievement['date'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            color: achievement['color'] as Color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 6,
                          backgroundColor: Colors.grey.withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            achievement['color'] as Color,
                          ),
                        ),
                      ),
                      const Gap(4),
                      Text(
                        '${achievement['current']}/${achievement['target']}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
                const Gap(8),
                // Points
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.stars,
                      size: 14,
                      color: unlocked ? Colors.amber : Colors.grey,
                    ),
                    const Gap(4),
                    Text(
                      '${achievement['points']} pts',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: unlocked ? Colors.amber : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
