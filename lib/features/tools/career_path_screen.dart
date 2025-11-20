import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class CareerPathScreen extends HookWidget {
  const CareerPathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final careerPaths = [
      {
        'title': 'Mobile Developer',
        'description': 'Build native and cross-platform mobile applications',
        'level': 'Intermediate',
        'duration': '6-12 months',
        'skills': ['Flutter', 'Dart', 'Firebase', 'REST APIs'],
        'salary': '\$70k - \$120k',
        'jobs': 1250,
        'color': Colors.blue,
        'icon': Icons.phone_android,
      },
      {
        'title': 'Full Stack Developer',
        'description': 'Master both frontend and backend development',
        'level': 'Advanced',
        'duration': '12-18 months',
        'skills': ['React', 'Node.js', 'MongoDB', 'AWS'],
        'salary': '\$80k - \$140k',
        'jobs': 2100,
        'color': Colors.purple,
        'icon': Icons.code,
      },
      {
        'title': 'UI/UX Designer',
        'description': 'Create beautiful and intuitive user experiences',
        'level': 'Beginner',
        'duration': '4-8 months',
        'skills': ['Figma', 'Adobe XD', 'Prototyping', 'User Research'],
        'salary': '\$60k - \$100k',
        'jobs': 890,
        'color': Colors.pink,
        'icon': Icons.palette,
      },
      {
        'title': 'DevOps Engineer',
        'description': 'Automate and optimize development workflows',
        'level': 'Advanced',
        'duration': '10-15 months',
        'skills': ['Docker', 'Kubernetes', 'CI/CD', 'AWS'],
        'salary': '\$90k - \$150k',
        'jobs': 1560,
        'color': Colors.orange,
        'icon': Icons.settings_applications,
      },
      {
        'title': 'Data Scientist',
        'description': 'Analyze data and build machine learning models',
        'level': 'Advanced',
        'duration': '12-24 months',
        'skills': ['Python', 'TensorFlow', 'SQL', 'Statistics'],
        'salary': '\$95k - \$160k',
        'jobs': 1780,
        'color': Colors.green,
        'icon': Icons.analytics,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Career Paths')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Explore Your Future',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          Text(
            'Choose a career path and get personalized mentorship',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const Gap(24),

          // Career Paths
          ...careerPaths.map((path) => _CareerPathCard(path: path)),
        ],
      ),
    );
  }
}

class _CareerPathCard extends StatelessWidget {
  final Map<String, dynamic> path;

  const _CareerPathCard({required this.path});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          // Navigate to detailed career path
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (path['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      path['icon'] as IconData,
                      color: path['color'] as Color,
                      size: 32,
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          path['title'] as String,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getLevelColor(
                              path['level'] as String,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            path['level'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _getLevelColor(path['level'] as String),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(16),
              Text(
                path['description'] as String,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const Gap(16),

              // Skills
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (path['skills'] as List<String>).map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(skill, style: const TextStyle(fontSize: 12)),
                  );
                }).toList(),
              ),

              const Gap(16),
              const Divider(),
              const Gap(12),

              // Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _InfoChip(
                    icon: Icons.schedule,
                    label: path['duration'] as String,
                  ),
                  _InfoChip(
                    icon: Icons.attach_money,
                    label: path['salary'] as String,
                  ),
                  _InfoChip(icon: Icons.work, label: '${path['jobs']} jobs'),
                ],
              ),

              const Gap(16),

              // Action Button
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Start Learning'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 44),
                  backgroundColor: path['color'] as Color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case 'Beginner':
        return Colors.green;
      case 'Intermediate':
        return Colors.orange;
      case 'Advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const Gap(4),
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

