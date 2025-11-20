import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class NotificationsScreen extends HookWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = useState([
      {
        'id': '1',
        'title': 'Session Confirmed',
        'body':
            'Your session with Sarah Jenkins is confirmed for tomorrow at 2:00 PM.',
        'time': '2m ago',
        'icon': Icons.check_circle,
        'color': Colors.green,
        'read': false,
      },
      {
        'id': '2',
        'title': 'New Message',
        'body': 'David Chen sent you a message: "Hey, are we still on for..."',
        'time': '1h ago',
        'icon': Icons.message,
        'color': Colors.blue,
        'read': false,
      },
      {
        'id': '3',
        'title': 'Payment Successful',
        'body': 'You have successfully paid \$50.00 for your session.',
        'time': '1d ago',
        'icon': Icons.payment,
        'color': Colors.purple,
        'read': true,
      },
      {
        'id': '4',
        'title': 'Rate your experience',
        'body': 'How was your session with Emily Davis? Tap to rate.',
        'time': '2d ago',
        'icon': Icons.star,
        'color': Colors.amber,
        'read': true,
      },
    ]);

    final unreadCount = notifications.value
        .where((n) => n['read'] == false)
        .length;

    Future<void> refreshNotifications() async {
      await Future.delayed(const Duration(seconds: 1));
      // Simulate fetching new data
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Notifications updated')));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Notifications'),
            if (unreadCount > 0) ...[
              const Gap(8),
              Badge(
                label: Text('$unreadCount'),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              notifications.value = notifications.value.map((n) {
                return {...n, 'read': true};
              }).toList();
            },
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshNotifications,
        child: notifications.value.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_off_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const Gap(16),
                    const Text('No notifications'),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: notifications.value.length,
                separatorBuilder: (_, index) => const Gap(12),
                itemBuilder: (context, index) {
                  final n = notifications.value[index];
                  final isRead = n['read'] as bool;

                  return Dismissible(
                    key: Key(n['id'] as String),
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      notifications.value = notifications.value
                          .where((item) => item['id'] != n['id'])
                          .toList();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Notification dismissed'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Simple undo logic could be added here
                            },
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: isRead ? 0 : 2,
                      color: isRead
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.surfaceContainerLow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isRead
                              ? Colors.transparent
                              : Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor: (n['color'] as Color).withValues(
                            alpha: 0.1,
                          ),
                          child: Icon(
                            n['icon'] as IconData,
                            color: n['color'] as Color,
                            size: 20,
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                n['title'] as String,
                                style: TextStyle(
                                  fontWeight: isRead
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                ),
                              ),
                            ),
                            if (!isRead)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(4),
                            Text(
                              n['body'] as String,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Gap(8),
                            Text(
                              n['time'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          // Mark as read on tap
                          final updatedList = [...notifications.value];
                          updatedList[index] = {...n, 'read': true};
                          notifications.value = updatedList;
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
