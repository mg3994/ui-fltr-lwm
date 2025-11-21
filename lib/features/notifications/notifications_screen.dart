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
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
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
                TextButton.icon(
                  onPressed: () {
                    notifications.value = notifications.value.map((n) {
                      return {...n, 'read': true};
                    }).toList();
                  },
                  icon: const Icon(Icons.done_all, size: 18),
                  label: const Text('Mark all read'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
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
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest
                                .withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.notifications_off_outlined,
                            size: 48,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        const Gap(24),
                        Text(
                          'No notifications',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          'You\'re all caught up!',
                          style: TextStyle(
                            fontSize: 14,
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
                              color: Colors.red.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: 28,
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
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
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
                                        .surfaceContainerHighest
                                        .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isRead
                                    ? Theme.of(context)
                                          .colorScheme
                                          .outlineVariant
                                          .withValues(alpha: 0.5)
                                    : Theme.of(context).colorScheme.primary
                                          .withValues(alpha: 0.2),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(
                                    context,
                                  ).shadowColor.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  // Mark as read on tap
                                  final updatedList = [...notifications.value];
                                  updatedList[index] = {...n, 'read': true};
                                  notifications.value = updatedList;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: (n['color'] as Color)
                                              .withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          n['icon'] as IconData,
                                          color: n['color'] as Color,
                                          size: 24,
                                        ),
                                      ),
                                      const Gap(16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    n['title'] as String,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: isRead
                                                          ? FontWeight.w600
                                                          : FontWeight.bold,
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.onSurface,
                                                    ),
                                                  ),
                                                ),
                                                if (!isRead)
                                                  Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary
                                                                  .withValues(
                                                                    alpha: 0.4,
                                                                  ),
                                                          blurRadius: 4,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const Gap(4),
                                            Text(
                                              n['body'] as String,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                height: 1.4,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSurfaceVariant,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const Gap(8),
                                            Text(
                                              n['time'] as String,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.outline,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
