import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

/// Premium Insights Screen
///
/// This screen aggregates key user metrics (e.g., total connections,
/// completed courses, earned badges) into a premium‑styled dashboard.
/// It follows the project's visual language: glass‑morphism, gradient
/// backgrounds, and subtle micro‑animations.
class PremiumInsightsScreen extends HookWidget {
  const PremiumInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data – replace with real providers later
    final metrics = [
      {'label': 'Connections', 'value': '124', 'color': Colors.indigo},
      {'label': 'Courses Completed', 'value': '27', 'color': Colors.teal},
      {'label': 'Badges Earned', 'value': '15', 'color': Colors.orange},
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // -----------------------------------------------------------------
          // App bar with gradient + glass effect
          // -----------------------------------------------------------------
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Premium Insights'),
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
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(16, 80, 16, 16),
                  child: Text(
                    'Your performance at a glance',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          // -----------------------------------------------------------------
          // Metrics grid
          // -----------------------------------------------------------------
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = metrics[index];
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + index * 100),
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.scale(
                      scale: 0.95 + (0.05 * value),
                      child: child,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (item['color'] as Color).withValues(alpha: 0.1),
                          Theme.of(context).colorScheme.surface,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: (item['color'] as Color).withValues(alpha: 0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (item['color'] as Color).withValues(
                            alpha: 0.1,
                          ),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['value'] as String,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: item['color'] as Color,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          item['label'] as String,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: metrics.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
            ),
          ),
          // -----------------------------------------------------------------
          // Activity timeline (mock)
          // -----------------------------------------------------------------
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final activities = [
                  {
                    'title': 'Earned "Mentor" badge',
                    'date': '2024‑02‑10',
                    'color': Colors.purple,
                  },
                  {
                    'title': 'Completed "Flutter Basics" course',
                    'date': '2024‑01‑22',
                    'color': Colors.teal,
                  },
                  {
                    'title': 'Connected with 5 new mentors',
                    'date': '2023‑12‑15',
                    'color': Colors.indigo,
                  },
                ];
                final act = activities[index];
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + index * 120),
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: child,
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: act['color'] as Color,
                    ),
                    title: Text(
                      act['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('On ${act['date']}'),
                  ),
                );
              }, childCount: 3),
            ),
          ),
          const SliverGap(80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.insights),
        label: const Text('Explore More'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    );
  }
}
