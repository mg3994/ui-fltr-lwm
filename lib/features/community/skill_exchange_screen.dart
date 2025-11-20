import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class SkillExchangeScreen extends HookWidget {
  const SkillExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    final offers = [
      {
        'id': 1,
        'user': 'Sarah Jenkins',
        'avatar': 'https://i.pravatar.cc/150?u=1',
        'offering': 'Flutter Development',
        'seeking': 'UI/UX Design',
        'level': 'Expert',
        'availability': 'Weekends',
        'description':
            'I can teach Flutter from basics to advanced. Looking to improve my design skills.',
        'tags': ['Flutter', 'Dart', 'Mobile'],
        'rating': 4.9,
        'exchanges': 12,
        'responseTime': '< 1 hour',
        'matched': false,
      },
      {
        'id': 2,
        'user': 'David Chen',
        'avatar': 'https://i.pravatar.cc/150?u=2',
        'offering': 'Product Design',
        'seeking': 'React Development',
        'level': 'Advanced',
        'availability': 'Evenings',
        'description':
            'Product designer with 8 years experience. Want to learn React for prototyping.',
        'tags': ['Figma', 'UI/UX', 'Prototyping'],
        'rating': 4.8,
        'exchanges': 8,
        'responseTime': '< 2 hours',
        'matched': true,
      },
      {
        'id': 3,
        'user': 'Emily Davis',
        'avatar': 'https://i.pravatar.cc/150?u=3',
        'offering': 'Backend Development',
        'seeking': 'DevOps',
        'level': 'Intermediate',
        'availability': 'Flexible',
        'description':
            'Node.js developer looking to learn Docker and Kubernetes.',
        'tags': ['Node.js', 'MongoDB', 'API'],
        'rating': 4.7,
        'exchanges': 5,
        'responseTime': '< 3 hours',
        'matched': false,
      },
      {
        'id': 4,
        'user': 'Michael Brown',
        'avatar': 'https://i.pravatar.cc/150?u=4',
        'offering': 'System Design',
        'seeking': 'Machine Learning',
        'level': 'Expert',
        'availability': 'Weekdays',
        'description':
            'Architect with 12 years experience. Interested in ML/AI applications.',
        'tags': ['Architecture', 'Scalability', 'Cloud'],
        'rating': 5.0,
        'exchanges': 15,
        'responseTime': '< 30 min',
        'matched': false,
      },
    ];

    final myOffers = [
      {
        'offering': 'Flutter Development',
        'seeking': 'Backend Development',
        'matches': 3,
        'status': 'Active',
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
                'Skill Exchange',
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
                        'Trade skills with peers',
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
                // Tabs
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _TabButton(
                          label: 'Browse Offers',
                          isSelected: selectedTab.value == 0,
                          onTap: () => selectedTab.value = 0,
                        ),
                      ),
                      Expanded(
                        child: _TabButton(
                          label: 'My Offers',
                          isSelected: selectedTab.value == 1,
                          onTap: () => selectedTab.value = 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
              ],
            ),
          ),
          if (selectedTab.value == 0)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final offer = offers[index];
                  return _OfferCard(offer: offer);
                }, childCount: offers.length),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  ...myOffers.map((offer) => _MyOfferCard(offer: offer)),
                  const Gap(16),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Create New Offer'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          const SliverGap(80),
        ],
      ),
      floatingActionButton: selectedTab.value == 0
          ? FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Create Offer'),
              elevation: 2,
            )
          : null,
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  final Map<String, dynamic> offer;

  const _OfferCard({required this.offer});

  @override
  Widget build(BuildContext context) {
    final isMatched = offer['matched'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isMatched
              ? Colors.green.withValues(alpha: 0.5)
              : Theme.of(
                  context,
                ).colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: isMatched ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(offer['avatar'] as String),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer['user'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          const Gap(4),
                          Text(
                            '${offer['rating']} • ${offer['exchanges']} exchanges',
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
                    color: _getLevelColor(
                      offer['level'] as String,
                    ).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _getLevelColor(
                        offer['level'] as String,
                      ).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    offer['level'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: _getLevelColor(offer['level'] as String),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(16),
            // Exchange Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                    Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Offering',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          offer['offering'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.swap_horiz,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Seeking',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          offer['seeking'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(16),
            // Description
            Text(
              offer['description'] as String,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const Gap(16),
            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (offer['tags'] as List<String>).map((tag) {
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
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                );
              }).toList(),
            ),
            const Gap(16),
            // Details
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const Gap(6),
                Text(
                  offer['availability'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const Gap(16),
                Icon(
                  Icons.reply,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const Gap(6),
                Text(
                  offer['responseTime'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const Gap(16),
            // Action Button
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.handshake, size: 18),
              label: Text(isMatched ? 'View Match' : 'Propose Exchange'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: isMatched
                    ? Colors.green
                    : Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case 'Expert':
        return Colors.purple;
      case 'Advanced':
        return Colors.blue;
      case 'Intermediate':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }
}

class _MyOfferCard extends StatelessWidget {
  final Map<String, dynamic> offer;

  const _MyOfferCard({required this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Offering: ${offer['offering']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'Seeking: ${offer['seeking']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  offer['status'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.people, size: 20),
                const Gap(8),
                Text(
                  '${offer['matches']} potential matches found',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Edit'),
                ),
              ),
              const Gap(12),
              Expanded(
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(elevation: 0),
                  child: const Text('View Matches'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
