import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class SkillAssessmentScreen extends HookWidget {
  const SkillAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final assessments = [
      {
        'skill': 'Flutter Development',
        'level': 'Advanced',
        'score': 85,
        'questions': 20,
        'completed': true,
        'date': 'Jan 15, 2024',
        'color': Colors.blue,
      },
      {
        'skill': 'Dart Programming',
        'level': 'Expert',
        'score': 92,
        'questions': 25,
        'completed': true,
        'date': 'Jan 10, 2024',
        'color': Colors.teal,
      },
      {
        'skill': 'UI/UX Design',
        'level': 'Intermediate',
        'score': 68,
        'questions': 15,
        'completed': true,
        'date': 'Dec 28, 2023',
        'color': Colors.purple,
      },
      {
        'skill': 'State Management',
        'level': 'Not Started',
        'score': 0,
        'questions': 18,
        'completed': false,
        'color': Colors.orange,
      },
      {
        'skill': 'Firebase Integration',
        'level': 'Not Started',
        'score': 0,
        'questions': 22,
        'completed': false,
        'color': Colors.amber,
      },
    ];

    final completedCount = assessments
        .where((a) => a['completed'] == true)
        .length;
    final averageScore = completedCount > 0
        ? assessments
                  .where((a) => a['completed'] == true)
                  .fold<int>(0, (sum, a) => sum + (a['score'] as int)) /
              completedCount
        : 0.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Skill Assessment')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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
            child: Card(
              elevation: 4,
              shadowColor: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.surface,
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatColumn(
                      label: 'Completed',
                      value: '$completedCount/${assessments.length}',
                      icon: Icons.check_circle,
                      color: Colors.green,
                    ),
                    Container(
                      width: 1,
                      height: 50,
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    _StatColumn(
                      label: 'Avg Score',
                      value: '${averageScore.toInt()}%',
                      icon: Icons.star,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Gap(32),

          const Text(
            'Available Assessments',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(16),

          // Assessments List
          ...assessments.asMap().entries.map((entry) {
            final index = entry.key;
            final assessment = entry.value;
            final completed = assessment['completed'] as bool;
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
              child: _AssessmentCard(
                assessment: assessment,
                completed: completed,
              ),
            );
          }),
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
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
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

class _AssessmentCard extends StatelessWidget {
  final Map<String, dynamic> assessment;
  final bool completed;

  const _AssessmentCard({required this.assessment, required this.completed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (assessment['color'] as Color).withValues(
                        alpha: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      completed ? Icons.verified : Icons.quiz,
                      color: assessment['color'] as Color,
                      size: 28,
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assessment['skill'] as String,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          '${assessment['questions']} questions',
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
                  if (completed)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getScoreColor(
                          assessment['score'] as int,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${assessment['score']}%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _getScoreColor(assessment['score'] as int),
                        ),
                      ),
                    ),
                ],
              ),
              if (completed) ...[
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Level: ${assessment['level']}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const Gap(4),
                          Text(
                            'Completed on ${assessment['date']}',
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
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('Retake'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                const Gap(20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      // Navigate to assessment
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start Assessment'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }
}
