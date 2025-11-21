import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class CareerInsightsScreen extends HookWidget {
  const CareerInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Career Insights',
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
                          Colors.indigo.shade800,
                          Colors.purple.shade600,
                          Colors.pink.shade500,
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(painter: _NetworkPainter()),
                  ),
                  Positioned(
                    right: -50,
                    top: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.1 * 255),
                            Colors.transparent,
                          ],
                        ),
                      ),
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
                  colors: [Colors.indigo.shade50, Colors.purple.shade50],
                ),
              ),
              child: Column(
                children: [
                  const Gap(20),
                  // Tab Selector
                  _TabSelector(
                    selectedTab: selectedTab.value,
                    onTabChanged: (tab) => selectedTab.value = tab,
                  ),
                  const Gap(24),
                  // AI Career Score
                  _CareerScoreCard(),
                  const Gap(20),
                  // Recommended Paths
                  _RecommendedPathsSection(),
                  const Gap(20),
                  // Market Trends
                  _MarketTrendsSection(),
                  const Gap(20),
                  // Skill Gaps
                  _SkillGapsSection(),
                  const Gap(20),
                  // Salary Insights
                  _SalaryInsightsSection(),
                  const Gap(20),
                  // Industry Connections
                  _IndustryConnectionsSection(),
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

class _TabSelector extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const _TabSelector({required this.selectedTab, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {'label': 'Overview', 'icon': Icons.dashboard},
      {'label': 'Paths', 'icon': Icons.route},
      {'label': 'Skills', 'icon': Icons.psychology},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9 * 255),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1 * 255),
              blurRadius: 15,
              offset: const Offset(0, 5),
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
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              Colors.indigo.shade600,
                              Colors.purple.shade600,
                            ],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        tab['icon'] as IconData,
                        size: 18,
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                      ),
                      const Gap(6),
                      Text(
                        tab['label'] as String,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade700,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ],
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

class _CareerScoreCard extends StatelessWidget {
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
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.95 * 255),
                      Colors.white.withValues(alpha: 0.85 * 255),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.6 * 255),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withValues(alpha: 0.2 * 255),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.indigo.shade400,
                                Colors.purple.shade400,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI Career Score',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Gap(4),
                              Row(
                                children: [
                                  Text(
                                    '${(85 * value).toInt()}',
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader =
                                            LinearGradient(
                                              colors: [
                                                Colors.indigo.shade600,
                                                Colors.purple.shade600,
                                              ],
                                            ).createShader(
                                              const Rect.fromLTWH(
                                                0,
                                                0,
                                                200,
                                                70,
                                              ),
                                            ),
                                    ),
                                  ),
                                  Text(
                                    '/100',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
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
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                size: 16,
                                color: Colors.green.shade700,
                              ),
                              const Gap(4),
                              Text(
                                '+5',
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.85 * value,
                        minHeight: 12,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation(
                          Colors.indigo.shade600,
                        ),
                      ),
                    ),
                    const Gap(16),
                    Text(
                      'Your career trajectory is excellent! Keep building skills in AI/ML.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                        height: 1.4,
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
  }
}

class _RecommendedPathsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paths = [
      {
        'title': 'Senior Flutter Developer',
        'match': 92,
        'salary': '\$95k - \$130k',
        'demand': 'High',
        'icon': Icons.phone_android,
        'color': Colors.blue,
      },
      {
        'title': 'Full Stack Engineer',
        'match': 88,
        'salary': '\$100k - \$140k',
        'demand': 'Very High',
        'icon': Icons.code,
        'color': Colors.purple,
      },
      {
        'title': 'Mobile Architect',
        'match': 85,
        'salary': '\$120k - \$160k',
        'demand': 'Medium',
        'icon': Icons.architecture,
        'color': Colors.indigo,
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
                'Recommended Paths',
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
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'AI Powered',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade700,
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
          itemCount: paths.length,
          itemBuilder: (context, index) {
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _PathCard(path: paths[index]),
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

class _PathCard extends StatelessWidget {
  final Map<String, dynamic> path;

  const _PathCard({required this.path});

  @override
  Widget build(BuildContext context) {
    final color = path['color'] as Color;
    final match = path['match'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
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
          color: color.withValues(alpha: 0.3 * 255),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15 * 255),
            blurRadius: 15,
            offset: const Offset(0, 5),
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
                child: Icon(path['icon'] as IconData, color: color, size: 24),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      path['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      path['salary'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$match%',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    'Match',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              _InfoChip(
                label: 'Demand: ${path['demand']}',
                color: path['demand'] == 'Very High'
                    ? Colors.green
                    : path['demand'] == 'High'
                    ? Colors.blue
                    : Colors.orange,
              ),
              const Gap(8),
              _InfoChip(label: '2-3 years', color: Colors.purple),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final Color color;

  const _InfoChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1 * 255),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(
            (color.r * 255.0 * 0.7).round().clamp(0, 255),
            (color.g * 255.0 * 0.7).round().clamp(0, 255),
            (color.b * 255.0 * 0.7).round().clamp(0, 255),
            1,
          ),
        ),
      ),
    );
  }
}

