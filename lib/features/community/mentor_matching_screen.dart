import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class MentorMatchingScreen extends HookWidget {
  const MentorMatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final matches = [
      {
        'name': 'Dr. Sarah Johnson',
        'title': 'Senior Flutter Developer at Google',
        'matchScore': 95,
        'expertise': ['Flutter', 'Dart', 'Mobile Architecture'],
        'availability': 'Weekends',
        'responseTime': '< 2 hours',
        'image': 'https://i.pravatar.cc/150?u=sarah',
        'color': Colors.blue,
        'sessionsCompleted': 156,
      },
      {
        'name': 'Michael Chen',
        'title': 'Tech Lead at Microsoft',
        'matchScore': 88,
        'expertise': ['System Design', 'Cloud', 'Leadership'],
        'availability': 'Evenings',
        'responseTime': '< 4 hours',
        'image': 'https://i.pravatar.cc/150?u=michael',
        'color': Colors.purple,
        'sessionsCompleted': 203,
      },
      {
        'name': 'Emily Rodriguez',
        'title': 'Senior Software Engineer at Meta',
        'matchScore': 82,
        'expertise': ['React Native', 'TypeScript', 'Web3'],
        'availability': 'Flexible',
        'responseTime': '< 1 hour',
        'image': 'https://i.pravatar.cc/150?u=emily',
        'color': Colors.green,
        'sessionsCompleted': 98,
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.pink.withValues(alpha: 0.3),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mentor Matching',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.pink.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '🎯 AI-Powered Matches',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.tune), onPressed: () {}),
              const Gap(8),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final match = matches[index];
                final matchScore = match['matchScore'] as int;

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 400 + index * 150),
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.scale(
                      scale: 0.9 + (0.1 * value),
                      child: child,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (match['color'] as Color).withValues(alpha: 0.05),
                          Theme.of(context).colorScheme.surface,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: (match['color'] as Color).withValues(alpha: 0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (match['color'] as Color).withValues(
                            alpha: 0.1,
                          ),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                          match['image'] as String,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: match['color'] as Color,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.surface,
                                              width: 3,
                                            ),
                                          ),
                                          child: Text(
                                            '$matchScore%',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                                                match['name'] as String,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.verified,
                                              color: match['color'] as Color,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        const Gap(4),
                                        Text(
                                          match['title'] as String,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                        const Gap(8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 14,
                                              color: Colors.amber,
                                            ),
                                            const Gap(4),
                                            Text(
                                              '${match['sessionsCompleted']} sessions',
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(20),
                              const Divider(),
                              const Gap(16),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Expertise:',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Gap(8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: (match['expertise'] as List<String>)
                                    .map(
                                      (skill) => Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: (match['color'] as Color)
                                              .withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: (match['color'] as Color)
                                                .withValues(alpha: 0.3),
                                          ),
                                        ),
                                        child: Text(
                                          skill,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: match['color'] as Color,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const Gap(16),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              size: 14,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                            ),
                                            const Gap(4),
                                            Text(
                                              match['availability'] as String,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.flash_on,
                                              size: 14,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                            ),
                                            const Gap(4),
                                            Text(
                                              match['responseTime'] as String,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: (match['color'] as Color).withValues(
                              alpha: 0.05,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(26),
                              bottomRight: Radius.circular(26),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.person, size: 16),
                                  label: const Text('View Profile'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: match['color'] as Color,
                                    side: BorderSide(
                                      color: (match['color'] as Color)
                                          .withValues(alpha: 0.5),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.message, size: 16),
                                  label: const Text('Connect'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: match['color'] as Color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: matches.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
    );
  }
}
