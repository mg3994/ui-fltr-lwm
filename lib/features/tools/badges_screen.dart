import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class BadgesScreen extends HookWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample badge data – replace with real API later
    final badges = useState<List<Map<String, dynamic>>>([
      {
        'name': 'Early Adopter',
        'description': 'Joined in the first month',
        'icon': Icons.rocket_launch,
        'color': Colors.purple,
        'unlocked': true,
        'rarity': 'Legendary',
        'date': 'Jan 1, 2024',
      },
      {
        'name': 'Session Master',
        'description': 'Completed 100 sessions',
        'icon': Icons.video_call,
        'color': Colors.blue,
        'unlocked': false,
        'rarity': 'Epic',
        'progress': 0.66,
        'current': 66,
        'total': 100,
      },
    ]);

    final unlocked = badges.value.where((b) => b['unlocked'] == true).toList();
    final locked = badges.value.where((b) => b['unlocked'] == false).toList();

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
                'Badges',
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
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Stats Card
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutBack,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: 0.95 + (0.05 * value),
                      child: Opacity(opacity: value, child: child),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primaryContainer,
                          Theme.of(context).colorScheme.tertiaryContainer,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatColumn(
                          label: 'Unlocked',
                          value: '${unlocked.length}',
                          icon: Icons.check_circle,
                          color: Colors.green,
                        ),
                        Container(
                          width: 1,
                          height: 50,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                        _StatColumn(
                          label: 'Locked',
                          value: '${locked.length}',
                          icon: Icons.lock,
                          color: Colors.orange,
                        ),
                        Container(
                          width: 1,
                          height: 50,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                        _StatColumn(
                          label: 'Total',
                          value: '${badges.value.length}',
                          icon: Icons.emoji_events,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(32),
                // Unlocked Badges
                const Text(
                  'Unlocked Badges',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(16),
                ...unlocked.asMap().entries.map((e) {
                  final idx = e.key;
                  final badge = e.value;
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 400 + idx * 100),
                    curve: Curves.easeOut,
                    builder: (c, v, child) => Opacity(
                      opacity: v,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - v)),
                        child: child,
                      ),
                    ),
                    child: _BadgeCard(badge: badge, unlocked: true),
                  );
                }),
                const Gap(32),
                // Locked Badges
                const Text(
                  'Locked Badges',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(16),
                ...locked.asMap().entries.map((e) {
                  final idx = e.key;
                  final badge = e.value;
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 600 + idx * 100),
                    curve: Curves.easeOut,
                    builder: (c, v, child) => Opacity(
                      opacity: v,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - v)),
                        child: child,
                      ),
                    ),
                    child: _BadgeCard(badge: badge, unlocked: false),
                  );
                }),
                const Gap(80),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatColumn({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const Gap(12),
        Text(
          value,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final Map<String, dynamic> badge;
  final bool unlocked;
  const _BadgeCard({required this.badge, required this.unlocked});
  @override
  Widget build(BuildContext context) {
    final Color badgeColor = badge['color'] as Color;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: unlocked
                ? badgeColor.withValues(alpha: 0.15)
                : Theme.of(context).shadowColor.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: unlocked
              ? badgeColor.withValues(alpha: 0.3)
              : Theme.of(
                  context,
                ).colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: unlocked ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: unlocked
                    ? badgeColor.withValues(alpha: 0.15)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                border: Border.all(
                  color: unlocked
                      ? badgeColor
                      : Theme.of(context).colorScheme.outlineVariant,
                  width: 3,
                ),
                boxShadow: unlocked
                    ? [
                        BoxShadow(
                          color: badgeColor.withValues(alpha: 0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                badge['icon'] as IconData,
                size: 40,
                color: unlocked
                    ? badgeColor
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const Gap(20),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    badge['name'] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    badge['description'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Gap(12),
                  if (unlocked)
                    Row(
                      children: [
                        Icon(Icons.check_circle, size: 16, color: badgeColor),
                        const Gap(6),
                        Text(
                          'Unlocked on ${badge['date']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: badgeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Progress bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: badge['progress'] as double?,
                            minHeight: 8,
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              badgeColor,
                            ),
                          ),
                        ),
                        const Gap(8),
                        Text(
                          '${badge['current']} / ${badge['total']}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${((badge['progress'] as double?) ?? 0) * 100.toInt()}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: badgeColor,
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
    );
  }
}
