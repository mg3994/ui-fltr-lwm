import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:linkwithmentor/core/data/mock_data.dart';
import 'package:linkwithmentor/features/shared/call/call_screen.dart';
import 'package:linkwithmentor/features/shared/session_details_screen.dart';

class SessionsScreen extends HookWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0); // 0: Upcoming, 1: Past

    return Scaffold(
      appBar: AppBar(title: const Text('Sessions'), centerTitle: false),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Upcoming')),
                ButtonSegment(value: 1, label: Text('Past')),
              ],
              selected: {selectedTab.value},
              onSelectionChanged: (newSelection) {
                selectedTab.value = newSelection.first;
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: kMockSessions.length,
              separatorBuilder: (context, index) => const Gap(16),
              itemBuilder: (context, index) {
                final session = kMockSessions[index];
                // Filter based on tab
                if (selectedTab.value == 0 && !session.isUpcoming) {
                  return const SizedBox.shrink();
                }
                if (selectedTab.value == 1 && session.isUpcoming) {
                  return const SizedBox.shrink();
                }

                return SessionCard(session: session);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SessionCard extends StatelessWidget {
  final Session session;
  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final isUpcoming = session.isUpcoming;
    final dateFormat = DateFormat('MMM d, y • h:mm a');

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SessionDetailsScreen(
                mentorName: session.mentor.name,
                topic: session.topic,
                time: DateFormat('MMM d, y • h:mm a').format(session.dateTime),
                image: session.mentor.imageUrl,
                isPast: !isUpcoming,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(session.mentor.imageUrl),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session.mentor.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          session.mentor.title,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isUpcoming)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Confirmed',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const Gap(16),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const Gap(8),
                  Text(
                    dateFormat.format(session.dateTime),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const Gap(8),
              Row(
                children: [
                  const Icon(
                    Icons.topic_outlined,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const Gap(8),
                  Text(session.topic),
                ],
              ),
              const Gap(16),
              SizedBox(
                width: double.infinity,
                child: isUpcoming
                    ? FilledButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CallScreen(
                                userName: session.mentor.name,
                                userImage: session.mentor.imageUrl,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.video_call),
                        label: const Text('Join Call'),
                      )
                    : OutlinedButton(
                        onPressed: () {},
                        child: const Text('View History'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
