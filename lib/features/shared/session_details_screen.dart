import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:linkwithmentor/features/shared/review_screen.dart';
import 'package:linkwithmentor/features/shared/call/call_screen.dart';

class SessionDetailsScreen extends HookWidget {
  final String mentorName;
  final String topic;
  final String time;
  final String image;
  final bool isPast;

  const SessionDetailsScreen({
    super.key,
    required this.mentorName,
    required this.topic,
    required this.time,
    required this.image,
    required this.isPast,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Session Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header
          Center(
            child: Column(
              children: [
                CircleAvatar(radius: 50, backgroundImage: NetworkImage(image)),
                const Gap(16),
                Text(
                  mentorName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(8),
                Text(
                  topic,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Gap(32),

          // Details
          _DetailRow(
            icon: Icons.calendar_today,
            label: 'Date & Time',
            value: time,
          ),
          const Gap(16),
          const _DetailRow(
            icon: Icons.videocam,
            label: 'Platform',
            value: 'LinkWithMentor Video',
          ),
          const Gap(16),
          const _DetailRow(
            icon: Icons.attach_money,
            label: 'Cost',
            value: '\$50.00 (Paid)',
          ),

          const Gap(32),

          // Actions
          if (!isPast) ...[
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CallScreen(userName: mentorName, userImage: image),
                  ),
                );
              },
              icon: const Icon(Icons.video_call),
              label: const Text('Join Call'),
            ),
            const Gap(16),
            OutlinedButton(
              onPressed: () {
                // Cancel logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Session Cancelled')),
                );
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Cancel Session'),
            ),
          ] else ...[
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReviewScreen(mentorName: mentorName),
                  ),
                );
              },
              icon: const Icon(Icons.star),
              label: const Text('Leave a Review'),
            ),
            const Gap(16),
            OutlinedButton(onPressed: () {}, child: const Text('View Receipt')),
          ],
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        const Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
