import 'dart:ui';
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                'Study Groups',
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
          ),
          SliverToBoxAdapter(
            child: Padding(
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
                style: ButtonStyle(
                  side: WidgetStateProperty.all(
                    BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final group = groups[index];
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
                  child: _GroupCard(
                    group: group,
                    isJoined: group['joined'] as bool,
                  ),
                );
              }, childCount: groups.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Create Group'),
        elevation: 2,
      ),
    );
  }
}

class _GroupCard extends HookWidget {
  final Map<String, dynamic> group;
  final bool isJoined;

  const _GroupCard({required this.group, required this.isJoined});

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isHovered.value ? 1.02 : 1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
                    blurRadius: isHovered.value ? 20 : 10,
                    offset: Offset(0, isHovered.value ? 8 : 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Group Image with Gradient Overlay
                  Stack(
                    children: [
                      Image.network(
                        group['image'] as String,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                (group['color'] as Color).withValues(
                                  alpha: 0.3,
                                ),
                                (group['color'] as Color).withValues(
                                  alpha: 0.1,
                                ),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.group,
                              size: 50,
                              color: group['color'] as Color,
                            ),
                          ),
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.3),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
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
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                Gap(4),
                                Text(
                                  'Joined',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                        const Gap(12),
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 16,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                            const Gap(4),
                            Text(
                              '${group['members']} members',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const Gap(16),
                            const Icon(
                              Icons.circle,
                              size: 8,
                              color: Colors.green,
                            ),
                            const Gap(4),
                            Text(
                              group['activity'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),

                        // Action Button with Animation
                        if (isJoined)
                          Row(
                            children: [
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.chat),
                                  label: const Text('Open Chat'),
                                  style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                ),
                              ),
                              const Gap(12),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Leave'),
                              ),
                            ],
                          )
                        else
                          _AnimatedJoinButton(onPressed: () {}),
                      ],
                    ),
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

class _AnimatedJoinButton extends HookWidget {
  final VoidCallback onPressed;

  const _AnimatedJoinButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );

    return MouseRegion(
      onEnter: (_) => controller.forward(),
      onExit: (_) => controller.reverse(),
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: 1.05,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut)),
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.add),
          label: const Text('Join Group'),
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
