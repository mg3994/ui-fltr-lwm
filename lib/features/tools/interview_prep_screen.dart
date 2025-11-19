import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class InterviewPrepScreen extends HookWidget {
  const InterviewPrepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'Technical Questions',
        'icon': Icons.code,
        'color': Colors.blue,
        'count': 150,
        'completed': 45,
      },
      {
        'title': 'Behavioral Questions',
        'icon': Icons.psychology,
        'color': Colors.purple,
        'count': 80,
        'completed': 20,
      },
      {
        'title': 'System Design',
        'icon': Icons.architecture,
        'color': Colors.orange,
        'count': 60,
        'completed': 15,
      },
      {
        'title': 'Coding Challenges',
        'icon': Icons.terminal,
        'color': Colors.green,
        'count': 200,
        'completed': 75,
      },
    ];

    final recentQuestions = [
      {
        'question':
            'Explain the difference between StatefulWidget and StatelessWidget',
        'category': 'Technical',
        'difficulty': 'Easy',
        'answered': true,
      },
      {
        'question': 'How do you handle state management in Flutter?',
        'category': 'Technical',
        'difficulty': 'Medium',
        'answered': true,
      },
      {
        'question': 'Tell me about a time you faced a challenging bug',
        'category': 'Behavioral',
        'difficulty': 'Medium',
        'answered': false,
      },
      {
        'question': 'Design a scalable chat application',
        'category': 'System Design',
        'difficulty': 'Hard',
        'answered': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Interview Prep')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Progress Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Progress',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Gap(16),
                  LinearProgressIndicator(
                    value: 0.35,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  const Gap(8),
                  const Text('155 / 490 questions completed'),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatColumn(
                        label: 'Streak',
                        value: '7 days',
                        icon: Icons.local_fire_department,
                        color: Colors.orange,
                      ),
                      _StatColumn(
                        label: 'This Week',
                        value: '12',
                        icon: Icons.calendar_today,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Gap(24),

          // Categories
          const Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(16),

          ...categories.map((category) => _CategoryCard(category: category)),

          const Gap(24),

          // Recent Questions
          const Text(
            'Continue Practicing',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(16),

          ...recentQuestions.map(
            (question) => _QuestionCard(question: question),
          ),
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
        Icon(icon, color: color, size: 32),
        const Gap(8),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

class _CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final completed = category['completed'] as int;
    final total = category['count'] as int;
    final progress = completed / total;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (category['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category['icon'] as IconData,
                  color: category['color'] as Color,
                  size: 28,
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(8),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    const Gap(4),
                    Text(
                      '$completed / $total completed',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final Map<String, dynamic> question;

  const _QuestionCard({required this.question});

  @override
  Widget build(BuildContext context) {
    final answered = question['answered'] as bool;
    final difficulty = question['difficulty'] as String;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(difficulty).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      difficulty,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _getDifficultyColor(difficulty),
                      ),
                    ),
                  ),
                  const Gap(8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      question['category'] as String,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  const Spacer(),
                  if (answered)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                ],
              ),
              const Gap(12),
              Text(
                question['question'] as String,
                style: const TextStyle(fontSize: 15),
              ),
              const Gap(12),
              FilledButton.icon(
                onPressed: () {},
                icon: Icon(answered ? Icons.replay : Icons.play_arrow),
                label: Text(answered ? 'Review Answer' : 'Practice'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return Colors.green;
      case 'Medium':
        return Colors.orange;
      case 'Hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
