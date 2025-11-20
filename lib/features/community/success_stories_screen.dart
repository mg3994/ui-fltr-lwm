import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class SuccessStoriesScreen extends HookWidget {
  const SuccessStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCategory = useState('All');
    final categories = [
      'All',
      'Career Change',
      'Promotion',
      'Skill Mastery',
      'Entrepreneurship',
    ];

    final stories = [
      {
        'id': 1,
        'mentee': 'Alex Johnson',
        'menteeAvatar': 'https://i.pravatar.cc/150?u=20',
        'mentor': 'Sarah Jenkins',
        'mentorAvatar': 'https://i.pravatar.cc/150?u=1',
        'category': 'Career Change',
        'title': 'From Marketing to Flutter Developer',
        'story':
            'With Sarah\'s guidance, I successfully transitioned from marketing to becoming a Flutter developer in just 6 months. Her structured approach and real-world projects helped me build a strong portfolio.',
        'outcome': 'Landed a job at a top tech company',
        'duration': '6 months',
        'sessions': 24,
        'rating': 5.0,
        'date': '2 weeks ago',
        'image': 'https://picsum.photos/400/250?random=1',
      },
      {
        'id': 2,
        'mentee': 'Maria Garcia',
        'menteeAvatar': 'https://i.pravatar.cc/150?u=21',
        'mentor': 'David Chen',
        'mentorAvatar': 'https://i.pravatar.cc/150?u=2',
        'category': 'Promotion',
        'title': 'Senior Designer to Design Lead',
        'story':
            'David helped me develop leadership skills and strategic thinking. His mentorship was instrumental in my promotion to Design Lead, managing a team of 8 designers.',
        'outcome': 'Promoted to Design Lead',
        'duration': '4 months',
        'sessions': 16,
        'rating': 5.0,
        'date': '1 month ago',
        'image': 'https://picsum.photos/400/250?random=2',
      },
      {
        'id': 3,
        'mentee': 'James Wilson',
        'menteeAvatar': 'https://i.pravatar.cc/150?u=22',
        'mentor': 'Michael Brown',
        'mentorAvatar': 'https://i.pravatar.cc/150?u=4',
        'category': 'Entrepreneurship',
        'title': 'Launched My Own Mobile App Startup',
        'story':
            'Michael\'s expertise in mobile architecture and business strategy helped me launch my startup. We now have 50K+ users and secured seed funding.',
        'outcome': 'Raised \$500K seed funding',
        'duration': '8 months',
        'sessions': 32,
        'rating': 5.0,
        'date': '3 weeks ago',
        'image': 'https://picsum.photos/400/250?random=3',
      },
      {
        'id': 4,
        'mentee': 'Emily Chen',
        'menteeAvatar': 'https://i.pravatar.cc/150?u=23',
        'mentor': 'Sarah Jenkins',
        'mentorAvatar': 'https://i.pravatar.cc/150?u=1',
        'category': 'Skill Mastery',
        'title': 'Mastered State Management in Flutter',
        'story':
            'Sarah\'s deep knowledge of Flutter state management patterns transformed my coding skills. I can now build complex, scalable applications with confidence.',
        'outcome': 'Built 3 production apps',
        'duration': '3 months',
        'sessions': 12,
        'rating': 5.0,
        'date': '1 week ago',
        'image': 'https://picsum.photos/400/250?random=4',
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                'Success Stories',
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Real transformations from our community',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Gap(16),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Category Filters
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => const Gap(8),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory.value == category;
                      return FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          selectedCategory.value = category;
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
                      );
                    },
                  ),
                ),
                const Gap(16),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final story = stories[index];
                return _StoryCard(story: story);
              }, childCount: stories.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Share Your Story'),
        elevation: 2,
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final Map<String, dynamic> story;

  const _StoryCard({required this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              story['image'] as String,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Center(child: Icon(Icons.image, size: 48)),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    story['category'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const Gap(16),
                // Title
                Text(
                  story['title'] as String,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(12),
                // Mentee & Mentor
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        story['menteeAvatar'] as String,
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            story['mentee'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Mentee',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward, size: 16),
                    const Gap(8),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        story['mentorAvatar'] as String,
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            story['mentor'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Mentor',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                // Story
                Text(
                  story['story'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(16),
                // Outcome Highlight
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.withValues(alpha: 0.1),
                        Colors.green.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.green.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.emoji_events,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Outcome',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const Gap(2),
                            Text(
                              story['outcome'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                // Stats
                Row(
                  children: [
                    _StatChip(
                      icon: Icons.access_time,
                      label: story['duration'] as String,
                    ),
                    const Gap(8),
                    _StatChip(
                      icon: Icons.video_call,
                      label: '${story['sessions']} sessions',
                    ),
                    const Gap(8),
                    _StatChip(
                      icon: Icons.star,
                      label: '${story['rating']}',
                      color: Colors.amber,
                    ),
                  ],
                ),
                const Gap(16),
                // Footer
                Row(
                  children: [
                    Text(
                      story['date'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share, size: 18),
                      label: const Text('Share'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _StatChip({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: chipColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: chipColor),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: chipColor,
            ),
          ),
        ],
      ),
    );
  }
}