class _MarketTrendsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trends = [
      {'skill': 'AI/ML', 'growth': '+45%', 'jobs': '12.5k', 'trending': true},
      {'skill': 'Flutter', 'growth': '+38%', 'jobs': '8.2k', 'trending': true},
      {'skill': 'Cloud', 'growth': '+32%', 'jobs': '15.3k', 'trending': false},
      {'skill': 'DevOps', 'growth': '+28%', 'jobs': '9.7k', 'trending': false},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Market Trends',
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
                colors: [
                  Colors.white.withValues(alpha: 0.95 * 255),
                  Colors.white.withValues(alpha: 0.85 * 255),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.6 * 255),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withValues(alpha: 0.1 * 255),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: trends.asMap().entries.map((entry) {
                final index = entry.key;
                final trend = entry.value;
                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 600 + (index * 100)),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: _TrendItem(trend: trend, index: index),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendItem extends StatelessWidget {
  final Map<String, dynamic> trend;
  final int index;

  const _TrendItem({required this.trend, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: index < 3 ? 16 : 0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade400, Colors.purple.shade400],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      trend['skill'] as String,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    if (trend['trending'] == true) ...[
                      const Gap(6),
                      Icon(
                        Icons.local_fire_department,
                        size: 16,
                        color: Colors.orange.shade600,
                      ),
                    ],
                  ],
                ),
                const Gap(4),
                Text(
                  '${trend['jobs']} open positions',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              trend['growth'] as String,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillGapsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gaps = [
      {'skill': 'System Design', 'priority': 'High', 'courses': 5},
      {'skill': 'GraphQL', 'priority': 'Medium', 'courses': 3},
      {'skill': 'Kubernetes', 'priority': 'Low', 'courses': 7},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skill Gaps to Address',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...gaps.asMap().entries.map((entry) {
            final index = entry.key;
            final gap = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(20 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _SkillGapCard(gap: gap),
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

class _SkillGapCard extends StatelessWidget {
  final Map<String, dynamic> gap;

  const _SkillGapCard({required this.gap});

  @override
  Widget build(BuildContext context) {
    final priority = gap['priority'] as String;
    final priorityColor = priority == 'High'
        ? Colors.red
        : priority == 'Medium'
        ? Colors.orange
        : Colors.blue;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9 * 255),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: priorityColor.withValues(alpha: 0.3 * 255),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: priorityColor.withValues(alpha: 0.1 * 255),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: priorityColor.withValues(alpha: 0.15 * 255),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: priorityColor,
              size: 24,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gap['skill'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
                const Gap(4),
                Text(
                  '${gap['courses']} courses available',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: priorityColor.withValues(alpha: 0.15 * 255),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              priority,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(
                  (priorityColor.r * 255.0 * 0.7).round().clamp(0, 255),
                  (priorityColor.g * 255.0 * 0.7).round().clamp(0, 255),
                  (priorityColor.b * 255.0 * 0.7).round().clamp(0, 255),
                  1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SalaryInsightsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 800),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green.shade600, Colors.teal.shade600],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.3 * 255),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
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
                          color: Colors.white.withValues(alpha: 0.2 * 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.attach_money,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const Gap(12),
                      const Text(
                        'Salary Insights',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: _SalaryMetric(
                          label: 'Current Range',
                          value: '\$75k - \$95k',
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withValues(alpha: 0.3 * 255),
                      ),
                      Expanded(
                        child: _SalaryMetric(
                          label: 'Potential',
                          value: '\$120k+',
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15 * 255),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: Colors.white.withValues(alpha: 0.9 * 255),
                          size: 20,
                        ),
                        const Gap(8),
                        Expanded(
                          child: Text(
                            'Complete 2 more certifications to unlock higher salary range',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.9 * 255),
                              height: 1.4,
                            ),
                          ),
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
    );
  }
}

class _SalaryMetric extends StatelessWidget {
  final String label;
  final String value;

  const _SalaryMetric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.8 * 255),
          ),
        ),
        const Gap(4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _IndustryConnectionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final companies = [
      {'name': 'Google', 'connections': 12, 'hiring': true},
      {'name': 'Meta', 'connections': 8, 'hiring': true},
      {'name': 'Amazon', 'connections': 15, 'hiring': false},
      {'name': 'Microsoft', 'connections': 6, 'hiring': true},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Industry Connections',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
            ),
            itemCount: companies.length,
            itemBuilder: (context, index) {
              return TweenAnimationBuilder(
                duration: Duration(milliseconds: 600 + (index * 100)),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Opacity(
                      opacity: value,
                      child: _CompanyCard(company: companies[index]),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CompanyCard extends StatelessWidget {
  final Map<String, dynamic> company;

  const _CompanyCard({required this.company});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.95 * 255),
            Colors.white.withValues(alpha: 0.85 * 255),
          ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                company['name'] as String,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),
              if (company['hiring'] == true)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${company['connections']} connections',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              if (company['hiring'] == true) ...[
                const Gap(4),
                Text(
                  'Actively hiring',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _NetworkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1 * 255)
      ..strokeWidth = 1;

    // Draw network lines
    for (int i = 0; i < 5; i++) {
      final y = size.height * (i / 5);
      canvas.drawLine(Offset(0, y), Offset(size.width, y + 20), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
