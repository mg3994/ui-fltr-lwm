import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class SkillExchangeScreen extends HookWidget {
  const SkillExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for skill offers
    final offers = [
      {
        'title': 'Flutter UI Design',
        'owner': 'Alice',
        'skills': ['Flutter', 'Design'],
        'color': Colors.pink,
      },
      {
        'title': 'Backend Node.js',
        'owner': 'Bob',
        'skills': ['Node.js', 'Express', 'MongoDB'],
        'color': Colors.indigo,
      },
      {
        'title': 'Data Science',
        'owner': 'Carol',
        'skills': ['Python', 'Pandas', 'ML'],
        'color': Colors.teal,
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
              title: const Text('Skill Exchange'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepPurple.withValues(alpha: 0.3),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
                  child: const Text(
                    'Swap skills, grow together',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final offer = offers[index];
                final isEven = index % 2 == 0;
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + index * 100),
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: child,
                    ),
                  ),
                  child: _SkillCard(
                    title: offer['title'] as String,
                    owner: offer['owner'] as String,
                    skills: offer['skills'] as List<String>,
                    color: offer['color'] as Color,
                    alignLeft: isEven,
                  ),
                );
              }, childCount: offers.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Post Offer'),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final String title;
  final String owner;
  final List<String> skills;
  final Color color;
  final bool alignLeft;

  const _SkillCard({
    required this.title,
    required this.owner,
    required this.skills,
    required this.color,
    required this.alignLeft,
  });

  @override
  Widget build(BuildContext context) {
    // Glass‑morphic container
    return Align(
      alignment: alignLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.1),
              Theme.of(context).colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    owner,
                    style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Gap(12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills
                  .map(
                    (s) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(s, style: const TextStyle(fontSize: 12)),
                    ),
                  )
                  .toList(),
            ),
            const Gap(12),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.swap_horiz, size: 16),
              label: const Text('Exchange'),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
