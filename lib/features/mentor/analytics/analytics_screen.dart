import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class AnalyticsScreen extends HookWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPeriod = useState('This Month');
    final periods = ['This Week', 'This Month', 'This Year'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          PopupMenuButton<String>(
            initialValue: selectedPeriod.value,
            onSelected: (value) => selectedPeriod.value = value,
            itemBuilder: (context) => periods
                .map(
                  (period) => PopupMenuItem(value: period, child: Text(period)),
                )
                .toList(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(selectedPeriod.value),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Key Metrics
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  title: 'Total Sessions',
                  value: '24',
                  change: '+12%',
                  isPositive: true,
                  icon: Icons.video_call,
                  color: Colors.blue,
                ),
              ),
              const Gap(16),
              Expanded(
                child: _MetricCard(
                  title: 'Earnings',
                  value: '\$1,250',
                  change: '+8%',
                  isPositive: true,
                  icon: Icons.attach_money,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  title: 'Avg Rating',
                  value: '4.9',
                  change: '+0.2',
                  isPositive: true,
                  icon: Icons.star,
                  color: Colors.amber,
                ),
              ),
              const Gap(16),
              Expanded(
                child: _MetricCard(
                  title: 'Response Time',
                  value: '2.5h',
                  change: '-15%',
                  isPositive: true,
                  icon: Icons.timer,
                  color: Colors.purple,
                ),
              ),
            ],
          ),

          const Gap(32),

          // Session Activity Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Session Activity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Gap(24),
                  SizedBox(
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(7, (index) {
                        final heights = [
                          80.0,
                          120.0,
                          100.0,
                          150.0,
                          90.0,
                          130.0,
                          110.0,
                        ];
                        final days = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun',
                        ];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 32,
                              height: heights[index],
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const Gap(8),
                            Text(
                              days[index],
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Gap(24),

          // Top Skills
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Most Requested Skills',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Gap(16),
                  _SkillBar(skill: 'Flutter', percentage: 0.85, sessions: 18),
                  const Gap(12),
                  _SkillBar(
                    skill: 'State Management',
                    percentage: 0.65,
                    sessions: 12,
                  ),
                  const Gap(12),
                  _SkillBar(
                    skill: 'UI/UX Design',
                    percentage: 0.45,
                    sessions: 8,
                  ),
                  const Gap(12),
                  _SkillBar(skill: 'Firebase', percentage: 0.35, sessions: 6),
                ],
              ),
            ),
          ),

          const Gap(24),

          // Recent Reviews
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Reviews',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Gap(16),
                  ...List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/150?u=${index + 10}',
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'John Doe',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    ...List.generate(
                                      5,
                                      (i) => const Icon(
                                        Icons.star,
                                        size: 14,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(4),
                                const Text(
                                  'Great session! Very helpful and knowledgeable.',
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    change,
                    style: TextStyle(
                      fontSize: 12,
                      color: isPositive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(12),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Gap(4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillBar extends StatelessWidget {
  final String skill;
  final double percentage;
  final int sessions;

  const _SkillBar({
    required this.skill,
    required this.percentage,
    required this.sessions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(skill, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(
              '$sessions sessions',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const Gap(8),
        LinearProgressIndicator(
          value: percentage,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}

