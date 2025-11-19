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
      appBar: AppBar(
        title: const Text('Mentor Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=1'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _StatsOverview(),
          const Gap(24),
          const _ActionButtons(),
          const Gap(24),
          const _PendingRequests(),
        ],
      ),
    );
  }
}

class _StatsOverview extends StatelessWidget {
  const _StatsOverview();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Total Earnings',
            value: '\$1,250',
            icon: Icons.attach_money,
            color: Colors.green,
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
            onTap: () {},
          ),
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
  final VoidCallback onTap;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Gap(12),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
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

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FilledButton.tonalIcon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScheduleScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.edit_calendar),
                label: const Text('Set Availability'),
              ),
            ),
            const Gap(16),
            Expanded(
              child: FilledButton.tonalIcon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PayoutsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.account_balance_wallet),
                label: const Text('Payouts'),
              ),
            ),
          ],
        ),
      ],
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
        const Gap(8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: requests.value.length,
          separatorBuilder: (_, __) => const Gap(12),
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
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        topic,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: const Text('Reject'),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: FilledButton(
                    onPressed: onAccept,
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
