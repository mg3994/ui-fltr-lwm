import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;

class MentorshipMatchingAlgorithmScreen extends HookWidget {
  const MentorshipMatchingAlgorithmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 2),
    )..repeat();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Matching Algorithm',
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
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: _NetworkPatternPainter(
                            animationController.value,
                          ),
                        );
                      },
                    ),
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
                  colors: [Colors.deepPurple.shade50, Colors.purple.shade50],
                ),
              ),
              child: Column(
                children: [
                  const Gap(20),
                  // Algorithm Overview
                  _AlgorithmOverview(),
                  const Gap(20),
                  // Matching Factors
                  _MatchingFactorsSection(),
                  const Gap(20),
                  // Live Matching Demo
                  _LiveMatchingDemo(),
                  const Gap(20),
                  // Success Metrics
                  _SuccessMetricsSection(),
                  const Gap(20),
                  // Recent Matches
                  _RecentMatchesSection(),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _FindMatchButton(),
    );
  }
}

class _AlgorithmOverview extends StatelessWidget {
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
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.grey.shade50],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.purple.shade200, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withValues(alpha: 0.2 * 255),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurple.shade600,
                              Colors.purple.shade600,
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.psychology,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AI-Powered Matching',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade900,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              'Using machine learning to find your perfect mentor',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _AlgorithmStat(
                            value: '${(98 * value).toInt()}%',
                            label: 'Accuracy',
                            color: Colors.green,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.purple.shade200,
                        ),
                        Expanded(
                          child: _AlgorithmStat(
                            value: '${(15 * value).toInt()}',
                            label: 'Factors',
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.purple.shade200,
                        ),
                        Expanded(
                          child: _AlgorithmStat(
                            value: '<${(2 * value).toStringAsFixed(1)}s',
                            label: 'Speed',
                            color: Colors.orange,
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

class _AlgorithmStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _AlgorithmStat({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const Gap(4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

class _MatchingFactorsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final factors = [
      {
        'name': 'Skills Alignment',
        'weight': 0.25,
        'icon': Icons.code,
        'color': Colors.blue,
      },
      {
        'name': 'Experience Level',
        'weight': 0.20,
        'icon': Icons.trending_up,
        'color': Colors.green,
      },
      {
        'name': 'Industry Match',
        'weight': 0.15,
        'icon': Icons.business,
        'color': Colors.orange,
      },
      {
        'name': 'Availability',
        'weight': 0.15,
        'icon': Icons.schedule,
        'color': Colors.purple,
      },
      {
        'name': 'Communication Style',
        'weight': 0.10,
        'icon': Icons.chat,
        'color': Colors.pink,
      },
      {
        'name': 'Goals Compatibility',
        'weight': 0.10,
        'icon': Icons.flag,
        'color': Colors.teal,
      },
      {
        'name': 'Location & Timezone',
        'weight': 0.05,
        'icon': Icons.location_on,
        'color': Colors.red,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Matching Factors',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...factors.asMap().entries.map((entry) {
            final index = entry.key;
            final factor = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _FactorCard(factor: factor),
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

class _FactorCard extends StatelessWidget {
  final Map<String, dynamic> factor;

  const _FactorCard({required this.factor});

  @override
  Widget build(BuildContext context) {
    final weight = factor['weight'] as double;
    final color = factor['color'] as Color;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15 * 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(factor['icon'] as IconData, color: color, size: 22),
              ),
              const Gap(12),
              Expanded(
                child: Text(
                  factor['name'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15 * 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${(weight * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const Gap(12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: weight,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveMatchingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Live Matching Demo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 1200),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Opacity(
                opacity: value,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.deepPurple.shade700,
                        Colors.purple.shade600,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withValues(alpha: 0.3 * 255),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Mentee
                          Expanded(
                            child: _ProfileBubble(
                              name: 'You',
                              avatar: '👨‍💻',
                              role: 'Mentee',
                            ),
                          ),
                          const Gap(20),
                          // Matching Animation
                          TweenAnimationBuilder(
                            duration: const Duration(seconds: 2),
                            tween: Tween<double>(begin: 0, end: 1),
                            builder: (context, double animValue, child) {
                              return Column(
                                children: [
                                  Icon(
                                    Icons.sync,
                                    color: Colors.white.withValues(
                                      alpha: 0.9 * 255,
                                    ),
                                    size: 32,
                                  ),
                                  const Gap(4),
                                  Text(
                                    '${(animValue * 100).toInt()}%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const Gap(20),
                          // Mentor
                          Expanded(
                            child: _ProfileBubble(
                              name: 'Sarah',
                              avatar: '👩‍💼',
                              role: 'Mentor',
                            ),
                          ),
                        ],
                      ),
                      const Gap(20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15 * 255),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _MatchMetric(
                              label: 'Skills Match',
                              value: 0.95 * value,
                              color: Colors.green,
                            ),
                            const Gap(8),
                            _MatchMetric(
                              label: 'Experience Gap',
                              value: 0.88 * value,
                              color: Colors.blue,
                            ),
                            const Gap(8),
                            _MatchMetric(
                              label: 'Availability',
                              value: 0.92 * value,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileBubble extends StatelessWidget {
  final String name;
  final String avatar;
  final String role;

  const _ProfileBubble({
    required this.name,
    required this.avatar,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2 * 255),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Center(
            child: Text(avatar, style: const TextStyle(fontSize: 30)),
          ),
        ),
        const Gap(8),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const Gap(2),
        Text(
          role,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8 * 255),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _MatchMetric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _MatchMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.2 * 255),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        const Gap(8),
        Text(
          '${(value * 100).toInt()}%',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _SuccessMetricsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Success Metrics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 800),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return _MetricCard(
                      icon: Icons.favorite,
                      value: (4.8 * value).toStringAsFixed(1),
                      label: 'Avg Rating',
                      color: Colors.red,
                      suffix: '/5',
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
                    return _MetricCard(
                      icon: Icons.check_circle,
                      value: '${(92 * value).toInt()}',
                      label: 'Success Rate',
                      color: Colors.green,
                      suffix: '%',
                    );
                  },
                ),
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 1000),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return _MetricCard(
                      icon: Icons.people,
                      value: '${(15234 * value).toInt()}',
                      label: 'Total Matches',
                      color: Colors.blue,
                      suffix: '',
                    );
                  },
                ),
              ),
              const Gap(12),
              Expanded(
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 1100),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return _MetricCard(
                      icon: Icons.timer,
                      value: (1.8 * value).toStringAsFixed(1),
                      label: 'Avg Time',
                      color: Colors.orange,
                      suffix: 's',
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final String suffix;

  const _MetricCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.suffix,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              if (suffix.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    suffix,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
            ],
          ),
          const Gap(4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class _RecentMatchesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final matches = [
      {
        'mentee': 'Alex Kumar',
        'mentor': 'Sarah Chen',
        'score': 98,
        'time': '2 min ago',
        'status': 'accepted',
      },
      {
        'mentee': 'Emily Davis',
        'mentor': 'Mike Johnson',
        'score': 95,
        'time': '5 min ago',
        'status': 'pending',
      },
      {
        'mentee': 'Tom Wilson',
        'mentor': 'Lisa Park',
        'score': 92,
        'time': '8 min ago',
        'status': 'accepted',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Matches',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...matches.asMap().entries.map((entry) {
            final index = entry.key;
            final match = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _MatchCard(match: match),
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

class _MatchCard extends StatelessWidget {
  final Map<String, dynamic> match;

  const _MatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    final score = match['score'] as int;
    final status = match['status'] as String;
    final isAccepted = status == 'accepted';

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
        border: Border.all(
          color: isAccepted
              ? Colors.green.withValues(alpha: 0.3 * 255)
              : Colors.orange.withValues(alpha: 0.3 * 255),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      match['mentee'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    const Gap(8),
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Colors.grey.shade400,
                    ),
                    const Gap(8),
                    Text(
                      match['mentor'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade400,
                            Colors.pink.shade400,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$score% Match',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Gap(8),
                    Text(
                      match['time'] as String,
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isAccepted
                  ? Colors.green.withValues(alpha: 0.15 * 255)
                  : Colors.orange.withValues(alpha: 0.15 * 255),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  isAccepted ? Icons.check_circle : Icons.schedule,
                  size: 16,
                  color: isAccepted ? Colors.green : Colors.orange,
                ),
                const Gap(4),
                Text(
                  isAccepted ? 'Accepted' : 'Pending',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isAccepted ? Colors.green : Colors.orange,
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

class _FindMatchButton extends StatelessWidget {
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
            backgroundColor: Colors.deepPurple.shade600,
            icon: const Icon(Icons.search, color: Colors.white),
            label: const Text(
              'Find Match',
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

class _NetworkPatternPainter extends CustomPainter {
  final double animationValue;

  _NetworkPatternPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15 * 255)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final random = math.Random(42);
    final nodes = <Offset>[];

    // Generate nodes
    for (int i = 0; i < 20; i++) {
      nodes.add(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
      );
    }

    // Draw connections
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final distance = (nodes[i] - nodes[j]).distance;
        if (distance < 150) {
          final opacity = (1 - distance / 150) * animationValue;
          paint.color = Colors.white.withValues(alpha: (0.15 * opacity * 255));
          canvas.drawLine(nodes[i], nodes[j], paint);
        }
      }
    }

    // Draw nodes
    paint.style = PaintingStyle.fill;
    for (final node in nodes) {
      paint.color = Colors.white.withValues(alpha: 0.3 * 255);
      canvas.drawCircle(node, 4, paint);
    }
  }

  @override
  bool shouldRepaint(_NetworkPatternPainter oldDelegate) =>
      animationValue != oldDelegate.animationValue;
}
