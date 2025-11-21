import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class MilestonesScreen extends HookWidget {
  const MilestonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final milestones = [
      {
        'title': 'First Session Completed',
        'description': 'Completed your first mentorship session',
        'date': '2024-01-15',
        'icon': Icons.video_call,
        'color': Colors.blue,
        'completed': true,
      },
      {
        'title': '10 Sessions Milestone',
        'description': 'Reached 10 mentorship sessions',
        'date': '2024-02-20',
        'icon': Icons.star,
        'color': Colors.purple,
        'completed': true,
      },
      {
        'title': 'First Certification',
        'description': 'Earned your first certification',
        'date': '2024-03-01',
        'icon': Icons.school,
        'color': Colors.green,
        'completed': true,
      },
      {
        'title': '50 Sessions Goal',
        'description': '30/50 sessions completed',
        'date': 'In Progress',
        'icon': Icons.trending_up,
        'color': Colors.orange,
        'completed': false,
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                'Milestones',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.withValues(alpha: 0.2),
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
              delegate: SliverChildBuilderDelegate((context, index) {
                final milestone = milestones[index];
                final isCompleted = milestone['completed'] as bool;

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + index * 100),
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(30 * (1 - value), 0),
                      child: child,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isCompleted
                            ? (milestone['color'] as Color)
                            : Theme.of(context).colorScheme.outlineVariant
                                  .withValues(alpha: 0.5),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: (milestone['color'] as Color).withValues(
                              alpha: 0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            milestone['icon'] as IconData,
                            color: milestone['color'] as Color,
                            size: 32,
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      milestone['title'] as String,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  if (isCompleted)
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                ],
                              ),
                              const Gap(4),
                              Text(
                                milestone['description'] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const Gap(8),
                              Text(
                                milestone['date'] as String,
                                style: TextStyle(
                                  fontSize: 12,
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
                  ),
                );
              }, childCount: milestones.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
    );
  }
}
