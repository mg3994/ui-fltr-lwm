import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:signals_hooks/signals_hooks.dart';
import 'package:gap/gap.dart';
import 'package:linkwithmentor/core/data/mock_data.dart';
import 'package:linkwithmentor/features/mentee/home/mentor_profile_screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchQuery = useSignal('');
    final selectedFilter = useSignal('All');
    final isLoading = useSignal(true);

    useEffect(() {
      // Simulate API loading
      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) isLoading.value = false;
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LinkWithMentor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar Area
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: SearchBar(
              hintText: 'Search Mentors by skill, name...',
              leading: const Icon(Icons.search),
              onChanged: (val) => searchQuery.value = val,
              elevation: WidgetStateProperty.all(1),
              backgroundColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.surfaceContainerLow,
              ),
            ),
          ),

          Expanded(
            child: isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Filters
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              [
                                'All',
                                'Tech',
                                'Business',
                                'Design',
                                'Available Now',
                                'Top Rated',
                              ].map((filter) {
                                final isSelected =
                                    selectedFilter.value == filter;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FilterChip(
                                    label: Text(filter),
                                    selected: isSelected,
                                    onSelected: (selected) {
                                      selectedFilter.value = filter;
                                    },
                                    checkmarkColor: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                    labelStyle: TextStyle(
                                      color: isSelected
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.onPrimary
                                          : null,
                                    ),
                                    selectedColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                      const Gap(24),

                      // Featured Section
                      const Text(
                        'Top Rated Mentors',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(12),
                      SizedBox(
                        height: 220,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: kMockMentors.length,
                          separatorBuilder: (_, __) => const Gap(16),
                          itemBuilder: (context, index) {
                            final mentor = kMockMentors[index];
                            return FeaturedMentorCard(mentor: mentor);
                          },
                        ),
                      ),

                      const Gap(24),

                      // Vertical List
                      const Text(
                        'Mentors',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(12),
                      ...kMockMentors
                          .where((m) {
                            if (searchQuery.value.isEmpty) return true;
                            return m.name.toLowerCase().contains(
                                  searchQuery.value.toLowerCase(),
                                ) ||
                                m.skills.any(
                                  (s) => s.toLowerCase().contains(
                                    searchQuery.value.toLowerCase(),
                                  ),
                                );
                          })
                          .map(
                            (mentor) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: MentorListCard(mentor: mentor),
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

class FeaturedMentorCard extends StatelessWidget {
  final Mentor mentor;
  const FeaturedMentorCard({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              mentor.imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 100,
                color: Colors.grey[300],
                child: const Icon(Icons.person, size: 50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mentor.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(4),
                Text(
                  mentor.title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(8),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const Gap(4),
                    Text(
                      mentor.rating.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
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

class MentorListCard extends StatelessWidget {
  final Mentor mentor;
  const MentorListCard({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(mentor.imageUrl),
              onBackgroundImageError: (_, __) {},
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          mentor.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (mentor.isCertified)
                        const Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 20,
                        ),
                    ],
                  ),
                  const Gap(4),
                  Text(
                    mentor.title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const Gap(4),
                      Text(
                        '${mentor.rating} (${mentor.reviewCount})',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        '\$${mentor.hourlyRate.toInt()}/hr',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MentorProfileScreen(mentor: mentor),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Book Now'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

