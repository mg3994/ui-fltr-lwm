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
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Resources'),
        actions: [
          IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Category Filters
          SingleChildScrollView(
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
                  ),
                );
              }).toList(),
            ),
          ),

          // Resources List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: resources.length,
              itemBuilder: (context, index) {
                final resource = resources[index];
                return _ResourceCard(resource: resource);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final Map<String, dynamic> resource;

  const _ResourceCard({required this.resource});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (resource['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  resource['icon'] as IconData,
                  color: resource['color'] as Color,
                  size: 32,
                ),
              ),
              const Gap(16),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resource['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      resource['author'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const Gap(4),
                        Text(
                          '${resource['rating']}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Gap(16),
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const Gap(4),
                        Text(
                          resource['duration'] as String,
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

              // Bookmark
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
