import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class GoalsScreen extends HookWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final goals = useState<List<Map<String, dynamic>>>([
      {
        'title': 'Complete 10 mentoring sessions',
        'progress': 7,
        'total': 10,
        'category': 'Sessions',
        'icon': Icons.video_call,
        'color': Colors.blue,
      },
      {
        'title': 'Build a portfolio project',
        'progress': 3,
        'total': 5,
        'category': 'Projects',
        'icon': Icons.code,
        'color': Colors.purple,
      },
      {
        'title': 'Learn Flutter animations',
        'progress': 2,
        'total': 8,
        'category': 'Learning',
        'icon': Icons.school,
        'color': Colors.orange,
      },
    ]);

    return Scaffold(
      appBar: AppBar(title: const Text('My Goals')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddGoalDialog(context, goals);
        },
        icon: const Icon(Icons.add),
        label: const Text('New Goal'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Overall Progress
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overall Progress',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Gap(16),
                  LinearProgressIndicator(
                    value: 0.65,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const Gap(8),
                  const Text(
                    '65% Complete',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          const Gap(24),

          // Goals List
          ...goals.value.map(
            (goal) => _GoalCard(
              goal: goal,
              onDelete: () {
                goals.value = goals.value.where((g) => g != goal).toList();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddGoalDialog(
    BuildContext context,
    ValueNotifier<List<Map<String, dynamic>>> goals,
  ) {
    final titleController = TextEditingController();
    final targetController = TextEditingController(text: '10');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Goal Title',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(16),
            TextField(
              controller: targetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Target',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                goals.value = [
                  ...goals.value,
                  {
                    'title': titleController.text,
                    'progress': 0,
                    'total': int.tryParse(targetController.text) ?? 10,
                    'category': 'Custom',
                    'icon': Icons.flag,
                    'color': Colors.green,
                  },
                ];
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final Map<String, dynamic> goal;
  final VoidCallback onDelete;

  const _GoalCard({required this.goal, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final progress = goal['progress'] as int;
    final total = goal['total'] as int;
    final percentage = progress / total;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (goal['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    goal['icon'] as IconData,
                    color: goal['color'] as Color,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        goal['category'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                  color: Colors.red,
                ),
              ],
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$progress / $total'),
                Text('${(percentage * 100).toInt()}%'),
              ],
            ),
            const Gap(8),
            LinearProgressIndicator(
              value: percentage,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
            ),
          ],
        ),
      ),
    );
  }
}
