import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class StudyGroupsScreen extends HookWidget {
  const StudyGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0); // 0: My Groups, 1: Discover

    final myGroups = [
      {
        'name': 'Flutter Developers',
        'members': 245,
        'image': 'https://picsum.photos/seed/group1/400/200',
        'description': 'Learn and share Flutter development tips',
        'activity': 'Active today',
        'joined': true,
        'color': Colors.blue,
      },
      {
        'name': 'UI/UX Design Community',
        'members': 189,
        'image': 'https://picsum.photos/seed/group2/400/200',
        'description': 'Discuss design principles and trends',
        'activity': 'Active 2 hours ago',
        'joined': true,
        'color': Colors.purple,
      },
    ];

    final discoverGroups = [
      {
        'name': 'React Native Enthusiasts',
        'members': 312,
        'image': 'https://picsum.photos/seed/group3/400/200',
        'description': 'Build amazing mobile apps with React Native',
        'activity': 'Active today',
        'joined': false,
        'color': Colors.cyan,
      },
      {
        'name': 'DevOps Best Practices',
        'members': 156,
        'image': 'https://picsum.photos/seed/group4/400/200',
        'description': 'Share DevOps knowledge and automation tips',
        'activity': 'Active yesterday',
        'joined': false,
        'color': Colors.orange,
      },
      {
        'name': 'Data Science Study Group',
        'members': 278,
        'image': 'https://picsum.photos/seed/group5/400/200',
        'description': 'Learn ML, AI, and data analysis together',
        'activity': 'Active 3 hours ago',
        'joined': false,
        'color': Colors.green,
      },
    ];

    final groups = selectedTab.value == 0 ? myGroups : discoverGroups;

    return Scaffold(
      appBar: AppBar(title: const Text('Study Groups')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Create Group'),
      ),
      body: Column(
        children: [
          // Tab Selector
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(
                  value: 0,
                  label: Text('My Groups'),
                  icon: Icon(Icons.group),
                ),
                ButtonSegment(
                  value: 1,
                  label: Text('Discover'),
                  icon: Icon(Icons.explore),
                ),
              ],
              selected: {selectedTab.value},
              onSelectionChanged: (newSelection) {
                selectedTab.value = newSelection.first;
              },
            ),
          ),

          // Groups List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];
                return _GroupCard(
                  group: group,
                  isJoined: group['joined'] as bool,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  final Map<String, dynamic> group;
  final bool isJoined;

  const _GroupCard({required this.group, required this.isJoined});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Group Image
          Stack(
            children: [
              Image.network(
                group['image'] as String,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 120,
                  color: (group['color'] as Color).withOpacity(0.2),
                  child: Center(
                    child: Icon(
                      Icons.group,
                      size: 50,
                      color: group['color'] as Color,
                    ),
                  ),
                ),
              ),
              if (isJoined)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, size: 14, color: Colors.white),
                        Gap(4),
                        Text(
                          'Joined',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),

          // Group Details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group['name'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(8),
                Text(
                  group['description'] as String,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const Gap(12),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const Gap(4),
                    Text(
                      '${group['members']} members',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Gap(16),
                    Icon(Icons.circle, size: 8, color: Colors.green),
                    const Gap(4),
                    Text(
                      group['activity'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const Gap(16),

                // Action Button
                if (isJoined)
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.chat),
                          label: const Text('Open Chat'),
                        ),
                      ),
                      const Gap(12),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Leave'),
                      ),
                    ],
                  )
                else
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Join Group'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 44),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
