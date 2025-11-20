import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class MentorMatchingScreen extends HookWidget {
  const MentorMatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStep = useState(0);
    final selectedGoals = useState<List<String>>([]);
    final selectedSkills = useState<List<String>>([]);
    final selectedAvailability = useState<List<String>>([]);

    final goals = [
      'Career Growth',
      'Skill Development',
      'Job Search',
      'Networking',
      'Entrepreneurship',
    ];
    final skills = ['Flutter', 'React', 'Node.js', 'Python', 'UI/UX', 'DevOps'];
    final availability = [
      'Weekday Mornings',
      'Weekday Evenings',
      'Weekends',
      'Flexible',
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
                'Find Your Perfect Mentor',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
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
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Progress Indicator with Steps
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: List.generate(4, (index) {
                      final isActive = index <= currentStep.value;
                      return Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(
                                          context,
                                        ).colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            if (index < 3) const Gap(4),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                // Step Indicator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step ${currentStep.value + 1} of 4',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${((currentStep.value + 1) / 4 * 100).toInt()}% Complete',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (currentStep.value == 0) ...{
                  const Text(
                    'What are your goals?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Gap(8),
                  Text(
                    'Select all that apply',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Gap(24),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: goals.map((goal) {
                      final isSelected = selectedGoals.value.contains(goal);
                      return FilterChip(
                        label: Text(goal),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            selectedGoals.value = [
                              ...selectedGoals.value,
                              goal,
                            ];
                          } else {
                            selectedGoals.value = selectedGoals.value
                                .where((g) => g != goal)
                                .toList();
                          }
                        },
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        selectedColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? Colors.transparent
                              : Theme.of(context).colorScheme.outlineVariant
                                    .withValues(alpha: 0.5),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    }).toList(),
                  ),
                } else if (currentStep.value == 1) ...{
                  const Text(
                    'What skills do you want to learn?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Gap(8),
                  Text(
                    'Choose your focus areas',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Gap(24),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skills.map((skill) {
                      final isSelected = selectedSkills.value.contains(skill);
                      return FilterChip(
                        label: Text(skill),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            selectedSkills.value = [
                              ...selectedSkills.value,
                              skill,
                            ];
                          } else {
                            selectedSkills.value = selectedSkills.value
                                .where((s) => s != skill)
                                .toList();
                          }
                        },
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        selectedColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? Colors.transparent
                              : Theme.of(context).colorScheme.outlineVariant
                                    .withValues(alpha: 0.5),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    }).toList(),
                  ),
                } else if (currentStep.value == 2) ...{
                  const Text(
                    'When are you available?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Gap(8),
                  Text(
                    'Select your preferred time slots',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Gap(24),
                  ...availability.map((time) {
                    final isSelected = selectedAvailability.value.contains(
                      time,
                    );
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primaryContainer
                                  .withValues(alpha: 0.3)
                            : Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.5)
                              : Theme.of(context).colorScheme.outlineVariant
                                    .withValues(alpha: 0.5),
                        ),
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          time,
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        value: isSelected,
                        onChanged: (selected) {
                          if (selected == true) {
                            selectedAvailability.value = [
                              ...selectedAvailability.value,
                              time,
                            ];
                          } else {
                            selectedAvailability.value = selectedAvailability
                                .value
                                .where((t) => t != time)
                                .toList();
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }),
                } else ...{
                  const Text(
                    'Your Perfect Matches',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Gap(8),
                  Text(
                    'Based on your preferences, we found these mentors for you',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Gap(24),
                  _MatchCard(
                    name: 'Sarah Jenkins',
                    title: 'Senior Flutter Developer',
                    avatar: 'https://i.pravatar.cc/150?u=1',
                    matchScore: 95,
                    skills: const ['Flutter', 'Dart', 'Firebase'],
                    rating: 4.9,
                  ),
                  _MatchCard(
                    name: 'David Chen',
                    title: 'Product Designer',
                    avatar: 'https://i.pravatar.cc/150?u=2',
                    matchScore: 88,
                    skills: const ['UI/UX', 'Figma', 'Prototyping'],
                    rating: 4.8,
                  ),
                  _MatchCard(
                    name: 'Michael Brown',
                    title: 'Mobile Architect',
                    avatar: 'https://i.pravatar.cc/150?u=4',
                    matchScore: 92,
                    skills: const ['iOS', 'Android', 'System Design'],
                    rating: 5.0,
                  ),
                },
              ]),
            ),
          ),
          const SliverGap(80),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              if (currentStep.value > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => currentStep.value--,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Back'),
                  ),
                ),
              if (currentStep.value > 0) const Gap(16),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    if (currentStep.value < 3) {
                      currentStep.value++;
                    } else {
                      // Complete matching
                      Navigator.pop(context);
                    }
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(currentStep.value == 3 ? 'Done' : 'Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MatchCard extends StatelessWidget {
  final String name;
  final String title;
  final String avatar;
  final int matchScore;
  final List<String> skills;
  final double rating;

  const _MatchCard({
    required this.name,
    required this.title,
    required this.avatar,
    required this.matchScore,
    required this.skills,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.3),
                          width: 3,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(avatar),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.surface,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Gap(4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const Gap(4),
                          Text(
                            '$rating',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
            const Gap(16),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.person_add),
              label: const Text('Connect'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
