import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class QuickActionsScreen extends HookWidget {
  const QuickActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {
        'title': 'Schedule Session',
        'description': 'Book a mentorship session',
        'icon': Icons.video_call,
        'color': Colors.blue,
      },
      {
        'title': 'Ask Question',
        'description': 'Get help from mentors',
        'icon': Icons.question_answer,
        'color': Colors.purple,
      },
      {
        'title': 'Share Progress',
        'description': 'Update your achievements',
        'icon': Icons.trending_up,
        'color': Colors.green,
      },
      {
        'title': 'Join Event',
        'description': 'Attend upcoming events',
        'icon': Icons.event,
        'color': Colors.orange,
      },
      {
        'title': 'Take Assessment',
        'description': 'Test your skills',
        'icon': Icons.quiz,
        'color': Colors.red,
      },
      {
        'title': 'Request Feedback',
        'description': 'Get code review',
        'icon': Icons.rate_review,
        'color': Colors.teal,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Quick Actions'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            final action = actions[index];

            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 300 + index * 80),
              builder: (context, value, child) => Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: 0.9 + (0.1 * value),
                  child: child,
                ),
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        (action['color'] as Color).withValues(alpha: 0.1),
                        Theme.of(context).colorScheme.surface,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: (action['color'] as Color).withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: (action['color'] as Color).withValues(
                              alpha: 0.2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            action['icon'] as IconData,
                            color: action['color'] as Color,
                            size: 32,
                          ),
                        ),
                        const Gap(12),
                        Text(
                          action['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          action['description'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
