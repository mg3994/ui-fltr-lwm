import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;

class OneOnOneSessionsScreen extends HookWidget {
  const OneOnOneSessionsScreen({super.key});

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
                '1-on-1 Sessions',
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
                          Colors.deepOrange.shade700,
                          Colors.orange.shade600,
                          Colors.amber.shade500,
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(painter: _VideoCallPatternPainter()),
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
                  colors: [Colors.orange.shade50, Colors.amber.shade50],
                ),
              ),
              child: Column(
                children: [
                  const Gap(20),
                  // Session Stats
                  _SessionStats(),
                  const Gap(20),
                  // Tab Selector
                  _TabSelector(
                    selectedTab: selectedTab.value,
                    onTabChanged: (index) => selectedTab.value = index,
                  ),
                  const Gap(20),
                  // Content based on selected tab
                  if (selectedTab.value == 0) ...[
                    _UpcomingSessionsSection(),
                  ] else if (selectedTab.value == 1) ...[
                    _PastSessionsSection(),
                  ] else ...[
                    _AvailableMentorsSection(),
                  ],
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _BookSessionButton(),
    );
  }
}

class _SessionStats extends StatelessWidget {
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
                  value: '${(12 * value).toInt()}',
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
                  icon: Icons.check_circle,
                  value: '${(47 * value).toInt()}',
                  label: 'Completed',
                  color: Colors.green,
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
                  icon: Icons.access_time,
                  value: '${(38.5 * value).toStringAsFixed(1)}h',
                  label: 'Total Hours',
                  color: Colors.orange,
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
              fontSize: 20,
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
    final tabs = ['Upcoming', 'Past', 'Mentors'];

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
                            colors: [
                              Colors.deepOrange.shade600,
                              Colors.orange.shade600,
                            ],
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

class _UpcomingSessionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessions = [
      {
        'mentor': 'Sarah Chen',
        'avatar': '👩‍💼',
        'topic': 'Career Growth Strategy',
        'date': 'Today',
        'time': '3:00 PM - 4:00 PM',
        'duration': '1 hour',
        'type': 'Video Call',
        'isToday': true,
      },
      {
        'mentor': 'Mike Johnson',
        'avatar': '👨‍💻',
        'topic': 'Flutter Best Practices',
        'date': 'Tomorrow',
        'time': '10:00 AM - 11:00 AM',
        'duration': '1 hour',
        'type': 'Video Call',
        'isToday': false,
      },
      {
        'mentor': 'Emily Davis',
        'avatar': '👩‍🔬',
        'topic': 'System Design Review',
        'date': 'Dec 25',
        'time': '2:00 PM - 3:30 PM',
        'duration': '1.5 hours',
        'type': 'Video Call',
        'isToday': false,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming Sessions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...sessions.asMap().entries.map((entry) {
            final index = entry.key;
            final session = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _UpcomingSessionCard(session: session),
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

class _UpcomingSessionCard extends StatelessWidget {
  final Map<String, dynamic> session;

  const _UpcomingSessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    final isToday = session['isToday'] as bool;

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
        border: Border.all(
          color: isToday
              ? Colors.orange.withValues(alpha: 0.5 * 255)
              : Colors.grey.shade200,
          width: isToday ? 2 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isToday
                ? Colors.orange.withValues(alpha: 0.15 * 255)
                : Colors.black.withValues(alpha: 0.05 * 255),
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
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrange.shade400,
                      Colors.orange.shade400,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    session['avatar'] as String,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session['mentor'] as String,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      session['topic'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (isToday)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade600,
                        Colors.deepOrange.shade600,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'TODAY',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
            ],
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1 * 255),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _SessionDetail(
                    icon: Icons.calendar_today,
                    text: session['date'] as String,
                  ),
                ),
                Expanded(
                  child: _SessionDetail(
                    icon: Icons.access_time,
                    text: session['time'] as String,
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          Row(
            children: [
              _SessionDetail(
                icon: Icons.timelapse,
                text: session['duration'] as String,
              ),
              const Gap(20),
              _SessionDetail(
                icon: Icons.videocam,
                text: session['type'] as String,
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                    side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Reschedule',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.videocam, size: 18),
                      const Gap(6),
                      Text(
                        isToday ? 'Join Now' : 'Details',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SessionDetail extends StatelessWidget {
  final IconData icon;
  final String text;

  const _SessionDetail({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const Gap(6),
        Flexible(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }
}

class _PastSessionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessions = [
      {
        'mentor': 'Lisa Park',
        'avatar': '👩‍💼',
        'topic': 'Interview Preparation',
        'date': 'Dec 18, 2024',
        'duration': '1 hour',
        'rating': 5.0,
        'notes': 'Great session! Very helpful tips.',
      },
      {
        'mentor': 'Alex Kumar',
        'avatar': '👨‍🎓',
        'topic': 'Code Review Session',
        'date': 'Dec 15, 2024',
        'duration': '45 min',
        'rating': 4.5,
        'notes': 'Learned a lot about clean code practices.',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Past Sessions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...sessions.asMap().entries.map((entry) {
            final index = entry.key;
            final session = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _PastSessionCard(session: session),
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

class _PastSessionCard extends StatelessWidget {
  final Map<String, dynamic> session;

  const _PastSessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    final rating = session['rating'] as double;

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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey.shade400, Colors.grey.shade500],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    session['avatar'] as String,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session['mentor'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      session['topic'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
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
          const Gap(12),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
              const Gap(6),
              Text(
                session['date'] as String,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const Gap(16),
              Icon(Icons.timelapse, size: 14, color: Colors.grey.shade600),
              const Gap(6),
              Text(
                session['duration'] as String,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
          const Gap(12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.05 * 255),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.note, size: 16, color: Colors.blue.shade700),
                const Gap(8),
                Expanded(
                  child: Text(
                    session['notes'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
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

class _AvailableMentorsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mentors = [
      {
        'name': 'Dr. James Wilson',
        'avatar': '👨‍🏫',
        'expertise': 'Software Architecture',
        'rating': 4.9,
        'sessions': 156,
        'price': '\$80/hour',
        'available': true,
      },
      {
        'name': 'Anna Martinez',
        'avatar': '👩‍💻',
        'expertise': 'Mobile Development',
        'rating': 4.8,
        'sessions': 98,
        'price': '\$65/hour',
        'available': true,
      },
      {
        'name': 'Tom Chen',
        'avatar': '👨‍💼',
        'expertise': 'Product Management',
        'rating': 4.7,
        'sessions': 124,
        'price': '\$75/hour',
        'available': false,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Mentors',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...mentors.asMap().entries.map((entry) {
            final index = entry.key;
            final mentor = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _MentorCard(mentor: mentor),
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

class _MentorCard extends StatelessWidget {
  final Map<String, dynamic> mentor;

  const _MentorCard({required this.mentor});

  @override
  Widget build(BuildContext context) {
    final rating = mentor['rating'] as double;
    final isAvailable = mentor['available'] as bool;

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
        border: Border.all(
          color: isAvailable
              ? Colors.green.withValues(alpha: 0.3 * 255)
              : Colors.grey.shade200,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isAvailable
                ? Colors.green.withValues(alpha: 0.08 * 255)
                : Colors.black.withValues(alpha: 0.05 * 255),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrange.shade400,
                      Colors.orange.shade400,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    mentor['avatar'] as String,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mentor['name'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      mentor['expertise'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
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
                  color: isAvailable
                      ? Colors.green.withValues(alpha: 0.15 * 255)
                      : Colors.grey.withValues(alpha: 0.15 * 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: isAvailable ? Colors.green : Colors.grey,
                    ),
                    const Gap(6),
                    Text(
                      isAvailable ? 'Available' : 'Busy',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isAvailable
                            ? Colors.green.shade700
                            : Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const Gap(4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.people, size: 16, color: Colors.grey.shade600),
                    const Gap(4),
                    Text(
                      '${mentor['sessions']} sessions',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                mentor['price'] as String,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade600,
                ),
              ),
            ],
          ),
          const Gap(16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isAvailable ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange.shade600,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                isAvailable ? 'Book Session' : 'Not Available',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookSessionButton extends StatelessWidget {
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
            backgroundColor: Colors.deepOrange.shade600,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Book Session',
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

class _VideoCallPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1 * 255)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final random = math.Random(42);

    // Draw video camera icons
    for (int i = 0; i < 15; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final cameraSize = 25.0 + random.nextDouble() * 15;

      // Camera body
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, cameraSize, cameraSize * 0.7),
          const Radius.circular(4),
        ),
        paint,
      );

      // Camera lens
      final path = Path()
        ..moveTo(x + cameraSize, y + cameraSize * 0.15)
        ..lineTo(x + cameraSize * 1.3, y)
        ..lineTo(x + cameraSize * 1.3, y + cameraSize * 0.7)
        ..lineTo(x + cameraSize, y + cameraSize * 0.55)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
