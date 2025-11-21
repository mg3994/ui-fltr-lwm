import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;

class SkillEndorsementsScreen extends HookWidget {
  const SkillEndorsementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Skill Endorsements',
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
                          Colors.purple.shade700,
                          Colors.deepPurple.shade600,
                          Colors.indigo.shade500,
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(painter: _BadgePatternPainter()),
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
                  colors: [Colors.purple.shade50, Colors.deepPurple.shade50],
                ),
              ),
              child: Column(
                children: [
                  const Gap(20),
                  // Endorsement Stats
                  _EndorsementStats(),
                  const Gap(20),
                  // Top Skills
                  _TopSkillsSection(),
                  const Gap(20),
                  // All Skills
                  _AllSkillsSection(),
                  const Gap(20),
                  // Recent Endorsers
                  _RecentEndorsersSection(),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _RequestEndorsementButton(),
    );
  }
}

class _EndorsementStats extends StatelessWidget {
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
                  icon: Icons.verified,
                  value: '${(247 * value).toInt()}',
                  label: 'Total',
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
                  icon: Icons.emoji_events,
                  value: '${(18 * value).toInt()}',
                  label: 'Skills',
                  color: Colors.amber,
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
                  icon: Icons.trending_up,
                  value: '+${(23 * value).toInt()}',
                  label: 'This Month',
                  color: Colors.green,
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

class _TopSkillsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topSkills = [
      {
        'name': 'Flutter Development',
        'endorsements': 45,
        'level': 'Expert',
        'color': Colors.blue,
      },
      {
        'name': 'UI/UX Design',
        'endorsements': 38,
        'level': 'Advanced',
        'color': Colors.purple,
      },
      {
        'name': 'Firebase',
        'endorsements': 32,
        'level': 'Advanced',
        'color': Colors.orange,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber.shade600, size: 24),
              const Gap(8),
              Text(
                'Top Skills',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
          const Gap(16),
          ...topSkills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _TopSkillCard(skill: skill, rank: index + 1),
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

class _TopSkillCard extends StatelessWidget {
  final Map<String, dynamic> skill;
  final int rank;

  const _TopSkillCard({required this.skill, required this.rank});

  @override
  Widget build(BuildContext context) {
    final color = skill['color'] as Color;
    final endorsements = skill['endorsements'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            color.withValues(alpha: 0.05 * 255),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3 * 255), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15 * 255),
            blurRadius: 15,
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
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  color.withValues(alpha: 0.7 * 255),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  skill['name'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
                const Gap(4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15 * 255),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        skill['level'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                    const Gap(8),
                    Icon(Icons.verified, size: 14, color: Colors.grey.shade600),
                    const Gap(4),
                    Text(
                      '$endorsements endorsements',
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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_circle_outline, color: color, size: 28),
          ),
        ],
      ),
    );
  }
}

class _AllSkillsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final skills = [
      {'name': 'Dart', 'count': 28, 'color': Colors.blue},
      {'name': 'React', 'count': 24, 'color': Colors.cyan},
      {'name': 'Node.js', 'count': 22, 'color': Colors.green},
      {'name': 'Python', 'count': 19, 'color': Colors.yellow},
      {'name': 'Git', 'count': 18, 'color': Colors.orange},
      {'name': 'MongoDB', 'count': 15, 'color': Colors.teal},
      {'name': 'AWS', 'count': 14, 'color': Colors.deepOrange},
      {'name': 'Docker', 'count': 12, 'color': Colors.indigo},
      {'name': 'GraphQL', 'count': 10, 'color': Colors.pink},
      {'name': 'TypeScript', 'count': 9, 'color': Colors.lightBlue},
      {'name': 'Redux', 'count': 8, 'color': Colors.purple},
      {'name': 'REST APIs', 'count': 7, 'color': Colors.lime},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Skills',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 1000),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Opacity(
                opacity: value,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: skills.map((skill) {
                    return _SkillChip(skill: skill);
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final Map<String, dynamic> skill;

  const _SkillChip({required this.skill});

  @override
  Widget build(BuildContext context) {
    final color = skill['color'] as Color;
    final count = skill['count'] as int;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            color.withValues(alpha: 0.1 * 255),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: color.withValues(alpha: 0.3 * 255),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1 * 255),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            skill['name'] as String,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2 * 255),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentEndorsersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final endorsers = [
      {
        'name': 'Sarah Chen',
        'avatar': '👩‍💼',
        'skill': 'Flutter Development',
        'time': '2 hours ago',
        'message':
            'Excellent Flutter developer with great attention to detail!',
      },
      {
        'name': 'Mike Johnson',
        'avatar': '👨‍💻',
        'skill': 'UI/UX Design',
        'time': '5 hours ago',
        'message': 'Amazing design skills and creative problem solving.',
      },
      {
        'name': 'Emily Davis',
        'avatar': '👩‍🔬',
        'skill': 'Firebase',
        'time': '1 day ago',
        'message': 'Deep knowledge of Firebase and backend integration.',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Endorsements',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...endorsers.asMap().entries.map((entry) {
            final index = entry.key;
            final endorser = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _EndorserCard(endorser: endorser),
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

class _EndorserCard extends StatelessWidget {
  final Map<String, dynamic> endorser;

  const _EndorserCard({required this.endorser});

  @override
  Widget build(BuildContext context) {
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
                    colors: [
                      Colors.purple.shade400,
                      Colors.deepPurple.shade400,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    endorser['avatar'] as String,
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
                      endorser['name'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    const Gap(4),
                    Row(
                      children: [
                        Text(
                          'endorsed ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          endorser['skill'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                endorser['time'] as String,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              ),
            ],
          ),
          const Gap(12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.purple.withValues(alpha: 0.05 * 255),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.format_quote,
                  size: 16,
                  color: Colors.purple.shade400,
                ),
                const Gap(8),
                Expanded(
                  child: Text(
                    endorser['message'] as String,
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

class _RequestEndorsementButton extends StatelessWidget {
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
            backgroundColor: Colors.purple.shade600,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Request Endorsement',
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

class _BadgePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1 * 255)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final random = math.Random(42);

    // Draw badge/star shapes
    for (int i = 0; i < 20; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 15.0 + random.nextDouble() * 10;

      // Draw star
      final path = Path();
      for (int j = 0; j < 5; j++) {
        final angle = (j * 2 * math.pi / 5) - math.pi / 2;
        final outerX = x + math.cos(angle) * radius;
        final outerY = y + math.sin(angle) * radius;

        if (j == 0) {
          path.moveTo(outerX, outerY);
        } else {
          path.lineTo(outerX, outerY);
        }

        final innerAngle = angle + math.pi / 5;
        final innerX = x + math.cos(innerAngle) * radius * 0.4;
        final innerY = y + math.sin(innerAngle) * radius * 0.4;
        path.lineTo(innerX, innerY);
      }
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
