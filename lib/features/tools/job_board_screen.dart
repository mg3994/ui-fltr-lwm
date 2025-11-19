import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class JobBoardScreen extends HookWidget {
  const JobBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState('All');
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
          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: filters.map((filter) {
                final isSelected = selectedFilter.value == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) selectedFilter.value = filter;
                    },
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
                return _JobCard(job: job);
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
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(job['logo'] as String),
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
                    icon: Icons.location_on,
                    label: job['location'] as String,
                  ),
                  const Gap(12),
                  _InfoChip(icon: Icons.work, label: job['type'] as String),
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
                    icon: Icons.people,
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
                      color: (job['color'] as Color).withOpacity(0.1),
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
