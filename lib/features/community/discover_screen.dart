import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class DiscoverScreen extends HookWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'Trending Mentors', 'icon': Icons.star, 'color': Colors.amber},
      {
        'title': 'New Communities',
        'icon': Icons.group,
        'color': Colors.blueAccent,
      },
      {
        'title': 'Featured Events',
        'icon': Icons.event,
        'color': Colors.deepPurple,
      },
    ];

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
                'Discover',
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
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              const Gap(8),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: categories.map((cat) {
                  return ChoiceChip(
                    label: Text(cat['title'] as String),
                    avatar: CircleAvatar(
                      backgroundColor: (cat['color'] as Color).withValues(
                        alpha: 0.2,
                      ),
                      child: Icon(
                        cat['icon'] as IconData,
                        color: cat['color'] as Color,
                        size: 18,
                      ),
                    ),
                    selected: false,
                    onSelected: (_) {},
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    selectedColor: (cat['color'] as Color).withValues(
                      alpha: 0.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // Placeholder for discovered content
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + index * 100),
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.scale(scale: value, child: child),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).shadowColor.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(child: Text('Item ${index + 1}')),
                  ),
                );
              }, childCount: 8),
            ),
          ),
          const SliverGap(80),
        ],
      ),
    );
  }
}
