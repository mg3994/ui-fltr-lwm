import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class JobBoardScreen extends HookWidget {
  const JobBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState('All');
    final searchController = useTextEditingController();
    final filters = ['All', 'Remote', 'Full-time', 'Part-time', 'Contract'];

    final jobs = [
      {
        'title': 'Senior Flutter Developer',
        'company': 'TechCorp Inc.',
        'logo': 'https://i.pravatar.cc/150?u=company1',
        'location': 'Remote',
        'type': 'Full-time',
        'salary': '\$100k - \$140k',
        'posted': '2 days ago',
        'applicants': 45,
        'skills': ['Flutter', 'Dart', 'Firebase'],
        'color': Colors.blue,
      },
      {
        'title': 'Mobile App Developer',
        'company': 'StartupXYZ',
        'logo': 'https://i.pravatar.cc/150?u=company2',
        'location': 'San Francisco, CA',
        'type': 'Full-time',
        'salary': '\$90k - \$120k',
        'posted': '5 days ago',
        'applicants': 78,
        'skills': ['React Native', 'JavaScript', 'iOS'],
        'color': Colors.purple,
      },
      {
        'title': 'UI/UX Designer',
        'company': 'DesignHub',
        'logo': 'https://i.pravatar.cc/150?u=company3',
        'location': 'Remote',
        'type': 'Contract',
        'salary': '\$70k - \$95k',
        'posted': '1 week ago',
        'applicants': 32,
        'skills': ['Figma', 'Adobe XD', 'Prototyping'],
        'color': Colors.pink,
      },
      {
        'title': 'Full Stack Engineer',
        'company': 'WebSolutions',
        'logo': 'https://i.pravatar.cc/150?u=company4',
        'location': 'New York, NY',
        'type': 'Full-time',
        'salary': '\$110k - \$150k',
        'posted': '3 days ago',
        'applicants': 62,
        'skills': ['React', 'Node.js', 'MongoDB'],
        'color': Colors.green,
      },
      {
        'title': 'DevOps Engineer',
        'company': 'CloudTech',
        'logo': 'https://i.pravatar.cc/150?u=company5',
        'location': 'Remote',
        'type': 'Part-time',
        'salary': '\$80k - \$110k',
        'posted': '4 days ago',
        'applicants': 28,
        'skills': ['Docker', 'Kubernetes', 'AWS'],
        'color': Colors.orange,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Board'),
        actions: [
          IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search jobs, companies, or skills...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: filters.map((filter) {
                final isSelected = selectedFilter.value == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: FilterChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) selectedFilter.value = filter;
                      },
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      selectedColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      checkmarkColor: Theme.of(
                        context,
                      ).colorScheme.onPrimaryContainer,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected
                              ? Colors.transparent
                              : Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Jobs List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
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
                  child: _JobCard(job: job),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final Map<String, dynamic> job;

  const _JobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(job['logo'] as String),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job['title'] as String,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          job['company'] as String,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ],
              ),
              const Gap(16),

              // Job Details
              Row(
                children: [
                  _InfoChip(
                    icon: Icons.location_on_outlined,
                    label: job['location'] as String,
                  ),
                  const Gap(12),
                  _InfoChip(
                    icon: Icons.work_outline,
                    label: job['type'] as String,
                  ),
                ],
              ),
              const Gap(8),
              Row(
                children: [
                  _InfoChip(
                    icon: Icons.attach_money,
                    label: job['salary'] as String,
                  ),
                  const Gap(12),
                  _InfoChip(
                    icon: Icons.people_outline,
                    label: '${job['applicants']} applicants',
                  ),
                ],
              ),

              const Gap(16),

              // Skills
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (job['skills'] as List<String>).map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: (job['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        fontSize: 12,
                        color: job['color'] as Color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),

              const Gap(16),

              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Posted ${job['posted']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Apply Now'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const Gap(4),
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
