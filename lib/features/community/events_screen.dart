import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class EventsScreen extends HookWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0); // 0: Upcoming, 1: Past

    final upcomingEvents = [
      {
        'title': 'Flutter Forward 2024',
        'type': 'Conference',
        'date': 'Mar 15, 2024',
        'time': '10:00 AM - 6:00 PM',
        'location': 'Virtual',
        'attendees': 2500,
        'image': 'https://picsum.photos/seed/event1/400/200',
        'registered': true,
        'color': Colors.blue,
      },
      {
        'title': 'Career Growth Workshop',
        'type': 'Workshop',
        'date': 'Feb 28, 2024',
        'time': '2:00 PM - 4:00 PM',
        'location': 'Online',
        'attendees': 150,
        'image': 'https://picsum.photos/seed/event2/400/200',
        'registered': false,
        'color': Colors.purple,
      },
      {
        'title': 'Networking Mixer',
        'type': 'Networking',
        'date': 'Feb 20, 2024',
        'time': '6:00 PM - 8:00 PM',
        'location': 'San Francisco, CA',
        'attendees': 80,
        'image': 'https://picsum.photos/seed/event3/400/200',
        'registered': true,
        'color': Colors.green,
      },
    ];

    final pastEvents = [
      {
        'title': 'State Management Masterclass',
        'type': 'Webinar',
        'date': 'Jan 10, 2024',
        'time': '3:00 PM - 5:00 PM',
        'location': 'Virtual',
        'attendees': 500,
        'image': 'https://picsum.photos/seed/event4/400/200',
        'attended': true,
        'color': Colors.orange,
      },
      {
        'title': 'Mobile Dev Summit',
        'type': 'Conference',
        'date': 'Dec 15, 2023',
        'time': '9:00 AM - 6:00 PM',
        'location': 'New York, NY',
        'attendees': 1200,
        'image': 'https://picsum.photos/seed/event5/400/200',
        'attended': true,
        'color': Colors.red,
      },
    ];

    final events = selectedTab.value == 0 ? upcomingEvents : pastEvents;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
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
                  label: Text('Upcoming'),
                  icon: Icon(Icons.event),
                ),
                ButtonSegment(
                  value: 1,
                  label: Text('Past'),
                  icon: Icon(Icons.history),
                ),
              ],
              selected: {selectedTab.value},
              onSelectionChanged: (newSelection) {
                selectedTab.value = newSelection.first;
              },
            ),
          ),

          // Events List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return _EventCard(
                  event: event,
                  isUpcoming: selectedTab.value == 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final Map<String, dynamic> event;
  final bool isUpcoming;

  const _EventCard({required this.event, required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image
          Stack(
            children: [
              Image.network(
                event['image'] as String,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 150,
                  color: (event['color'] as Color).withValues(alpha: 0.2),
                  child: Center(
                    child: Icon(
                      Icons.event,
                      size: 50,
                      color: event['color'] as Color,
                    ),
                  ),
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
                    color: event['color'] as Color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    event['type'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Event Details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(12),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const Gap(8),
                    Text(event['date'] as String),
                  ],
                ),
                const Gap(8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const Gap(8),
                    Text(event['time'] as String),
                  ],
                ),
                const Gap(8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const Gap(8),
                    Text(event['location'] as String),
                  ],
                ),
                const Gap(8),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const Gap(8),
                    Text('${event['attendees']} attendees'),
                  ],
                ),
                const Gap(16),

                // Action Button
                if (isUpcoming)
                  if (event['registered'] == true)
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.check_circle),
                      label: const Text('Registered'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 44),
                      ),
                    )
                  else
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.event_available),
                      label: const Text('Register Now'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 44),
                      ),
                    )
                else
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.photo_library),
                          label: const Text('View Photos'),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.video_library),
                          label: const Text('Recordings'),
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

