import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class ResourcesScreen extends HookWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCategory = useState('All');
    final categories = ['All', 'Articles', 'Videos', 'Courses', 'Books'];

    final resources = [
      {
        'title': 'Flutter Complete Guide 2024',
        'type': 'Course',
        'author': 'Maximilian Schwarzmüller',
        'rating': 4.8,
        'duration': '42 hours',
        'icon': Icons.play_circle_outline,
        'color': Colors.red,
      },
      {
        'title': 'Clean Architecture in Flutter',
        'type': 'Article',
        'author': 'Robert C. Martin',
        'rating': 4.9,
        'duration': '15 min read',
        'icon': Icons.article_outlined,
        'color': Colors.blue,
      },
      {
        'title': 'State Management Patterns',
        'type': 'Video',
        'author': 'Reso Coder',
        'rating': 4.7,
        'duration': '45 min',
        'icon': Icons.video_library_outlined,
        'color': Colors.purple,
      },
      {
        'title': 'Flutter in Action',
        'type': 'Book',
        'author': 'Eric Windmill',
        'rating': 4.6,
        'duration': '450 pages',
        'icon': Icons.menu_book_outlined,
        'color': Colors.orange,
      },
      {
        'title': 'Advanced Dart Programming',
        'type': 'Course',
        'author': 'Angela Yu',
        'rating': 4.9,
        'duration': '28 hours',
        'icon': Icons.play_circle_outline,
        'color': Colors.green,
      },
      {
        'title': 'Firebase Integration Guide',
        'type': 'Article',
        'author': 'Jeff Delaney',
        'rating': 4.7,
        'duration': '20 min read',
        'icon': Icons.article_outlined,
        'color': Colors.amber,
      },
    ];

    final filteredResources = selectedCategory.value == 'All'
        ? resources
        : resources
              .where(
                (r) =>
                    (r['type'] as String).toLowerCase() ==
                    selectedCategory.value.toLowerCase().replaceAll('s', ''),
              )
              .toList();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              pinned: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              surfaceTintColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                title: Text(
                  'Learning Resources',
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
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.5),
                  ),
                ),
                const Gap(8),
              ],
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: categories.map((category) {
                    final isSelected = selectedCategory.value == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) selectedCategory.value = category;
                        },
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        selectedColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? Colors.transparent
                              : Theme.of(context).colorScheme.outlineVariant
                                    .withValues(alpha: 0.5),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final resource = filteredResources[index];
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 300 + (index * 100)),
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
                    child: _ResourceCard(resource: resource),
                  );
                }, childCount: filteredResources.length),
              ),
            ),
            const SliverGap(80),
          ],
        ),
      ),
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final Map<String, dynamic> resource;

  const _ResourceCard({required this.resource});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
            gradient: LinearGradient(
              colors: [
                (resource['color'] as Color).withValues(alpha: 0.05),
                Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon with gradient background
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (resource['color'] as Color).withValues(alpha: 0.2),
                          (resource['color'] as Color).withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      resource['icon'] as IconData,
                      color: resource['color'] as Color,
                      size: 32,
                    ),
                  ),
                  const Gap(12),

                  // Title
                  Text(
                    resource['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),

                  // Author
                  Text(
                    resource['author'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),

                  // Rating and Duration
                  Row(
                    children: [
                      const Icon(Icons.star, size: 12, color: Colors.amber),
                      const Gap(4),
                      Text(
                        '${resource['rating']}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const Gap(4),
                      Expanded(
                        child: Text(
                          resource['duration'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
