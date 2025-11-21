import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class MentorSpotlightScreen extends HookWidget {
  const MentorSpotlightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);

    final spotlightMentors = [
      {
        'name': 'Sarah Jenkins',
        'title': 'Senior Flutter Developer',
        'company': 'Google',
        'avatar': 'https://i.pravatar.cc/300?u=1',
        'coverImage': 'https://picsum.photos/800/400?random=10',
        'rating': 4.9,
        'reviews': 127,
        'sessions': 250,
        'yearsExperience': 8,
        'hourlyRate': 75,
        'bio':
            'Passionate about mobile development and helping others grow. I\'ve worked on Flutter since its early days and love sharing my knowledge.',
        'specialties': ['Flutter', 'Dart', 'Firebase', 'State Management'],
        'achievements': [
          'Google Developer Expert',
          'Published 5 apps with 1M+ downloads',
          'Speaker at Flutter Conf 2023',
        ],
        'availability': 'Available Now',
        'responseTime': '< 1 hour',
        'languages': ['English', 'Spanish'],
        'timezone': 'PST (UTC-8)',
      },
      {
        'name': 'David Chen',
        'title': 'Product Design Lead',
        'company': 'Apple',
        'avatar': 'https://i.pravatar.cc/300?u=2',
        'coverImage': 'https://picsum.photos/800/400?random=11',
        'rating': 4.8,
        'reviews': 95,
        'sessions': 180,
        'yearsExperience': 10,
        'hourlyRate': 60,
        'bio':
            'Award-winning designer with a passion for creating delightful user experiences. I mentor designers at all levels.',
        'specialties': ['UI/UX', 'Figma', 'Design Systems', 'Prototyping'],
        'achievements': [
          'Red Dot Design Award Winner',
          'Led design for 3 award-winning apps',
          'Mentor of the Year 2023',
        ],
        'availability': 'Available Today',
        'responseTime': '< 2 hours',
        'languages': ['English', 'Mandarin'],
        'timezone': 'EST (UTC-5)',
      },
      {
        'name': 'Michael Brown',
        'title': 'Mobile Architect',
        'company': 'Meta',
        'avatar': 'https://i.pravatar.cc/300?u=4',
        'coverImage': 'https://picsum.photos/800/400?random=12',
        'rating': 5.0,
        'reviews': 203,
        'sessions': 320,
        'yearsExperience': 12,
        'hourlyRate': 120,
        'bio':
            'Building scalable mobile applications for over a decade. I help teams architect robust, performant mobile solutions.',
        'specialties': ['iOS', 'Android', 'System Design', 'Architecture'],
        'achievements': [
          'Built apps used by 100M+ users',
          'Tech Lead at 3 unicorn startups',
          'Published author on mobile architecture',
        ],
        'availability': 'Available Tomorrow',
        'responseTime': '< 30 min',
        'languages': ['English', 'French'],
        'timezone': 'CST (UTC-6)',
      },
    ];

    final mentor = spotlightMentors[currentIndex.value];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    mentor['coverImage'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.7),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.9),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              mentor['avatar'] as String,
                            ),
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mentor['name'] as String,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(4),
                              Text(
                                '${mentor['title']} at ${mentor['company']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withValues(alpha: 0.3),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Quick Stats
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.star,
                        value: '${mentor['rating']}',
                        label: '${mentor['reviews']} reviews',
                        color: Colors.amber,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.video_call,
                        value: '${mentor['sessions']}',
                        label: 'Sessions',
                        color: Colors.blue,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.work,
                        value: '${mentor['yearsExperience']}y',
                        label: 'Experience',
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),

                const Gap(24),

                // Bio
                Text(
                  'About',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(12),
                Text(
                  mentor['bio'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),

                const Gap(24),

                // Specialties
                Text(
                  'Specialties',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (mentor['specialties'] as List<String>).map((
                    skill,
                  ) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primaryContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const Gap(24),

                // Achievements
                Text(
                  'Achievements',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(12),
                ...(mentor['achievements'] as List<String>).map((achievement) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.outlineVariant.withValues(alpha: 0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).shadowColor.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.emoji_events,
                            color: Colors.amber,
                            size: 24,
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: Text(
                            achievement,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const Gap(24),

                // Availability & Details
                Text(
                  'Availability',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(12),
                Container(
                  padding: const EdgeInsets.all(20),
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
                        color: Theme.of(
                          context,
                        ).shadowColor.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _DetailRow(
                        icon: Icons.schedule,
                        label: 'Status',
                        value: mentor['availability'] as String,
                        valueColor: Colors.green,
                      ),
                      const Gap(16),
                      _DetailRow(
                        icon: Icons.access_time,
                        label: 'Response Time',
                        value: mentor['responseTime'] as String,
                      ),
                      const Gap(16),
                      _DetailRow(
                        icon: Icons.language,
                        label: 'Languages',
                        value: (mentor['languages'] as List<String>).join(', '),
                      ),
                      const Gap(16),
                      _DetailRow(
                        icon: Icons.public,
                        label: 'Timezone',
                        value: mentor['timezone'] as String,
                      ),
                    ],
                  ),
                ),

                const Gap(24),

                // Navigation Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    spotlightMentors.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentIndex.value == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: currentIndex.value == index
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),

                const Gap(24),

                // Navigation Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: currentIndex.value > 0
                            ? () => currentIndex.value--
                            : null,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Previous'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed:
                            currentIndex.value < spotlightMentors.length - 1
                            ? () => currentIndex.value++
                            : null,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Next'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Gap(100),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hourly Rate',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '\$${mentor['hourlyRate']}/hr',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const Gap(16),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Book Session'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const Gap(12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Gap(16),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
