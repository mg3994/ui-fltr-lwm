import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;

class NetworkingEventsWorkshopsScreen extends HookWidget {
  const NetworkingEventsWorkshopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Events & Workshops',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.pink.shade700,
                          Colors.red.shade600,
                          Colors.red.shade500,
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(painter: _EventPatternPainter()),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.pink.shade50, Colors.red.shade50],
                ),
              ),
              child: Column(
                children: [
                  const Gap(20),
                  // Event Stats
                  _EventStats(),
                  const Gap(20),
                  // Tab Selector
                  _TabSelector(
                    selectedTab: selectedTab.value,
                    onTabChanged: (index) => selectedTab.value = index,
                  ),
                  const Gap(20),
                  // Content based on selected tab
                  if (selectedTab.value == 0) ...[
                    _UpcomingEventsSection(),
                  ] else if (selectedTab.value == 1) ...[
                    _WorkshopsSection(),
                  ] else ...[
                    _PastEventsSection(),
                  ],
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _CreateEventButton(),
    );
  }
}

class _EventStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 800),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return _StatCard(
                  icon: Icons.event,
                  value: '${(18 * value).toInt()}',
                  label: 'Upcoming',
                  color: Colors.blue,
                );
              },
            ),
          ),
          const Gap(12),
          Expanded(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 900),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return _StatCard(
                  icon: Icons.people,
                  value: '${(234 * value).toInt()}',
                  label: 'Attendees',
                  color: Colors.purple,
                );
              },
            ),
          ),
          const Gap(12),
          Expanded(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1000),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return _StatCard(
                  icon: Icons.workspace_premium,
                  value: '${(42 * value).toInt()}',
                  label: 'Attended',
                  color: Colors.amber,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.3 * 255),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1 * 255),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const Gap(8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class _TabSelector extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const _TabSelector({required this.selectedTab, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    final tabs = ['Upcoming', 'Workshops', 'Past'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08 * 255),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            final isSelected = index == selectedTab;

            return Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [Colors.pink.shade600, Colors.red.shade600],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tab,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _UpcomingEventsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = [
      {
        'title': 'Flutter Forward 2024',
        'type': 'Conference',
        'date': 'Dec 28, 2024',
        'time': '10:00 AM - 6:00 PM',
        'location': 'Virtual',
        'attendees': 1250,
        'image': '🎯',
        'isFeatured': true,
      },
      {
        'title': 'Career Networking Mixer',
        'type': 'Networking',
        'date': 'Dec 30, 2024',
        'time': '7:00 PM - 9:00 PM',
        'location': 'San Francisco, CA',
        'attendees': 85,
        'image': '🤝',
        'isFeatured': false,
      },
      {
        'title': 'Tech Talk: AI in Mobile Dev',
        'type': 'Tech Talk',
        'date': 'Jan 5, 2025',
        'time': '3:00 PM - 4:30 PM',
        'location': 'Virtual',
        'attendees': 320,
        'image': '🎤',
        'isFeatured': false,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming Events',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...events.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _EventCard(event: event),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final isFeatured = event['isFeatured'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            isFeatured
                ? Colors.pink.withValues(alpha: 0.05 * 255)
                : Colors.grey.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isFeatured
              ? Colors.pink.withValues(alpha: 0.3 * 255)
              : Colors.grey.shade200,
          width: isFeatured ? 2 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isFeatured
                ? Colors.pink.withValues(alpha: 0.15 * 255)
                : Colors.black.withValues(alpha: 0.05 * 255),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isFeatured)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink.shade600, Colors.red.shade600],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.star, color: Colors.white, size: 16),
                  Gap(6),
                  Text(
                    'FEATURED EVENT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.pink.shade400, Colors.red.shade400],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          event['image'] as String,
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event['title'] as String,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900,
                            ),
                          ),
                          const Gap(4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.pink.withValues(alpha: 0.15 * 255),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              event['type'] as String,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.pink.withValues(alpha: 0.05 * 255),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const Gap(8),
                          Text(
                            event['date'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const Gap(8),
                          Text(
                            event['time'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const Gap(8),
                          Text(
                            event['location'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.people,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const Gap(8),
                          Text(
                            '${event['attendees']} attending',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
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

class _WorkshopsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workshops = [
      {
        'title': 'Advanced Flutter Animations',
        'instructor': 'Sarah Chen',
        'date': 'Jan 10, 2025',
        'duration': '3 hours',
        'level': 'Advanced',
        'spots': 15,
        'price': '\$49',
      },
      {
        'title': 'Firebase Integration Masterclass',
        'instructor': 'Mike Johnson',
        'date': 'Jan 15, 2025',
        'duration': '2.5 hours',
        'level': 'Intermediate',
        'spots': 20,
        'price': '\$39',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Workshops',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...workshops.asMap().entries.map((entry) {
            final index = entry.key;
            final workshop = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _WorkshopCard(workshop: workshop),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class _WorkshopCard extends StatelessWidget {
  final Map<String, dynamic> workshop;

  const _WorkshopCard({required this.workshop});

  @override
  Widget build(BuildContext context) {
    final level = workshop['level'] as String;
    final levelColor = level == 'Advanced'
        ? Colors.red
        : level == 'Intermediate'
        ? Colors.orange
        : Colors.green;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05 * 255),
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
                child: Text(
                  workshop['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: levelColor.withValues(alpha: 0.15 * 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  level,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: levelColor,
                  ),
                ),
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              const Icon(Icons.person, size: 16, color: Colors.grey),
              const Gap(6),
              Text(
                workshop['instructor'] as String,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
              const Gap(6),
              Text(
                workshop['date'] as String,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const Gap(16),
              Icon(Icons.timelapse, size: 14, color: Colors.grey.shade600),
              const Gap(6),
              Text(
                workshop['duration'] as String,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15 * 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.event_seat,
                      size: 14,
                      color: Colors.green.shade700,
                    ),
                    const Gap(6),
                    Text(
                      '${workshop['spots']} spots left',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                workshop['price'] as String,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade600,
                ),
              ),
            ],
          ),
          const Gap(16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Enroll Now',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PastEventsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pastEvents = [
      {
        'title': 'Mobile Dev Summit 2024',
        'date': 'Nov 20, 2024',
        'attendees': 450,
        'rating': 4.8,
      },
      {
        'title': 'Flutter Community Meetup',
        'date': 'Nov 15, 2024',
        'attendees': 75,
        'rating': 4.6,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Past Events',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...pastEvents.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _PastEventCard(event: event),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class _PastEventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  const _PastEventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final rating = event['rating'] as double;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
                const Gap(8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12,
                      color: Colors.grey.shade600,
                    ),
                    const Gap(4),
                    Text(
                      event['date'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const Gap(12),
                    Icon(Icons.people, size: 12, color: Colors.grey.shade600),
                    const Gap(4),
                    Text(
                      '${event['attendees']} attended',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber.shade400, Colors.orange.shade400],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.white, size: 14),
                const Gap(4),
                Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
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

class _CreateEventButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: Colors.pink.shade600,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Create Event',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EventPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1 * 255)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final random = math.Random(42);

    // Draw calendar/event icons
    for (int i = 0; i < 15; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final calendarSize = 25.0 + random.nextDouble() * 15;

      // Calendar outline
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, calendarSize, calendarSize * 1.2),
          const Radius.circular(4),
        ),
        paint,
      );

      // Calendar header
      canvas.drawLine(
        Offset(x, y + calendarSize * 0.25),
        Offset(x + calendarSize, y + calendarSize * 0.25),
        paint,
      );

      // Calendar rings
      canvas.drawLine(
        Offset(x + calendarSize * 0.25, y),
        Offset(x + calendarSize * 0.25, y - 5),
        paint,
      );
      canvas.drawLine(
        Offset(x + calendarSize * 0.75, y),
        Offset(x + calendarSize * 0.75, y - 5),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
