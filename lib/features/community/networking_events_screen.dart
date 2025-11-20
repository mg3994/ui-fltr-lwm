import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class NetworkingEventsScreen extends HookWidget {
  const NetworkingEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState('All');
    final filters = ['All', 'Virtual', 'In-Person', 'Hybrid'];

    final events = [
      {
        'id': 1,
        'title': 'Flutter Global Summit 2024',
        'type': 'Virtual',
        'date': 'Dec 15, 2024',
        'time': '10:00 AM - 6:00 PM PST',
        'attendees': 2500,
        'maxAttendees': 3000,
        'price': 'Free',
        'image': 'https://picsum.photos/400/200?random=20',
        'organizer': 'Flutter Community',
        'organizerAvatar': 'https://i.pravatar.cc/100?u=org1',
        'tags': ['Flutter', 'Mobile', 'Web'],
        'description':
            'Join developers worldwide for a day of Flutter talks, workshops, and networking.',
        'speakers': [
          {'name': 'Sarah Jenkins', 'avatar': 'https://i.pravatar.cc/50?u=1'},
          {'name': 'David Chen', 'avatar': 'https://i.pravatar.cc/50?u=2'},
          {'name': 'Michael Brown', 'avatar': 'https://i.pravatar.cc/50?u=4'},
        ],
        'registered': false,
      },
      {
        'id': 2,
        'title': 'Design Thinking Workshop',
        'type': 'In-Person',
        'date': 'Dec 20, 2024',
        'time': '2:00 PM - 5:00 PM',
        'location': 'San Francisco, CA',
        'attendees': 45,
        'maxAttendees': 50,
        'price': '\$25',
        'image': 'https://picsum.photos/400/200?random=21',
        'organizer': 'Design Leaders',
        'organizerAvatar': 'https://i.pravatar.cc/100?u=org2',
        'tags': ['Design', 'UX', 'Workshop'],
        'description':
            'Hands-on workshop to master design thinking principles and methodologies.',
        'speakers': [
          {'name': 'Emily Davis', 'avatar': 'https://i.pravatar.cc/50?u=3'},
        ],
        'registered': true,
      },
      {
        'id': 3,
        'title': 'Tech Career Fair',
        'type': 'Hybrid',
        'date': 'Jan 10, 2025',
        'time': '9:00 AM - 4:00 PM EST',
        'location': 'New York, NY + Virtual',
        'attendees': 850,
        'maxAttendees': 1000,
        'price': 'Free',
        'image': 'https://picsum.photos/400/200?random=22',
        'organizer': 'Tech Careers Network',
        'organizerAvatar': 'https://i.pravatar.cc/100?u=org3',
        'tags': ['Career', 'Networking', 'Jobs'],
        'description':
            'Connect with top tech companies and explore career opportunities.',
        'speakers': [
          {'name': 'Sarah Jenkins', 'avatar': 'https://i.pravatar.cc/50?u=1'},
          {'name': 'Michael Brown', 'avatar': 'https://i.pravatar.cc/50?u=4'},
        ],
        'registered': false,
      },
      {
        'id': 4,
        'title': 'Mobile Dev Meetup',
        'type': 'In-Person',
        'date': 'Dec 18, 2024',
        'time': '6:00 PM - 9:00 PM',
        'location': 'Seattle, WA',
        'attendees': 78,
        'maxAttendees': 100,
        'price': 'Free',
        'image': 'https://picsum.photos/400/200?random=23',
        'organizer': 'Seattle Mobile Devs',
        'organizerAvatar': 'https://i.pravatar.cc/100?u=org4',
        'tags': ['Mobile', 'Networking', 'Community'],
        'description':
            'Monthly meetup for mobile developers to share knowledge and network.',
        'speakers': [
          {'name': 'David Chen', 'avatar': 'https://i.pravatar.cc/50?u=2'},
        ],
        'registered': true,
      },
    ];

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
                'Networking Events',
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
                icon: const Icon(Icons.calendar_today),
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
                // Filters
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    separatorBuilder: (context, index) => const Gap(8),
                    itemBuilder: (context, index) {
                      final filter = filters[index];
                      final isSelected = selectedFilter.value == filter;
                      return FilterChip(
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (selected) {
                          selectedFilter.value = filter;
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
                final event = events[index];
                return _EventCard(event: event);
              }, childCount: events.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Create Event'),
        elevation: 2,
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final isRegistered = event['registered'] as bool;
    final attendees = event['attendees'] as int;
    final maxAttendees = event['maxAttendees'] as int;
    final fillPercentage = attendees / maxAttendees;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isRegistered
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)
              : Theme.of(
                  context,
                ).colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: isRegistered ? 2 : 1,
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
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  event['image'] as String,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      child: const Center(child: Icon(Icons.event, size: 48)),
                    );
                  },
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getTypeColor(
                      event['type'] as String,
                    ).withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getTypeIcon(event['type'] as String),
                        size: 14,
                        color: Colors.white,
                      ),
                      const Gap(4),
                      Text(
                        event['type'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isRegistered)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, size: 14, color: Colors.white),
                        Gap(4),
                        Text(
                          'Registered',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  event['title'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(12),
                // Date & Time
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const Gap(8),
                    Expanded(
                      child: Text(
                        '${event['date']} • ${event['time']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                if (event.containsKey('location')) ...[
                  const Gap(8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const Gap(8),
                      Expanded(
                        child: Text(
                          event['location'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const Gap(16),
                // Description
                Text(
                  event['description'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(16),
                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (event['tags'] as List<String>).map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primaryContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const Gap(16),
                // Speakers
                Row(
                  children: [
                    Text(
                      'Speakers:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const Gap(8),
                    ...((event['speakers'] as List<Map<String, String>>)
                        .take(3)
                        .map((speaker) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(speaker['avatar']!),
                            ),
                          );
                        })),
                    if ((event['speakers'] as List).length > 3)
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '+${(event['speakers'] as List).length - 3}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const Gap(16),
                // Attendees Progress
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$attendees / $maxAttendees attendees',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                              Text(
                                event['price'] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const Gap(8),
                          LinearProgressIndicator(
                            value: fillPercentage,
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(3),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            color: fillPercentage > 0.8
                                ? Colors.orange
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                // Action Button
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    backgroundColor: isRegistered
                        ? Theme.of(context).colorScheme.surfaceContainerHighest
                        : Theme.of(context).colorScheme.primary,
                    foregroundColor: isRegistered
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(isRegistered ? 'View Details' : 'Register Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Virtual':
        return Colors.blue;
      case 'In-Person':
        return Colors.purple;
      case 'Hybrid':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'Virtual':
        return Icons.videocam;
      case 'In-Person':
        return Icons.location_on;
      case 'Hybrid':
        return Icons.hub;
      default:
        return Icons.event;
    }
  }
}
