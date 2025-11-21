import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class CodeReviewScreen extends HookWidget {
  const CodeReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);
    final tabs = ['Pending', 'In Review', 'Completed'];

    final reviews = [
      {
        'title': 'Flutter Authentication Module',
        'language': 'Dart',
        'lines': 234,
        'status': 'pending',
        'priority': 'High',
        'submittedBy': 'You',
        'submittedAt': '2 hours ago',
        'color': Colors.red,
        'icon': Icons.code,
      },
      {
        'title': 'REST API Integration',
        'language': 'TypeScript',
        'lines': 156,
        'status': 'inreview',
        'priority': 'Medium',
        'submittedBy': 'You',
        'submittedAt': '1 day ago',
        'reviewer': 'Sarah Johnson',
        'color': Colors.orange,
        'icon': Icons.api,
      },
      {
        'title': 'Database Migration Script',
        'language': 'SQL',
        'lines': 89,
        'status': 'completed',
        'priority': 'Low',
        'submittedBy': 'You',
        'submittedAt': '3 days ago',
        'reviewer': 'Michael Chen',
        'feedback': 'Great work! Just a few minor suggestions.',
        'color': Colors.green,
        'icon': Icons.storage,
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
                'Code Reviews',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan.withValues(alpha: 0.3),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
              const Gap(8),
            ],
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
                    selectedColor: Colors.cyan.withValues(alpha: 0.2),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.cyan
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
                final review = reviews[index];
                final status = review['status'] as String;

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + index * 100),
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(-30 * (1 - value), 0),
                      child: child,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (review['color'] as Color).withValues(alpha: 0.05),
                          Theme.of(context).colorScheme.surface,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: (review['color'] as Color).withValues(
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
                                      color: (review['color'] as Color)
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      review['icon'] as IconData,
                                      color: review['color'] as Color,
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
                                          review['title'] as String,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Gap(4),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surfaceContainerHighest,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                review['language'] as String,
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                            const Gap(8),
                                            Text(
                                              '${review['lines']} lines',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (review['color'] as Color)
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      review['priority'] as String,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: review['color'] as Color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(16),
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 14,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                  const Gap(4),
                                  Text(
                                    review['submittedAt'] as String,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  if (review.containsKey('reviewer')) ...[
                                    const Gap(16),
                                    Icon(
                                      Icons.person,
                                      size: 14,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                    const Gap(4),
                                    Text(
                                      'Reviewer: ${review['reviewer']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              if (review.containsKey('feedback')) ...[
                                const Gap(12),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.green.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                      const Gap(8),
                                      Expanded(
                                        child: Text(
                                          review['feedback'] as String,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: (review['color'] as Color).withValues(
                              alpha: 0.05,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              bottomRight: Radius.circular(22),
                            ),
                          ),
                          child: Row(
                            children: [
                              if (status == 'completed')
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.visibility,
                                      size: 16,
                                    ),
                                    label: const Text('View Feedback'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: review['color'] as Color,
                                    ),
                                  ),
                                )
                              else if (status == 'inreview')
                                Expanded(
                                  child: FilledButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.chat, size: 16),
                                    label: const Text('Discuss'),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: review['color'] as Color,
                                    ),
                                  ),
                                )
                              else
                                Expanded(
                                  child: FilledButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.send, size: 16),
                                    label: const Text('Submit'),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: review['color'] as Color,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: reviews.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.upload_file),
        label: const Text('Request Review'),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
      ),
    );
  }
}
