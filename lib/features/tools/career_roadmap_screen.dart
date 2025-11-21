import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class CareerRoadmapScreen extends HookWidget {
  const CareerRoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roadmapSteps = [
      {
        'title': 'Junior Developer',
        'status': 'completed',
        'skills': ['HTML/CSS', 'JavaScript', 'Git'],
        'duration': '6 months',
        'color': Colors.green,
      },
      {
        'title': 'Mid-Level Developer',
        'status': 'current',
        'skills': ['Flutter', 'React', 'API Design'],
        'duration': '1 year',
        'color': Colors.blue,
      },
      {
        'title': 'Senior Developer',
        'status': 'upcoming',
        'skills': ['System Design', 'Leadership', 'Architecture'],
        'duration': '2 years',
        'color': Colors.orange,
      },
      {
        'title': 'Tech Lead',
        'status': 'future',
        'skills': ['Team Management', 'Strategy', 'Mentoring'],
        'duration': '3+ years',
        'color': Colors.purple,
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepPurple.withValues(alpha: 0.3),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Career Roadmap',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        'Your journey to success',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final step = roadmapSteps[index];
                final isCompleted = step['status'] == 'completed';
                final isCurrent = step['status'] == 'current';
                final isLast = index == roadmapSteps.length - 1;

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + index * 100),
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(-50 * (1 - value), 0),
                      child: child,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isCompleted || isCurrent
                                  ? (step['color'] as Color)
                                  : Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHighest,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: (step['color'] as Color),
                                width: 3,
                              ),
                            ),
                            child: Icon(
                              isCompleted
                                  ? Icons.check
                                  : isCurrent
                                  ? Icons.play_arrow
                                  : Icons.lock_outline,
                              color: isCompleted || isCurrent
                                  ? Colors.white
                                  : Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 3,
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    step['color'] as Color,
                                    roadmapSteps[index + 1]['color'] as Color,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const Gap(16),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                (step['color'] as Color).withValues(alpha: 0.1),
                                Theme.of(context).colorScheme.surface,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: (step['color'] as Color).withValues(
                                alpha: 0.3,
                              ),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      step['title'] as String,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (step['color'] as Color)
                                          .withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      step['duration'] as String,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: step['color'] as Color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(12),
                              Text(
                                'Key Skills:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const Gap(8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: (step['skills'] as List<String>).map((
                                  skill,
                                ) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerHighest,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      skill,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  );
                                }).toList(),
                              ),
                              if (isCurrent) ...[
                                const Gap(12),
                                LinearProgressIndicator(
                                  value: 0.65,
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHighest,
                                  valueColor: AlwaysStoppedAnimation(
                                    step['color'] as Color,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                const Gap(4),
                                const Text(
                                  '65% Complete',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: roadmapSteps.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
    );
  }
}
