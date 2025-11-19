import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      (
        title: 'Session Confirmed',
        body:
            'Your session with Sarah Jenkins is confirmed for tomorrow at 2:00 PM.',
        time: '2m ago',
        icon: Icons.check_circle,
        color: Colors.green,
      ),
      (
        title: 'New Message',
        body: 'David Chen sent you a message: "Hey, are we still on for..."',
        time: '1h ago',
        icon: Icons.message,
        color: Colors.blue,
      ),
      (
        title: 'Payment Successful',
        body: 'You have successfully paid \$50.00 for your session.',
        time: '1d ago',
        icon: Icons.payment,
        color: Colors.purple,
      ),
      (
        title: 'Rate your experience',
        body: 'How was your session with Emily Davis? Tap to rate.',
        time: '2d ago',
        icon: Icons.star,
        color: Colors.amber,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Mark all read')),
        ],
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final n = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: n.color.withOpacity(0.1),
              child: Icon(n.icon, color: n.color, size: 20),
            ),
            title: Text(
              n.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(4),
                Text(n.body),
                const Gap(4),
                Text(
                  n.time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            isThreeLine: true,
            onTap: () {},
          );
        },
      ),
    );
  }
}
