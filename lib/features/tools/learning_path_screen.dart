import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class LearningPathScreen extends HookWidget {
  const LearningPathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPath = useState(0);

    final learningPaths = [
      {
        'id': 1,
        'title': 'Flutter Mastery',
        'description': 'Become a Flutter expert from basics to advanced',
        'progress': 0.65,
        'totalModules': 12,
        'completedModules': 8,
        'estimatedTime': '3 months',
        'difficulty': 'Intermediate',
        'color': Colors.blue,
        'modules': [
          {'name': 'Flutter Basics', 'completed': true, 'duration': '2 weeks'},
          {
            'name': 'State Management',
            'completed': true,
            'duration': '3 weeks',
          },
          {
            'name': 'Navigation & Routing',
            'completed': true,
            'duration': '1 week',
          },
          {'name': 'API Integration', 'completed': true, 'duration': '2 weeks'},
          {
            'name': 'Firebase Integration',
            'completed': false,
            'duration': '2 weeks',
          },
          {'name': 'Advanced UI/UX', 'completed': false, 'duration': '3 weeks'},
        ],
      },
      {
        'id': 2,
        'title': 'Mobile App Development',
        'description': 'Master cross-platform mobile development',
        'progress': 0.35,
        'totalModules': 10,
        'completedModules': 4,
        'estimatedTime': '4 months',
        'difficulty': 'Advanced',
        'color': Colors.purple,
        'modules': [
          {
            'name': 'Mobile Fundamentals',
            'completed': true,
            'duration': '2 weeks',
          },
          {
            'name': 'React Native Basics',
            'completed': true,
            'duration': '3 weeks',
          },
          {'name': 'Native Modules', 'completed': false, 'duration': '2 weeks'},
          {
            'name': 'Performance Optimization',
            'completed': false,
            'duration': '3 weeks',
          },
        ],
      },
      {
        'id': 3,
        'title': 'UI/UX Design',
        'description': 'Create beautiful and intuitive user interfaces',
        'progress': 0.80,
        'totalModules': 8,
        'completedModules': 6,
        'estimatedTime': '2 months',
        'difficulty': 'Beginner',
        'color': Colors.pink,
        'modules': [
          {
            'name': 'Design Principles',
            'completed': true,
            'duration': '1 week',
          },
          {'name': 'Color Theory', 'completed': true, 'duration': '1 week'},
          {'name': 'Typography', 'completed': true, 'duration': '1 week'},
          {'name': 'Prototyping', 'completed': false, 'duration': '2 weeks'},
        ],
      },
    ];

    final currentPath = learningPaths[selectedPath.value];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                'Learning Paths',
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
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withValues(alpha: 0.5),
                ),
              ),
              const Gap(8),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Path Selector
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: learningPaths.length,
                    separatorBuilder: (context, index) => const Gap(12),
                    itemBuilder: (context, index) {
                      final path = learningPaths[index];
                      final isSelected = selectedPath.value == index;
                      return InkWell(
                        onTap: () => selectedPath.value = index,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (path['color'] as Color).withValues(
                                    alpha: 0.15,
                                  )
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? (path['color'] as Color)
                                  : Theme.of(context).colorScheme.outlineVariant
                                        .withValues(alpha: 0.5),
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: (path['color'] as Color)
                                          .withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: (path['color'] as Color)
                                          .withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.school,
                                      color: path['color'] as Color,
                                      size: 20,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${((path['progress'] as double) * 100).toInt()}%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: path['color'] as Color,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(8),
                              Text(
                                path['title'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Gap(4),
                              LinearProgressIndicator(
                                value: path['progress'] as double,
                                minHeight: 4,
                                borderRadius: BorderRadius.circular(2),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                                color: path['color'] as Color,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Gap(24),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Path Overview Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        (currentPath['color'] as Color).withValues(alpha: 0.1),
                        (currentPath['color'] as Color).withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: (currentPath['color'] as Color).withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              currentPath['title'] as String,
                              style: const TextStyle(
                                fontSize: 24,
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
                              color: (currentPath['color'] as Color).withValues(
                                alpha: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              currentPath['difficulty'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: currentPath['color'] as Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      Text(
                        currentPath['description'] as String,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          _InfoChip(
                            icon: Icons.book_outlined,
                            label:
                                '${currentPath['completedModules']}/${currentPath['totalModules']} Modules',
                            color: currentPath['color'] as Color,
                          ),
                          const Gap(12),
                          _InfoChip(
                            icon: Icons.access_time,
                            label: currentPath['estimatedTime'] as String,
                            color: currentPath['color'] as Color,
                          ),
                        ],
                      ),
                      const Gap(16),
                      LinearProgressIndicator(
                        value: currentPath['progress'] as double,
                        minHeight: 12,
                        borderRadius: BorderRadius.circular(6),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        color: currentPath['color'] as Color,
                      ),
                    ],
                  ),
                ),

                const Gap(24),

                // Modules Section
                Text(
                  'Learning Modules',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(16),

                ...(currentPath['modules'] as List).asMap().entries.map((
                  entry,
                ) {
                  final index = entry.key;
                  final module = entry.value as Map<String, dynamic>;
                  final isCompleted = module['completed'] as bool;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isCompleted
                            ? (currentPath['color'] as Color).withValues(
                                alpha: 0.3,
                              )
                            : Theme.of(context).colorScheme.outlineVariant
                                  .withValues(alpha: 0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).shadowColor.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? (currentPath['color'] as Color).withValues(
                                  alpha: 0.15,
                                )
                              : Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isCompleted
                              ? Icon(
                                  Icons.check_circle,
                                  color: currentPath['color'] as Color,
                                  size: 24,
                                )
                              : Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                        ),
                      ),
                      title: Text(
                        module['name'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          const Gap(4),
                          Text(
                            module['duration'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      trailing: isCompleted
                          ? null
                          : FilledButton(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                backgroundColor: currentPath['color'] as Color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: const Text('Start'),
                            ),
                    ),
                  );
                }),

                const Gap(80),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.play_arrow),
        label: const Text('Continue Learning'),
        backgroundColor: currentPath['color'] as Color,
        elevation: 2,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const Gap(6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
