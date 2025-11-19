import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class SavedItemsScreen extends HookWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0); // 0: Mentors, 1: Resources, 2: Posts

    final savedMentors = [
      {
        'name': 'Sarah Jenkins',
        'title': 'Senior Flutter Developer',
        'avatar': 'https://i.pravatar.cc/150?u=1',
        'rating': 4.9,
        'rate': 50,
      },
      {
        'name': 'David Chen',
        'title': 'Product Designer',
        'avatar': 'https://i.pravatar.cc/150?u=2',
        'rating': 4.8,
        'rate': 45,
      },
    ];

    final savedResources = [
      {
        'title': 'Flutter Complete Guide 2024',
        'type': 'Course',
        'author': 'Maximilian Schwarzmüller',
        'icon': Icons.play_circle_outline,
        'color': Colors.red,
      },
      {
        'title': 'Clean Architecture in Flutter',
        'type': 'Article',
        'author': 'Robert C. Martin',
        'icon': Icons.article_outlined,
        'color': Colors.blue,
      },
    ];

    final savedPosts = [
      {
        'title': 'How to optimize Flutter performance?',
        'author': 'John Doe',
        'answers': 12,
        'upvotes': 24,
      },
      {
        'title': 'Best practices for state management',
        'author': 'Jane Smith',
        'answers': 8,
        'upvotes': 18,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Items')),
      body: Column(
        children: [
          // Tab Selector
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Mentors')),
                ButtonSegment(value: 1, label: Text('Resources')),
                ButtonSegment(value: 2, label: Text('Posts')),
              ],
              selected: {selectedTab.value},
              onSelectionChanged: (newSelection) {
                selectedTab.value = newSelection.first;
              },
            ),
          ),

          // Content
          Expanded(
            child: selectedTab.value == 0
                ? _buildMentorsList(savedMentors)
                : selectedTab.value == 1
                ? _buildResourcesList(savedResources)
                : _buildPostsList(savedPosts),
          ),
        ],
      ),
    );
  }

  Widget _buildMentorsList(List<Map<String, dynamic>> mentors) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mentors.length,
      itemBuilder: (context, index) {
        final mentor = mentors[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(mentor['avatar'] as String),
            ),
            title: Text(mentor['name'] as String),
            subtitle: Text(mentor['title'] as String),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const Gap(4),
                    Text('${mentor['rating']}'),
                  ],
                ),
                const Gap(4),
                Text(
                  '\$${mentor['rate']}/hr',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResourcesList(List<Map<String, dynamic>> resources) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: resources.length,
      itemBuilder: (context, index) {
        final resource = resources[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (resource['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                resource['icon'] as IconData,
                color: resource['color'] as Color,
              ),
            ),
            title: Text(resource['title'] as String),
            subtitle: Text('${resource['type']} • ${resource['author']}'),
            trailing: IconButton(
              icon: const Icon(Icons.bookmark),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }

  Widget _buildPostsList(List<Map<String, dynamic>> posts) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Gap(8),
                Text(
                  'by ${post['author']}',
                  style: const TextStyle(fontSize: 12),
                ),
                const Gap(12),
                Row(
                  children: [
                    const Icon(Icons.arrow_upward, size: 16),
                    const Gap(4),
                    Text('${post['upvotes']} upvotes'),
                    const Gap(16),
                    const Icon(Icons.chat_bubble_outline, size: 16),
                    const Gap(4),
                    Text('${post['answers']} answers'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
