import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class ActivityFeedScreen extends HookWidget {
  const ActivityFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'type': 'session_completed',
        'user': 'Sarah Jenkins',
        'avatar': 'https://i.pravatar.cc/150?u=1',
        'action': 'completed a session with you',
        'time': '2 hours ago',
        'details': 'Flutter State Management Review',
        'icon': Icons.video_call,
        'color': Colors.blue,
      },
      {
        'type': 'review_received',
        'user': 'John Doe',
        'avatar': 'https://i.pravatar.cc/150?u=10',
        'action': 'left you a 5-star review',
        'time': '5 hours ago',
        'details': '"Excellent mentor! Very knowledgeable."',
        'icon': Icons.star,
        'color': Colors.amber,
      },
      {
        'type': 'achievement_unlocked',
        'user': 'You',
        'avatar': 'https://i.pravatar.cc/150?u=1',
        'action': 'unlocked a new badge',
        'time': '1 day ago',
        'details': 'Session Master - 100 sessions completed',
        'icon': Icons.emoji_events,
        'color': Colors.purple,
      },
      {
        'type': 'new_follower',
        'user': 'Mike Johnson',
        'avatar': 'https://i.pravatar.cc/150?u=12',
        'action': 'started following you',
        'time': '1 day ago',
        'details': null,
        'icon': Icons.person_add,
        'color': Colors.green,
      },
      {
        'type': 'forum_answer',
        'user': 'Emily Davis',
        'avatar': 'https://i.pravatar.cc/150?u=3',
        'action': 'answered your question',
        'time': '2 days ago',
        'details': 'How to optimize Flutter performance?',
        'icon': Icons.forum,
        'color': Colors.orange,
      },
      {
        'type': 'session_booked',
        'user': 'Tom Brown',
        'avatar': 'https://i.pravatar.cc/150?u=14',
        'action': 'booked a session with you',
        'time': '2 days ago',
        'details': 'Tomorrow at 3:00 PM',
        'icon': Icons.calendar_today,
        'color': Colors.teal,
      },
      {
        'type': 'milestone',
        'user': 'You',
        'avatar': 'https://i.pravatar.cc/150?u=1',
        'action': 'reached a milestone',
        'time': '3 days ago',
        'details': '1000 total mentoring hours',
        'icon': Icons.trending_up,
        'color': Colors.pink,
      },
      {
        'type': 'referral_earned',
        'user': 'You',
        'avatar': 'https://i.pravatar.cc/150?u=1',
        'action': 'earned a referral bonus',
        'time': '4 days ago',
        'details': '+\$50 from Jane Smith signup',
        'icon': Icons.attach_money,
        'color': Colors.green,
      },
    ];

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
                'Activity Feed',
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
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surface.withValues(alpha: 0.5),
                ),
              ),
              const Gap(8),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final activity = activities[index];
                return _ActivityCard(activity: activity);
              }, childCount: activities.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final Map<String, dynamic> activity;

  const _ActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar with Icon Badge
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(activity['avatar'] as String),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: activity['color'] as Color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      activity['icon'] as IconData,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(12),

            // Activity Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: activity['user'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' ${activity['action']}'),
                      ],
                    ),
                  ),
                  if (activity['details'] != null) ...[
                    const Gap(4),
                    Text(
                      activity['details'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                  const Gap(8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const Gap(4),
                      Text(
                        activity['time'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Button (context-specific)
            if (activity['type'] == 'session_booked' ||
                activity['type'] == 'new_follower')
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {},
                style: IconButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
