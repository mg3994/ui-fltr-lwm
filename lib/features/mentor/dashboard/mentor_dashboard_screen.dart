import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:linkwithmentor/features/mentor/schedule/schedule_screen.dart';
import 'package:linkwithmentor/features/mentor/dashboard/payouts_screen.dart';
import 'package:linkwithmentor/features/notifications/notifications_screen.dart';

class MentorDashboardScreen extends HookWidget {
  const MentorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: 0.2),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                  ),
                ),
              ),
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dashboard',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationsScreen(),
                            ),
                          );
                        },
                      ),
                      const Gap(8),
                      const CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/150?u=1',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _StatsOverview(),
                    const Gap(32),
                    const _EarningsChart(),
                    const Gap(32),
                    const _ActionButtons(),
                    const Gap(32),
                    const _PendingRequests(),
                    const Gap(80), // Bottom padding
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _StatsOverview extends StatelessWidget {
  const _StatsOverview();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Total Earnings',
                value: '\$1,250',
                icon: Icons.attach_money,
                color: Colors.green,
                trend: '+12%',
                onTap: () {},
              ),
            ),
            const Gap(16),
            Expanded(
              child: _StatCard(
                title: 'Upcoming',
                value: '8 Sessions',
                icon: Icons.calendar_today,
                color: Colors.blue,
                trend: 'Today',
                onTap: () {},
              ),
            ),
          ],
        ),
        const Gap(16),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Profile Views',
                value: '1.2k',
                icon: Icons.visibility,
                color: Colors.purple,
                trend: '+5%',
                onTap: () {},
              ),
            ),
            const Gap(16),
            Expanded(
              child: _StatCard(
                title: 'Rating',
                value: '4.9',
                icon: Icons.star,
                color: Colors.amber,
                trend: 'Top 5%',
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String trend;
  final VoidCallback onTap;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      trend,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(16),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
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
      ),
    );
  }
}

class _EarningsChart extends StatelessWidget {
  const _EarningsChart();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Weekly Activity',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.bar_chart,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          const Gap(24),
          SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((
                day,
              ) {
                // Mock heights
                final height = (day.length * 20.0) + (day.codeUnitAt(0) % 50);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 12,
                      height: height,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withValues(
                          alpha: day == 'Fri' ? 1.0 : 0.3,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const Gap(8),
                    Text(
                      day[0],
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.edit_calendar,
            label: 'Availability',
            color: Colors.orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScheduleScreen()),
              );
            },
          ),
        ),
        const Gap(16),
        Expanded(
          child: _ActionButton(
            icon: Icons.account_balance_wallet,
            label: 'Payouts',
            color: Colors.teal,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PayoutsScreen()),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const Gap(8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PendingRequests extends HookWidget {
  const _PendingRequests();

  @override
  Widget build(BuildContext context) {
    final requests = useState([
      {
        'name': 'Alex Johnson',
        'topic': 'Flutter Architecture Review',
        'time': 'Tomorrow, 10 AM',
        'image': 'https://i.pravatar.cc/150?u=10',
      },
      {
        'name': 'Sam Wilson',
        'topic': 'Career Guidance',
        'time': 'Fri, 2 PM',
        'image': 'https://i.pravatar.cc/150?u=11',
      },
      {
        'name': 'Kate Moore',
        'topic': 'Resume Review',
        'time': 'Sat, 11 AM',
        'image': 'https://i.pravatar.cc/150?u=12',
      },
    ]);

    if (requests.value.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: Text('No pending requests')),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Pending Requests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(onPressed: () {}, child: const Text('See All')),
          ],
        ),
        const Gap(16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: requests.value.length,
          separatorBuilder: (context, index) => const Gap(16),
          itemBuilder: (context, index) {
            final req = requests.value[index];
            return _RequestCard(
              name: req['name']!,
              topic: req['topic']!,
              time: req['time']!,
              imageUrl: req['image']!,
              onAccept: () {
                final newList = List<Map<String, String>>.from(requests.value);
                newList.removeAt(index);
                requests.value = newList;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request Accepted')),
                );
              },
              onReject: () {
                final newList = List<Map<String, String>>.from(requests.value);
                newList.removeAt(index);
                requests.value = newList;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request Rejected')),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _RequestCard extends StatelessWidget {
  final String name;
  final String topic;
  final String time;
  final String imageUrl;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _RequestCard({
    required this.name,
    required this.topic,
    required this.time,
    required this.imageUrl,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        topic,
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    time,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(
                        color: Colors.red.withValues(alpha: 0.5),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Decline'),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: FilledButton(
                    onPressed: onAccept,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Accept'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
