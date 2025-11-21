import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class CommunityPollsScreen extends HookWidget {
  const CommunityPollsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState('Active');
    final tabs = ['Active', 'Closed'];

    final polls = [
      {
        'id': 1,
        'question': 'What feature should we prioritize next?',
        'options': [
          'Live video calls',
          'Skill exchange',
          'Community events',
          'Analytics dashboard',
        ],
        'votes': [120, 80, 45, 30],
        'totalVotes': 275,
        'status': 'Active',
        'expires': 'Nov 30, 2024',
      },
      {
        'id': 2,
        'question': 'Which UI theme do you prefer?',
        'options': ['Dark', 'Light', 'System'],
        'votes': [200, 150, 50],
        'totalVotes': 400,
        'status': 'Closed',
        'expires': 'Oct 15, 2024',
      },
    ];

    final displayPolls = polls
        .where((p) => p['status'] == selectedTab.value)
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                'Community Polls',
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
                icon: const Icon(Icons.poll),
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withValues(alpha: 0.5),
                ),
              ),
              const Gap(8),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: tabs.map((tab) {
                  final isSelected = selectedTab.value == tab;
                  return Expanded(
                    child: InkWell(
                      onTap: () => selectedTab.value = tab,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          tab,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                          ),
                        ),
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
                final poll = displayPolls[index];
                return _PollCard(poll: poll);
              }, childCount: displayPolls.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Create Poll'),
        elevation: 2,
      ),
    );
  }
}

class _PollCard extends StatelessWidget {
  final Map<String, dynamic> poll;

  const _PollCard({required this.poll});

  @override
  Widget build(BuildContext context) {
    final isActive = poll['status'] == 'Active';
    final totalVotes = poll['totalVotes'] as int;
    final options = poll['options'] as List<String>;
    final votes = poll['votes'] as List<int>;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)
              : Theme.of(
                  context,
                ).colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question
            Text(
              poll['question'] as String,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(12),
            // Options with progress bars
            ...List.generate(options.length, (i) {
              final option = options[i];
              final voteCount = votes[i];
              final percent = totalVotes > 0 ? voteCount / totalVotes : 0.0;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        option,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        '${(percent * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const Gap(4),
                  LinearProgressIndicator(
                    value: percent,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Gap(12),
                ],
              );
            }),
            const Gap(8),
            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total votes: $totalVotes',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  'Expires: ${poll['expires']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const Gap(12),
            if (isActive)
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Vote Now'),
              ),
          ],
        ),
      ),
    );
  }
}
