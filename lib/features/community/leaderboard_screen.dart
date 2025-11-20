import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class LeaderboardScreen extends HookWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0); // 0: Mentors, 1: Mentees

    final topMentors = [
      {
        'rank': 1,
        'name': 'Sarah Jenkins',
        'avatar': 'https://i.pravatar.cc/150?u=1',
        'points': 2850,
        'sessions': 142,
        'rating': 4.9,
        'badge': '🏆',
      },
      {
        'rank': 2,
        'name': 'Michael Brown',
        'avatar': 'https://i.pravatar.cc/150?u=4',
        'points': 2640,
        'sessions': 128,
        'rating': 5.0,
        'badge': '🥈',
      },
      {
        'rank': 3,
        'name': 'David Chen',
        'avatar': 'https://i.pravatar.cc/150?u=2',
        'points': 2420,
        'sessions': 115,
        'rating': 4.8,
        'badge': '🥉',
      },
      {
        'rank': 4,
        'name': 'Emily Davis',
        'avatar': 'https://i.pravatar.cc/150?u=3',
        'points': 2180,
        'sessions': 98,
        'rating': 4.7,
        'badge': '',
      },
      {
        'rank': 5,
        'name': 'Alex Kumar',
        'avatar': 'https://i.pravatar.cc/150?u=5',
        'points': 1950,
        'sessions': 87,
        'rating': 4.8,
        'badge': '',
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SegmentedButton<int>(
                segments: const [
                  ButtonSegment(
                    value: 0,
                    label: Text('Top Mentors'),
                    icon: Icon(Icons.school),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('Top Learners'),
                    icon: Icon(Icons.emoji_events),
                  ),
                ],
                selected: {selectedTab.value},
                onSelectionChanged: (newSelection) {
                  selectedTab.value = newSelection.first;
                },
                style: ButtonStyle(
                  side: WidgetStateProperty.all(
                    BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (topMentors.length >= 3)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _PodiumCard(user: topMentors[1], height: 120),
                    _PodiumCard(user: topMentors[0], height: 150),
                    _PodiumCard(user: topMentors[2], height: 100),
                  ],
                ),
              ),
            ),
          const SliverGap(16),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final user = topMentors[index];
                return _LeaderboardCard(user: user);
              }, childCount: topMentors.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
    );
  }
}

class _PodiumCard extends StatelessWidget {
  final Map<String, dynamic> user;
  final double height;

  const _PodiumCard({required this.user, required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.3),
                  width: 3,
                ),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user['avatar'] as String),
              ),
            ),
            if ((user['badge'] as String).isNotEmpty)
              Positioned(
                top: -5,
                child: Text(
                  user['badge'] as String,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
          ],
        ),
        const Gap(8),
        Text(
          user['name'] as String,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          textAlign: TextAlign.center,
        ),
        const Gap(4),
        Text(
          '${user['points']} pts',
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(8),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(
                  context,
                ).colorScheme.primaryContainer.withValues(alpha: 0.5),
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '#${user['rank']}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LeaderboardCard extends StatelessWidget {
  final Map<String, dynamic> user;

  const _LeaderboardCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final rank = user['rank'] as int;
    final isTopThree = rank <= 3;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isTopThree
            ? Theme.of(
                context,
              ).colorScheme.primaryContainer.withValues(alpha: 0.3)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isTopThree
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)
              : Theme.of(
                  context,
                ).colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isTopThree
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '#$rank',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: isTopThree
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const Gap(12),
            CircleAvatar(
              backgroundImage: NetworkImage(user['avatar'] as String),
            ),
          ],
        ),
        title: Text(
          user['name'] as String,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.star, size: 14, color: Colors.amber),
            const Gap(4),
            Text('${user['rating']}'),
            const Gap(12),
            Icon(
              Icons.video_call,
              size: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const Gap(4),
            Text('${user['sessions']} sessions'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${user['points']}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
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
      ),
    );
  }
}
