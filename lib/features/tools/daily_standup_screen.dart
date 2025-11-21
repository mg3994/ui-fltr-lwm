import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class DailyStandupScreen extends HookWidget {
  const DailyStandupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final updates = [
      {
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'yesterday':
            'Completed the login screen UI and integrated Firebase Auth.',
        'today': 'Start working on the dashboard layout.',
        'blockers': 'None currently.',
        'mood': 4,
      },
      {
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'yesterday': 'Researched state management options.',
        'today': 'Set up Riverpod and basic folder structure.',
        'blockers': 'Had some issues with Flutter version compatibility.',
        'mood': 3,
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
                'Daily Standup',
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
                icon: const Icon(Icons.history),
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Today's Check-in Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.tertiary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today's Check-in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.edit_calendar, color: Colors.white),
                          ],
                        ),
                        const Gap(8),
                        Text(
                          'Keep your mentor updated with your progress.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 14,
                          ),
                        ),
                        const Gap(24),
                        FilledButton(
                          onPressed: () {
                            _showCheckInModal(context);
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text('Post Update'),
                        ),
                      ],
                    ),
                  ),
                  const Gap(32),

                  // History
                  const Text(
                    'Recent Updates',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Gap(16),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final update = updates[index];
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 400 + (index * 100)),
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
                  child: _UpdateCard(update: update),
                );
              }, childCount: updates.length),
            ),
          ),
          const SliverGap(80),
        ],
      ),
    );
  }

  void _showCheckInModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'New Check-in',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildQuestion(
                      context,
                      'What did you accomplish yesterday?',
                      'Completed the login screen...',
                    ),
                    const Gap(24),
                    _buildQuestion(
                      context,
                      'What will you work on today?',
                      'Start the dashboard implementation...',
                    ),
                    const Gap(24),
                    _buildQuestion(
                      context,
                      'Any blockers?',
                      'Need help with Firebase config...',
                    ),
                    const Gap(24),
                    const Text(
                      'How are you feeling?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _MoodIcon(
                          icon: Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                          isSelected: false,
                        ),
                        _MoodIcon(
                          icon: Icons.sentiment_dissatisfied,
                          color: Colors.orange,
                          isSelected: false,
                        ),
                        _MoodIcon(
                          icon: Icons.sentiment_neutral,
                          color: Colors.amber,
                          isSelected: false,
                        ),
                        _MoodIcon(
                          icon: Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                          isSelected: true,
                        ),
                        _MoodIcon(
                          icon: Icons.sentiment_very_satisfied,
                          color: Colors.green,
                          isSelected: false,
                        ),
                      ],
                    ),
                    const Gap(40),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => Navigator.pop(context),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Submit Update'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, String question, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Gap(12),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _MoodIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool isSelected;

  const _MoodIcon({
    required this.icon,
    required this.color,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? color.withValues(alpha: 0.2) : Colors.transparent,
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: color, width: 2) : null,
      ),
      child: Icon(
        icon,
        size: 32,
        color: isSelected
            ? color
            : Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
      ),
    );
  }
}

class _UpdateCard extends StatelessWidget {
  final Map<String, dynamic> update;

  const _UpdateCard({required this.update});

  @override
  Widget build(BuildContext context) {
    final date = update['date'] as DateTime;
    final formattedDate = '${date.day}/${date.month}';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primaryContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const Gap(12),
                    Text(
                      'Daily Update',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                _MoodIconSmall(mood: update['mood'] as int),
              ],
            ),
            const Gap(16),
            _buildSection(context, 'Yesterday', update['yesterday'] as String),
            const Gap(12),
            _buildSection(context, 'Today', update['today'] as String),
            const Gap(12),
            _buildSection(
              context,
              'Blockers',
              update['blockers'] as String,
              isBlocker: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String label,
    String content, {
    bool isBlocker = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isBlocker
                ? Colors.red
                : Theme.of(context).colorScheme.primary,
          ),
        ),
        const Gap(4),
        Text(
          content,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _MoodIconSmall extends StatelessWidget {
  final int mood;

  const _MoodIconSmall({required this.mood});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (mood) {
      case 1:
        icon = Icons.sentiment_very_dissatisfied;
        color = Colors.red;
        break;
      case 2:
        icon = Icons.sentiment_dissatisfied;
        color = Colors.orange;
        break;
      case 3:
        icon = Icons.sentiment_neutral;
        color = Colors.amber;
        break;
      case 4:
        icon = Icons.sentiment_satisfied;
        color = Colors.lightGreen;
        break;
      case 5:
        icon = Icons.sentiment_very_satisfied;
        color = Colors.green;
        break;
      default:
        icon = Icons.sentiment_neutral;
        color = Colors.grey;
    }

    return Icon(icon, color: color, size: 24);
  }
}
