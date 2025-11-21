import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class LeaderboardScreen extends HookWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPeriod = useState('This Week');
    final periods = ['Today', 'This Week', 'This Month', 'All Time'];

    final topUsers = [
      {
        'rank': 2,
        'name': 'Sarah Johnson',
        'avatar': 'https://i.pravatar.cc/150?img=1',
        'points': 8750,
        'sessions': 45,
        'badge': '🥈',
        'color': Colors.grey,
      },
      {
        'rank': 1,
        'name': 'Alex Chen',
        'avatar': 'https://i.pravatar.cc/150?img=2',
        'points': 9500,
        'sessions': 52,
        'badge': '🏆',
        'color': Colors.amber,
      },
      {
        'rank': 3,
        'name': 'Maria Garcia',
        'avatar': 'https://i.pravatar.cc/150?img=3',
        'points': 8200,
        'sessions': 38,
        'badge': '🥉',
        'color': Colors.brown,
      },
    ];

    final otherUsers = [
      {
        'rank': 4,
        'name': 'John Smith',
        'avatar': 'https://i.pravatar.cc/150?img=4',
        'points': 7800,
        'sessions': 35,
      },
      {
        'rank': 5,
        'name': 'Emily Davis',
        'avatar': 'https://i.pravatar.cc/150?img=5',
        'points': 7500,
        'sessions': 32,
      },
      {
        'rank': 6,
        'name': 'Michael Brown',
        'avatar': 'https://i.pravatar.cc/150?img=6',
        'points': 7200,
        'sessions': 30,
      },
      {
        'rank': 7,
        'name': 'Lisa Wilson',
        'avatar': 'https://i.pravatar.cc/150?img=7',
        'points': 6900,
        'sessions': 28,
      },
    ];

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
                'Leaderboard',
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
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: periods.map((period) {
                  final isSelected = selectedPeriod.value == period;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(period),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) selectedPeriod.value = period;
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
          // Top 3 Podium
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.scale(
                      scale: 0.9 + (0.1 * value),
                      child: child,
                    ),
                  );
                },
                child: _PodiumWidget(topUsers: topUsers),
              ),
            ),
          ),
          const SliverGap(24),
          // Other Rankings
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final user = otherUsers[index];
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
                  child: _RankingCard(user: user),
                );
              }, childCount: otherUsers.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
    );
  }
}

class _PodiumWidget extends StatelessWidget {
  final List<Map<String, dynamic>> topUsers;

  const _PodiumWidget({required this.topUsers});

  @override
  Widget build(BuildContext context) {
    // Reorder to show 2nd, 1st, 3rd
    final orderedUsers = [topUsers[0], topUsers[1], topUsers[2]];
    final heights = [180.0, 220.0, 160.0];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: orderedUsers.asMap().entries.map((entry) {
        final index = entry.key;
        final user = entry.value;
        final height = heights[index];

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                // Avatar
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: user['color'] as Color, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: (user['color'] as Color).withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: index == 1 ? 40 : 32,
                    backgroundImage: NetworkImage(user['avatar'] as String),
                  ),
                ),
                const Gap(8),
                Text(
                  user['badge'] as String,
                  style: TextStyle(fontSize: index == 1 ? 32 : 24),
                ),
                const Gap(4),
                Text(
                  (user['name'] as String).split(' ')[0],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: index == 1 ? 14 : 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                Text(
                  '${user['points']} pts',
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const Gap(12),
                // Podium
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      height: height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            (user['color'] as Color).withValues(alpha: 0.3),
                            (user['color'] as Color).withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        border: Border.all(
                          color: (user['color'] as Color).withValues(
                            alpha: 0.5,
                          ),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '#${user['rank']}',
                          style: TextStyle(
                            fontSize: index == 1 ? 48 : 36,
                            fontWeight: FontWeight.bold,
                            color: user['color'] as Color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _RankingCard extends StatelessWidget {
  final Map<String, dynamic> user;

  const _RankingCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Rank
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(
                          context,
                        ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                        Theme.of(
                          context,
                        ).colorScheme.primaryContainer.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '#${user['rank']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const Gap(16),
                // Avatar
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(user['avatar'] as String),
                ),
                const Gap(16),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        '${user['sessions']} sessions',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                // Points
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${user['points']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      'points',
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
