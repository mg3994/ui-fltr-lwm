import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;

class MentorshipGoalsMilestonesScreen extends HookWidget {
  const MentorshipGoalsMilestonesScreen({super.key});

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
                'Goals & Milestones',
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
                          Colors.teal.shade700,
                          Colors.cyan.shade600,
                          Colors.blue.shade500,
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(painter: _TargetPatternPainter()),
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
                  colors: [Colors.teal.shade50, Colors.cyan.shade50],
                ),
              ),
              child: Column(
                children: [
                  const Gap(20),
                  // Progress Overview
                  _ProgressOverview(),
                  const Gap(20),
                  // Active Goals
                  _ActiveGoalsSection(),
                  const Gap(20),
                  // Milestones Timeline
                  _MilestonesTimeline(),
                  const Gap(20),
                  // Completed Goals
                  _CompletedGoalsSection(),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _AddGoalButton(),
    );
  }
}

class _ProgressOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 1200),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, double value, child) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.teal.shade600, Colors.cyan.shade600],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withValues(alpha: 0.3 * 255),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Overall Progress',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Gap(20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: 0.68 * value,
                        strokeWidth: 12,
                        backgroundColor: Colors.white.withValues(
                          alpha: 0.3 * 255,
                        ),
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '${(68 * value).toInt()}%',
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Complete',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.9 * 255),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(24),
                Row(
                  children: [
                    Expanded(
                      child: _OverviewStat(
                        value: '${(12 * value).toInt()}',
                        label: 'Active',
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.white.withValues(alpha: 0.3 * 255),
                    ),
                    Expanded(
                      child: _OverviewStat(
                        value: '${(23 * value).toInt()}',
                        label: 'Completed',
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.white.withValues(alpha: 0.3 * 255),
                    ),
                    Expanded(
                      child: _OverviewStat(
                        value: '${(35 * value).toInt()}',
                        label: 'Total',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OverviewStat extends StatelessWidget {
  final String value;
  final String label;

  const _OverviewStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const Gap(4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.8 * 255),
          ),
        ),
      ],
    );
  }
}

class _ActiveGoalsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final goals = [
      {
        'title': 'Master Flutter State Management',
        'category': 'Technical Skills',
        'progress': 0.75,
        'deadline': 'Dec 31, 2024',
        'tasks': 8,
        'completedTasks': 6,
        'color': Colors.blue,
      },
      {
        'title': 'Build 3 Production Apps',
        'category': 'Portfolio',
        'progress': 0.67,
        'deadline': 'Jan 15, 2025',
        'tasks': 3,
        'completedTasks': 2,
        'color': Colors.purple,
      },
      {
        'title': 'Contribute to Open Source',
        'category': 'Community',
        'progress': 0.40,
        'deadline': 'Feb 1, 2025',
        'tasks': 10,
        'completedTasks': 4,
        'color': Colors.green,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Goals',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...goals.asMap().entries.map((entry) {
            final index = entry.key;
            final goal = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _GoalCard(goal: goal),
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

class _GoalCard extends StatelessWidget {
  final Map<String, dynamic> goal;

  const _GoalCard({required this.goal});

  @override
  Widget build(BuildContext context) {
    final color = goal['color'] as Color;
    final progress = goal['progress'] as double;
    final tasks = goal['tasks'] as int;
    final completedTasks = goal['completedTasks'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        border: Border.all(
          color: color.withValues(alpha: 0.3 * 255),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1 * 255),
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15 * 255),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.flag, color: color, size: 24),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal['title'] as String,
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
                        color: color.withValues(alpha: 0.1 * 255),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        goal['category'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const Gap(16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
          const Gap(16),
          Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 16,
                color: Colors.grey.shade600,
              ),
              const Gap(6),
              Text(
                '$completedTasks/$tasks tasks completed',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const Spacer(),
              Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
              const Gap(6),
              Text(
                goal['deadline'] as String,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MilestonesTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final milestones = [
      {
        'title': 'First Flutter App Published',
        'date': 'Nov 15, 2024',
        'description': 'Successfully published my first app to Play Store',
        'achieved': true,
      },
      {
        'title': 'Completed Advanced Flutter Course',
        'date': 'Dec 1, 2024',
        'description': 'Finished comprehensive Flutter development course',
        'achieved': true,
      },
      {
        'title': 'Reach 1000 GitHub Stars',
        'date': 'Dec 25, 2024',
        'description': 'Open source project milestone',
        'achieved': false,
      },
      {
        'title': 'Land First Developer Job',
        'date': 'Jan 15, 2025',
        'description': 'Secure full-time Flutter developer position',
        'achieved': false,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Milestones Timeline',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...milestones.asMap().entries.map((entry) {
            final index = entry.key;
            final milestone = entry.value;
            final isLast = index == milestones.length - 1;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: _MilestoneItem(milestone: milestone, isLast: isLast),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class _MilestoneItem extends StatelessWidget {
  final Map<String, dynamic> milestone;
  final bool isLast;

  const _MilestoneItem({required this.milestone, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final achieved = milestone['achieved'] as bool;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: achieved
                    ? LinearGradient(
                        colors: [Colors.teal.shade600, Colors.cyan.shade600],
                      )
                    : null,
                color: achieved ? null : Colors.grey.shade300,
                shape: BoxShape.circle,
                border: Border.all(
                  color: achieved ? Colors.white : Colors.grey.shade400,
                  width: 3,
                ),
              ),
              child: Center(
                child: Icon(
                  achieved ? Icons.check : Icons.circle,
                  color: achieved ? Colors.white : Colors.grey.shade500,
                  size: achieved ? 20 : 12,
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: achieved ? Colors.teal.shade300 : Colors.grey.shade300,
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
                colors: [
                  Colors.white,
                  achieved
                      ? Colors.teal.withValues(alpha: 0.05 * 255)
                      : Colors.grey.shade50,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: achieved
                    ? Colors.teal.withValues(alpha: 0.3 * 255)
                    : Colors.grey.shade200,
                width: 1.5,
              ),
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
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),
                    if (achieved)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.teal.withValues(alpha: 0.15 * 255),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Achieved',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade700,
                          ),
                        ),
                      ),
                  ],
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
                      milestone['date'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  milestone['description'] as String,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CompletedGoalsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final completedGoals = [
      {
        'title': 'Learn Flutter Basics',
        'completedDate': 'Oct 15, 2024',
        'category': 'Technical Skills',
      },
      {
        'title': 'Build First Portfolio Website',
        'completedDate': 'Nov 1, 2024',
        'category': 'Portfolio',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recently Completed',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...completedGoals.asMap().entries.map((entry) {
            final index = entry.key;
            final goal = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _CompletedGoalCard(goal: goal),
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

class _CompletedGoalCard extends StatelessWidget {
  final Map<String, dynamic> goal;

  const _CompletedGoalCard({required this.goal});

  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.15 * 255),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 24,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal['title'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
                const Gap(4),
                Row(
                  children: [
                    Text(
                      goal['category'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const Gap(8),
                    Icon(Icons.circle, size: 4, color: Colors.grey.shade400),
                    const Gap(8),
                    Text(
                      goal['completedDate'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
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

class _AddGoalButton extends StatelessWidget {
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
            backgroundColor: Colors.teal.shade600,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Add Goal',
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

class _TargetPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1 * 255)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final random = math.Random(42);

    // Draw target/bullseye patterns
    for (int i = 0; i < 12; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final maxRadius = 20.0 + random.nextDouble() * 15;

      // Draw concentric circles
      for (int j = 1; j <= 3; j++) {
        canvas.drawCircle(Offset(x, y), maxRadius * (j / 3), paint);
      }

      // Draw crosshair
      canvas.drawLine(
        Offset(x - maxRadius, y),
        Offset(x + maxRadius, y),
        paint,
      );
      canvas.drawLine(
        Offset(x, y - maxRadius),
        Offset(x, y + maxRadius),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
