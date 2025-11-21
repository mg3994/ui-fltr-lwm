import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class ChallengesScreen extends HookWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);
    final tabs = ['Active', 'Completed', 'All'];

    final challenges = [
      {
        'title': '30-Day Coding Streak',
        'description': 'Code at least 1 hour daily for 30 days',
        'progress': 22,
        'total': 30,
        'reward': 500,
        'participants': 1234,
        'color': Colors.orange,
        'icon': Icons.code,
        'active': true,
      },
      {
        'title': 'Complete 10 Sessions',
        'description': 'Finish 10 mentorship sessions',
        'progress': 7,
        'total': 10,
        'reward': 300,
        'participants': 856,
        'color': Colors.blue,
        'icon': Icons.video_call,
        'active': true,
      },
      {
        'title': 'Build 3 Projects',
        'description': 'Complete and showcase 3 projects',
        'progress': 2,
        'total': 3,
        'reward': 750,
        'participants': 456,
        'color': Colors.purple,
        'icon': Icons.rocket_launch,
        'active': true,
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
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
                      Colors.orange.withValues(alpha: 0.3),
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
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                separatorBuilder: (context, index) => const Gap(8),
                itemBuilder: (context, index) {
                  final isSelected = selectedTab.value == index;
                  return ChoiceChip(
                    label: Text(tabs[index]),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) selectedTab.value = index;
                    },
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    selectedColor: Colors.orange.withValues(alpha: 0.2),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.orange
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final challenge = challenges[index];
                final progress = challenge['progress'] as int;
                final total = challenge['total'] as int;
                final percentage = progress / total;

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + index * 100),
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.scale(
                      scale: 0.9 + (0.1 * value),
                      child: child,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (challenge['color'] as Color).withValues(alpha: 0.1),
                          Theme.of(context).colorScheme.surface,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: (challenge['color'] as Color).withValues(
                          alpha: 0.3,
                        ),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: (challenge['color'] as Color)
                                          .withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      challenge['icon'] as IconData,
                                      color: challenge['color'] as Color,
                                      size: 24,
                                    ),
                                  ),
                                  const Gap(12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          challenge['title'] as String,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Gap(4),
                                        Text(
                                          challenge['description'] as String,
                                          style: TextStyle(
                                            fontSize: 13,
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
                              const Gap(16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Progress',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  Text(
                                    '$progress/$total',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: challenge['color'] as Color,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(8),
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.0, end: percentage),
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeOut,
                                builder: (context, value, child) =>
                                    LinearProgressIndicator(
                                      value: value,
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerHighest,
                                      valueColor: AlwaysStoppedAnimation(
                                        challenge['color'] as Color,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                      minHeight: 8,
                                    ),
                              ),
                              const Gap(16),
                              Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    size: 16,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                  const Gap(4),
                                  Text(
                                    '${challenge['participants']} participants',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withValues(
                                        alpha: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.stars,
                                          size: 14,
                                          color: Colors.amber,
                                        ),
                                        const Gap(4),
                                        Text(
                                          '${challenge['reward']} pts',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: (challenge['color'] as Color).withValues(
                              alpha: 0.05,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              bottomRight: Radius.circular(22),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor:
                                        challenge['color'] as Color,
                                    side: BorderSide(
                                      color: (challenge['color'] as Color)
                                          .withValues(alpha: 0.5),
                                    ),
                                  ),
                                  child: const Text('Details'),
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: FilledButton(
                                  onPressed: () {},
                                  style: FilledButton.styleFrom(
                                    backgroundColor:
                                        challenge['color'] as Color,
                                  ),
                                  child: const Text('Continue'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: challenges.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.explore),
        label: const Text('Explore More'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
    );
  }
}
