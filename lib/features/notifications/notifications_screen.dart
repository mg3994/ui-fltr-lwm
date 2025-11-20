import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import 'package:linkwithmentor/core/state/app_state.dart';

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

    useEffect(() {
      // Sync global notification count
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appState.notificationCount.value = unreadCount;
      });
      return null;
    }, [unreadCount]);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (unreadCount > 0) ...{
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$unreadCount',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  },
                ],
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            actions: [
              if (unreadCount > 0)
                TextButton(
                  onPressed: () {
                    notifications.value = notifications.value.map((n) {
                      return {...n, 'read': true};
                    }).toList();
                  },
                  child: const Text('Mark all read'),
                ),
              const Gap(8),
            ],
          ),
          notifications.value.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_off_outlined,
                          size: 64,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const Gap(16),
                        Text(
                          'No notifications',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final n = notifications.value[index];
                      final isRead = n['read'] as bool;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Dismissible(
                          key: Key(n['id'] as String),
                          background: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: isRead
                                  ? Theme.of(context).colorScheme.surface
                                  : Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isRead
                                    ? Theme.of(context)
                                          .colorScheme
                                          .outlineVariant
                                          .withValues(alpha: 0.5)
                                    : Theme.of(context).colorScheme.primary
                                          .withValues(alpha: 0.3),
                                width: isRead ? 1 : 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).shadowColor
                                      .withValues(alpha: isRead ? 0.05 : 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: (n['color'] as Color).withValues(
                                    alpha: 0.15,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  n['icon'] as IconData,
                                  color: n['color'] as Color,
                                  size: 24,
                                ),
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      n['title'] as String,
                                      style: TextStyle(
                                        fontWeight: isRead
                                            ? FontWeight.w600
                                            : FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  if (!isRead)
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withValues(alpha: 0.5),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(6),
                                  Text(
                                    n['body'] as String,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      height: 1.4,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const Gap(8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 12,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                      ),
                                      const Gap(4),
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
                        ),
                      );
                    }, childCount: notifications.value.length),
                  ),
                ),
          const SliverGap(80),
        ],
      ),
    );
  }
}
