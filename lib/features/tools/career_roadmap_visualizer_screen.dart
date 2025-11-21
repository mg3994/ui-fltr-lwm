import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;

class CareerRoadmapVisualizerScreen extends HookWidget {
  const CareerRoadmapVisualizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPath = useState(0);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Career Roadmap',
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
                          Colors.indigo.shade700,
                          Colors.blue.shade600,
                          Colors.cyan.shade500,
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(painter: _RoadmapPatternPainter()),
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
                  colors: [Colors.indigo.shade50, Colors.blue.shade50],
                ),
              ),
              child: Column(
                children: [
                  const Gap(20),
                  // Current Position
                  _CurrentPositionCard(),
                  const Gap(20),
                  // Career Paths
                  _CareerPathSelector(
                    selectedPath: selectedPath.value,
                    onPathChanged: (index) => selectedPath.value = index,
                  ),
                  const Gap(20),
                  // Roadmap Timeline
                  _RoadmapTimeline(selectedPath: selectedPath.value),
                  const Gap(20),
                  // Skills Required
                  _SkillsRequiredSection(),
                  const Gap(20),
                  // Salary Progression
                  _SalaryProgressionSection(),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _CustomizeButton(),
    );
  }
}

class _CurrentPositionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: 0.9 + (0.1 * value),
          child: Opacity(
            opacity: value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.grey.shade50],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.indigo.shade200, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withValues(alpha: 0.2 * 255),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.indigo.shade600,
                                Colors.blue.shade600,
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Current Position',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                'Junior Flutter Developer',
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
                              colors: [
                                Colors.green.shade400,
                                Colors.teal.shade400,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '1.5 years',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        Expanded(
                          child: _MiniStat(
                            icon: Icons.trending_up,
                            label: 'Next Level',
                            value: '6-12 months',
                            color: Colors.blue,
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: _MiniStat(
                            icon: Icons.attach_money,
                            label: 'Salary Range',
                            value: '\$60-80k',
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _MiniStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1 * 255),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
                const Gap(2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: color,
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

class _CareerPathSelector extends StatelessWidget {
  final int selectedPath;
  final ValueChanged<int> onPathChanged;

  const _CareerPathSelector({
    required this.selectedPath,
    required this.onPathChanged,
  });

  @override
  Widget build(BuildContext context) {
    final paths = [
      {'title': 'Technical Lead', 'icon': Icons.code, 'color': Colors.blue},
      {
        'title': 'Engineering Manager',
        'icon': Icons.people,
        'color': Colors.purple,
      },
      {
        'title': 'Product Manager',
        'icon': Icons.dashboard,
        'color': Colors.orange,
      },
    ];

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: paths.length,
        itemBuilder: (context, index) {
          final path = paths[index];
          final isSelected = index == selectedPath;

          return TweenAnimationBuilder(
            duration: Duration(milliseconds: 500 + (index * 100)),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () => onPathChanged(index),
                    child: Container(
                      width: 140,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  path['color'] as Color,
                                  (path['color'] as Color).withValues(
                                    alpha: 0.7 * 255,
                                  ),
                                ],
                              )
                            : LinearGradient(
                                colors: [Colors.white, Colors.grey.shade50],
                              ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: (path['color'] as Color).withValues(
                                    alpha: 0.3 * 255,
                                  ),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            path['icon'] as IconData,
                            color: isSelected
                                ? Colors.white
                                : path['color'] as Color,
                            size: 32,
                          ),
                          const Gap(12),
                          Text(
                            path['title'] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade900,
                            ),
                          ),
                        ],
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

class _RoadmapTimeline extends StatelessWidget {
  final int selectedPath;

  const _RoadmapTimeline({required this.selectedPath});

  @override
  Widget build(BuildContext context) {
    final milestones = [
      {
        'title': 'Mid-Level Developer',
        'duration': '6-12 months',
        'status': 'next',
        'skills': ['Advanced Flutter', 'State Management', 'Testing'],
      },
      {
        'title': 'Senior Developer',
        'duration': '2-3 years',
        'status': 'future',
        'skills': ['Architecture', 'Mentoring', 'System Design'],
      },
      {
        'title': selectedPath == 0
            ? 'Technical Lead'
            : selectedPath == 1
            ? 'Engineering Manager'
            : 'Product Manager',
        'duration': '4-5 years',
        'status': 'future',
        'skills': selectedPath == 0
            ? ['Team Leadership', 'Technical Strategy', 'Code Review']
            : selectedPath == 1
            ? ['People Management', 'Hiring', 'Planning']
            : ['Product Strategy', 'Roadmapping', 'Stakeholders'],
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Roadmap',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(20),
          ...milestones.asMap().entries.map((entry) {
            final index = entry.key;
            final milestone = entry.value;
            final isLast = index == milestones.length - 1;

            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 700 + (index * 150)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: _MilestoneCard(
                    milestone: milestone,
                    isLast: isLast,
                    animationValue: value,
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

class _MilestoneCard extends StatelessWidget {
  final Map<String, dynamic> milestone;
  final bool isLast;
  final double animationValue;

  const _MilestoneCard({
    required this.milestone,
    required this.isLast,
    required this.animationValue,
  });

  @override
  Widget build(BuildContext context) {
    final status = milestone['status'] as String;
    final isNext = status == 'next';
    final color = isNext ? Colors.blue : Colors.grey;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: isNext
                    ? LinearGradient(
                        colors: [Colors.blue.shade600, Colors.cyan.shade600],
                      )
                    : null,
                color: isNext ? null : Colors.grey.shade300,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: isNext
                    ? [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.3 * 255),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Icon(
                  isNext ? Icons.play_arrow : Icons.lock_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 80,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      color.withValues(alpha: 0.5 * 255),
                      color.withValues(alpha: 0.2 * 255),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const Gap(16),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.grey.shade50],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isNext ? Colors.blue.shade200 : Colors.grey.shade300,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05 * 255),
                  blurRadius: 10,
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
                        milestone['title'] as String,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15 * 255),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        milestone['duration'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: (milestone['skills'] as List<String>).map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isNext
                            ? Colors.blue.withValues(alpha: 0.1 * 255)
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isNext
                              ? Colors.blue.shade700
                              : Colors.grey.shade600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SkillsRequiredSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final skills = [
      {'name': 'Flutter Advanced', 'level': 0.8, 'current': 0.6},
      {'name': 'State Management', 'level': 0.9, 'current': 0.7},
      {'name': 'Testing', 'level': 0.7, 'current': 0.4},
      {'name': 'CI/CD', 'level': 0.6, 'current': 0.3},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills to Develop',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey.shade50],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05 * 255),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: skills.map((skill) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _SkillProgressBar(skill: skill),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillProgressBar extends StatelessWidget {
  final Map<String, dynamic> skill;

  const _SkillProgressBar({required this.skill});

  @override
  Widget build(BuildContext context) {
    final current = skill['current'] as double;
    final required = skill['level'] as double;
    final gap = required - current;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill['name'] as String,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
            Text(
              '${(current * 100).toInt()}% / ${(required * 100).toInt()}%',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const Gap(8),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            FractionallySizedBox(
              widthFactor: current,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade600, Colors.teal.shade600],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: required,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.3 * 255),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        if (gap > 0) ...[
          const Gap(4),
          Text(
            'Need ${(gap * 100).toInt()}% more',
            style: TextStyle(
              fontSize: 11,
              color: Colors.orange.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

class _SalaryProgressionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Salary Progression',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green.shade50, Colors.teal.shade50],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green.shade200, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.1 * 255),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                _SalaryItem(
                  level: 'Current',
                  salary: '\$60-80k',
                  color: Colors.blue,
                  isCurrent: true,
                ),
                const Gap(12),
                _SalaryItem(
                  level: 'Mid-Level',
                  salary: '\$90-120k',
                  color: Colors.purple,
                  isCurrent: false,
                ),
                const Gap(12),
                _SalaryItem(
                  level: 'Senior',
                  salary: '\$130-170k',
                  color: Colors.orange,
                  isCurrent: false,
                ),
                const Gap(12),
                _SalaryItem(
                  level: 'Lead/Manager',
                  salary: '\$180-250k',
                  color: Colors.green,
                  isCurrent: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SalaryItem extends StatelessWidget {
  final String level;
  final String salary;
  final Color color;
  final bool isCurrent;

  const _SalaryItem({
    required this.level,
    required this.salary,
    required this.color,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isCurrent
            ? color.withValues(alpha: 0.15 * 255)
            : Colors.white.withValues(alpha: 0.7 * 255),
        borderRadius: BorderRadius.circular(12),
        border: isCurrent ? Border.all(color: color, width: 2) : null,
      ),
      child: Row(
        children: [
          Icon(
            isCurrent
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: color,
            size: 20,
          ),
          const Gap(12),
          Expanded(
            child: Text(
              level,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                color: Colors.grey.shade900,
              ),
            ),
          ),
          Text(
            salary,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomizeButton extends StatelessWidget {
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
            backgroundColor: Colors.indigo.shade600,
            icon: const Icon(Icons.tune, color: Colors.white),
            label: const Text(
              'Customize',
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

class _RoadmapPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1 * 255)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height * 0.7);

    for (double x = 0; x <= size.width; x += 20) {
      final y = size.height * 0.7 + math.sin(x / 30) * 15;
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);

    // Draw milestone markers
    for (int i = 0; i < 4; i++) {
      final x = size.width * (0.2 + i * 0.2);
      final y = size.height * 0.7 + math.sin(x / 30) * 15;
      canvas.drawCircle(Offset(x, y), 6, paint..style = PaintingStyle.fill);
      paint.style = PaintingStyle.stroke;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
