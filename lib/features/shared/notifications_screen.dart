import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class NotificationsScreen extends HookWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState('All');
    final filters = ['All', 'Sessions', 'Messages', 'Updates'];

    final notifications = [
      {
        'title': 'Session Reminder',
        'message': 'Your session with John Doe starts in 30 minutes',
        'time': '5 min ago',
        'type': 'Sessions',
        'icon': Icons.event,
        'color': Colors.blue,
        'read': false,
      },
      {
        'title': 'New Message',
        'message': 'Sarah sent you a message about the project',
        'time': '1 hour ago',
        'type': 'Messages',
        'icon': Icons.message,
        'color': Colors.green,
        'read': false,
      },
      {
        'title': 'Session Completed',
        'message': 'Your session with Emily was marked as completed',
        'time': '3 hours ago',
        'type': 'Sessions',
        'icon': Icons.check_circle,
        'color': Colors.purple,
        'read': true,
      },
      {
        'title': 'New Feature Available',
        'message': 'Check out our new Resume Builder tool',
        'time': '1 day ago',
        'type': 'Updates',
        'icon': Icons.star,
        'color': Colors.amber,
        'read': true,
      },
      {
        'title': 'Payment Received',
        'message': 'You received \$150 for your session',
        'time': '2 days ago',
        'type': 'Updates',
        'icon': Icons.payments,
        'color': Colors.teal,
        'read': true,
      },
    ];

    final filteredNotifications = selectedFilter.value == 'All'
        ? notifications
        : notifications
              .where((n) => n['type'] == selectedFilter.value)
              .toList();

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
              title: Text(
                'Notifications',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
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
              TextButton(onPressed: () {}, child: const Text('Mark all read')),
              const Gap(8),
            ],
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: filters.map((filter) {
                  final isSelected = selectedFilter.value == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) selectedFilter.value = filter;
                      },
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      selectedColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? Colors.transparent
                            : Theme.of(context).colorScheme.outlineVariant
                                  .withValues(alpha: 0.5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final notification = filteredNotifications[index];
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + (index * 50)),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: _NotificationCard(notification: notification),
                );
              }, childCount: filteredNotifications.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
    );
  }
}

class _NotificationCard extends HookWidget {
  final Map<String, dynamic> notification;

  const _NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    final isRead = useState(notification['read'] as bool);

    return Dismissible(
      key: ValueKey(notification['title']),
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.redAccent],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {},
      child: GestureDetector(
        onTap: () {
          isRead.value = true;
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isRead.value
                    ? Theme.of(
                        context,
                      ).colorScheme.surface.withValues(alpha: 0.3)
                    : Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isRead.value
                      ? Theme.of(
                          context,
                        ).colorScheme.outlineVariant.withValues(alpha: 0.5)
                      : Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.3),
                  width: isRead.value ? 1 : 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Icon with gradient background
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            (notification['color'] as Color).withValues(
                              alpha: 0.3,
                            ),
                            (notification['color'] as Color).withValues(
                              alpha: 0.1,
                            ),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        notification['icon'] as IconData,
                        color: notification['color'] as Color,
                        size: 24,
                      ),
                    ),
                    const Gap(16),

                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  notification['title'] as String,
                                  style: TextStyle(
                                    fontWeight: isRead.value
                                        ? FontWeight.w600
                                        : FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              if (!isRead.value)
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                          const Gap(4),
                          Text(
                            notification['message'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
                                notification['time'] as String,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
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
  }
}
