import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class MockInterviewScreen extends HookWidget {
  const MockInterviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final interviews = [
      {
        'title': 'Google SWE Interview',
        'company': 'Google',
        'difficulty': 'Hard',
        'duration': '60 min',
        'topics': ['DSA', 'System Design', 'Behavioral'],
        'completed': false,
        'color': Colors.blue,
        'logo': '🔵',
      },
      {
        'title': 'Meta Frontend Round',
        'company': 'Meta',
        'difficulty': 'Medium',
        'duration': '45 min',
        'topics': ['React', 'JavaScript', 'CSS'],
        'completed': false,
        'color': Colors.indigo,
        'logo': '🔷',
      },
      {
        'title': 'Amazon Behavioral',
        'company': 'Amazon',
        'difficulty': 'Medium',
        'duration': '30 min',
        'topics': ['Leadership Principles', 'STAR Method'],
        'completed': true,
        'score': 85,
        'color': Colors.orange,
        'logo': '🟠',
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.withValues(alpha: 0.3),
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
                        'Mock Interviews',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '🎯 Practice Makes Perfect',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const Gap(12),
                      Row(
                        children: [
                          _StatBox(
                            label: 'Completed',
                            value: '12',
                            color: Colors.green,
                          ),
                          const Gap(12),
                          _StatBox(
                            label: 'Avg Score',
                            value: '87%',
                            color: Colors.blue,
                          ),
                          const Gap(12),
                          _StatBox(
                            label: 'This Week',
                            value: '3',
                            color: Colors.orange,
                          ),
                        ],
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
                final interview = interviews[index];
                final isCompleted = interview['completed'] as bool;

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + index * 100),
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (interview['color'] as Color).withValues(alpha: 0.05),
                          Theme.of(context).colorScheme.surface,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: (interview['color'] as Color).withValues(
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
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: (interview['color'] as Color)
                                          .withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      interview['logo'] as String,
                                      style: const TextStyle(fontSize: 28),
                                    ),
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                interview['title'] as String,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            if (isCompleted)
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Colors.green
                                                      .withValues(alpha: 0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Icon(
                                                      Icons.check_circle,
                                                      size: 14,
                                                      color: Colors.green,
                                                    ),
                                                    const Gap(4),
                                                    Text(
                                                      '${interview['score']}%',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                        const Gap(4),
                                        Text(
                                          interview['company'] as String,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: interview['color'] as Color,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(16),
                              Row(
                                children: [
                                  _InfoChip(
                                    icon: Icons.timer,
                                    label: interview['duration'] as String,
                                    color: interview['color'] as Color,
                                  ),
                                  const Gap(8),
                                  _InfoChip(
                                    icon: Icons.trending_up,
                                    label: interview['difficulty'] as String,
                                    color: interview['color'] as Color,
                                  ),
                                ],
                              ),
                              const Gap(12),
                              const Text(
                                'Topics:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: (interview['topics'] as List<String>)
                                    .map((topic) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.surfaceContainerHighest,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          topic,
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                      );
                                    })
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: (interview['color'] as Color).withValues(
                              alpha: 0.05,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              bottomRight: Radius.circular(22),
                            ),
                          ),
                          child: Row(
                            children: [
                              if (isCompleted)
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.replay, size: 16),
                                    label: const Text('Retake'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor:
                                          interview['color'] as Color,
                                    ),
                                  ),
                                )
                              else
                                Expanded(
                                  child: FilledButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      size: 18,
                                    ),
                                    label: const Text('Start Interview'),
                                    style: FilledButton.styleFrom(
                                      backgroundColor:
                                          interview['color'] as Color,
                                    ),
                                  ),
                                ),
                              if (isCompleted) ...[
                                const Gap(12),
                                Expanded(
                                  child: FilledButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.analytics, size: 16),
                                    label: const Text('View Report'),
                                    style: FilledButton.styleFrom(
                                      backgroundColor:
                                          interview['color'] as Color,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: interviews.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Custom Interview'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatBox({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
