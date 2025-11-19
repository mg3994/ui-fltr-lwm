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
      appBar: AppBar(title: const Text('Find Your Perfect Mentor')),
      body: Column(
        children: [
          // Progress Indicator
          LinearProgressIndicator(
            value: (currentStep.value + 1) / 4,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest,
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                if (currentStep.value == 0) ...[
                  const Text(
                    'What are your goals?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Gap(8),
                  const Text('Select all that apply'),
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
                      );
                    }).toList(),
                  ),
                ] else if (currentStep.value == 1) ...[
                  const Text(
                    'What skills do you want to learn?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Gap(8),
                  const Text('Choose your focus areas'),
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
                      );
                    }).toList(),
                  ),
                ] else if (currentStep.value == 2) ...[
                  const Text(
                    'When are you available?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Gap(8),
                  const Text('Select your preferred time slots'),
                  const Gap(24),
                  ...availability.map((time) {
                    final isSelected = selectedAvailability.value.contains(
                      time,
                    );
                    return CheckboxListTile(
                      title: Text(time),
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
                    );
                  }),
                ] else ...[
                  const Text(
                    'Your Perfect Matches',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Gap(8),
                  const Text(
                    'Based on your preferences, we found these mentors for you',
                  ),
                  const Gap(24),
                  _MatchCard(
                    name: 'Sarah Jenkins',
                    title: 'Senior Flutter Developer',
                    avatar: 'https://i.pravatar.cc/150?u=1',
                    matchScore: 95,
                    skills: ['Flutter', 'Dart', 'Firebase'],
                    rating: 4.9,
                  ),
                  _MatchCard(
                    name: 'David Chen',
                    title: 'Product Designer',
                    avatar: 'https://i.pravatar.cc/150?u=2',
                    matchScore: 88,
                    skills: ['UI/UX', 'Figma', 'Prototyping'],
                    rating: 4.8,
                  ),
                  _MatchCard(
                    name: 'Michael Brown',
                    title: 'Mobile Architect',
                    avatar: 'https://i.pravatar.cc/150?u=4',
                    matchScore: 92,
                    skills: ['iOS', 'Android', 'System Design'],
                    rating: 5.0,
                  ),
                ],
              ],
            ),
          ),

          // Navigation Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (currentStep.value > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => currentStep.value--,
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
                    child: Text(currentStep.value == 3 ? 'Done' : 'Next'),
                  ),
                ),
              ],
            ),
          ),
        ],
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
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(avatar),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
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
                      Text(title),
                      const Gap(4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const Gap(4),
                          Text('$rating'),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
