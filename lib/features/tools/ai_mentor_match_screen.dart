import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;

class AiMentorMatchScreen extends HookWidget {
  const AiMentorMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState('All');
    final currentIndex = useState(0);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'AI Mentor Match',
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
                          Colors.deepPurple.shade700,
                          Colors.purple.shade600,
                          Colors.pink.shade500,
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(child: CustomPaint(painter: _StarsPainter())),
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
                  colors: [Colors.purple.shade50, Colors.pink.shade50],
                ),
              ),
              child: Column(
                children: [
                  const Gap(20),
                  // AI Match Score
                  _AiMatchScoreCard(),
                  const Gap(20),
                  // Filter Chips
                  _FilterChips(
                    selectedFilter: selectedFilter.value,
                    onFilterChanged: (filter) => selectedFilter.value = filter,
                  ),
                  const Gap(20),
                  // Swipeable Mentor Cards
                  _MentorCardStack(currentIndex: currentIndex),
                  const Gap(20),
                  // Action Buttons
                  _ActionButtons(),
                  const Gap(20),
                  // Matched Mentors
                  _MatchedMentorsSection(),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiMatchScoreCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.95 * 255),
                    Colors.white.withValues(alpha: 0.85 * 255),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.6 * 255),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withValues(alpha: 0.2 * 255),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepPurple.shade400,
                          Colors.pink.shade400,
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.psychology,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Matching Active',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          '${(47 * value).toInt()} Perfect Matches Found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade900,
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
                      gradient: LinearGradient(
                        colors: [Colors.green.shade400, Colors.teal.shade400],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.bolt, color: Colors.white, size: 16),
                        Gap(4),
                        Text(
                          'Live',
                          style: TextStyle(
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
            ),
          ),
        );
      },
    );
  }
}

class _FilterChips extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const _FilterChips({
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Tech', 'Business', 'Design', 'Marketing'];

    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter == selectedFilter;

          return TweenAnimationBuilder(
            duration: Duration(milliseconds: 400 + (index * 50)),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () => onFilterChanged(filter),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(
                                  colors: [
                                    Colors.deepPurple.shade600,
                                    Colors.purple.shade600,
                                  ],
                                )
                              : null,
                          color: isSelected ? null : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.purple.withValues(
                                      alpha: 0.3 * 255,
                                    ),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade700,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _MentorCardStack extends StatelessWidget {
  final ValueNotifier<int> currentIndex;

  const _MentorCardStack({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final mentors = [
      {
        'name': 'Dr. Sarah Chen',
        'title': 'Senior Flutter Architect',
        'company': 'Google',
        'experience': '12 years',
        'match': 98,
        'skills': ['Flutter', 'Architecture', 'Leadership'],
        'sessions': 156,
        'rating': 4.9,
        'image': '👩‍💼',
      },
      {
        'name': 'Michael Rodriguez',
        'title': 'Full Stack Lead',
        'company': 'Meta',
        'experience': '10 years',
        'match': 95,
        'skills': ['React', 'Node.js', 'System Design'],
        'sessions': 203,
        'rating': 4.8,
        'image': '👨‍💻',
      },
      {
        'name': 'Emily Watson',
        'title': 'Mobile Engineering Manager',
        'company': 'Amazon',
        'experience': '15 years',
        'match': 92,
        'skills': ['iOS', 'Android', 'Team Building'],
        'sessions': 178,
        'rating': 5.0,
        'image': '👩‍🔬',
      },
    ];

    return SizedBox(
      height: 480,
      child: Stack(
        children: List.generate(math.min(3, mentors.length), (index) {
          final reversedIndex = math.min(2, mentors.length - 1) - index;
          return TweenAnimationBuilder(
            duration: Duration(milliseconds: 600 + (index * 100)),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Positioned(
                top: index * 10.0 * value,
                left: 20,
                right: 20,
                child: Transform.scale(
                  scale: 1 - (index * 0.05) * value,
                  child: Opacity(
                    opacity: 1 - (index * 0.2),
                    child: _MentorCard(
                      mentor: mentors[reversedIndex],
                      isTop: index == 0,
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

class _MentorCard extends StatelessWidget {
  final Map<String, dynamic> mentor;
  final bool isTop;

  const _MentorCard({required this.mentor, required this.isTop});

  @override
  Widget build(BuildContext context) {
    final match = mentor['match'] as int;

    return Container(
      height: 450,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1 * 255),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with match score
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade600, Colors.purple.shade500],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Center(
                    child: Text(
                      mentor['image'] as String,
                      style: const TextStyle(fontSize: 40),
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        mentor['title'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.9 * 255),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2 * 255),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$match%',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Match',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Row
                  Row(
                    children: [
                      _StatItem(
                        icon: Icons.business,
                        label: mentor['company'] as String,
                      ),
                      const Gap(20),
                      _StatItem(
                        icon: Icons.work_history,
                        label: mentor['experience'] as String,
                      ),
                    ],
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      _StatItem(
                        icon: Icons.video_call,
                        label: '${mentor['sessions']} sessions',
                      ),
                      const Gap(20),
                      _StatItem(
                        icon: Icons.star,
                        label: '${mentor['rating']} rating',
                      ),
                    ],
                  ),
                  const Gap(20),
                  const Divider(),
                  const Gap(16),
                  // Skills
                  Text(
                    'Expertise',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  const Gap(12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (mentor['skills'] as List<String>).map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple.shade100,
                              Colors.pink.shade100,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          skill,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.purple.shade700,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Gap(20),
                  // Why Great Match
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.shade200,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green.shade600,
                          size: 20,
                        ),
                        const Gap(8),
                        Expanded(
                          child: Text(
                            'Perfect match for your Flutter career goals',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade800,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const Gap(6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 600),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: _ActionButton(
                  icon: Icons.close,
                  color: Colors.red,
                  size: 60,
                  onTap: () {},
                ),
              );
            },
          ),
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 700),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: _ActionButton(
                  icon: Icons.star,
                  color: Colors.amber,
                  size: 50,
                  onTap: () {},
                ),
              );
            },
          ),
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 800),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: _ActionButton(
                  icon: Icons.favorite,
                  color: Colors.green,
                  size: 70,
                  onTap: () {},
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 3),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3 * 255),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: size * 0.5),
      ),
    );
  }
}

class _MatchedMentorsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final matches = [
      {
        'name': 'Alex Kumar',
        'role': 'Tech Lead',
        'image': '👨‍💼',
        'status': 'Pending',
      },
      {
        'name': 'Lisa Park',
        'role': 'Senior Dev',
        'image': '👩‍💻',
        'status': 'Accepted',
      },
      {
        'name': 'James Wilson',
        'role': 'Architect',
        'image': '👨‍🔬',
        'status': 'Accepted',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'Your Matches',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),
              const Gap(8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${matches.length}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: matches.length,
          itemBuilder: (context, index) {
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _MatchedMentorCard(match: matches[index]),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _MatchedMentorCard extends StatelessWidget {
  final Map<String, dynamic> match;

  const _MatchedMentorCard({required this.match});

  @override
  Widget build(BuildContext context) {
    final isAccepted = match['status'] == 'Accepted';

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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05 * 255),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade300, Colors.pink.shade300],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                match['image'] as String,
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
                  match['name'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
                const Gap(4),
                Text(
                  match['role'] as String,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isAccepted
                  ? Colors.green.shade100
                  : Colors.orange.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              match['status'] as String,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isAccepted
                    ? Colors.green.shade700
                    : Colors.orange.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StarsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3 * 255)
      ..style = PaintingStyle.fill;

    final random = math.Random(42);
    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2 + 1;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
