import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:linkwithmentor/features/community/create_post_screen.dart';
import 'package:linkwithmentor/features/community/post_details_screen.dart';

class ForumScreen extends HookWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTag = useState('All');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Q&A'),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostScreen()),
          );
        },
        label: const Text('Ask Question'),
        icon: const Icon(Icons.add_comment),
      ),
      body: Column(
        children: [
          // Tags Filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              children:
                  [
                    'All',
                    'Flutter',
                    'Career',
                    'Interview',
                    'Resume',
                    'Dart',
                  ].map((tag) {
                    final isSelected = selectedTag.value == tag;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(tag),
                        selected: isSelected,
                        onSelected: (selected) => selectedTag.value = tag,
                      ),
                    );
                  }).toList(),
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              separatorBuilder: (context, index) => const Gap(16),
              itemBuilder: (context, index) {
                return const _QuestionCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostDetailsScreen()),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?u=20',
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Flutter',
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(12),
              const Text(
                'How to handle state management in large Flutter apps?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Gap(8),
              Text(
                'I am building a complex app and confused between Riverpod, Bloc, and GetX. What do you recommend for scalability?',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const Gap(16),
              Row(
                children: [
                  _InteractionButton(
                    icon: Icons.arrow_upward,
                    count: '24',
                    onTap: () {},
                  ),
                  const Gap(16),
                  _InteractionButton(
                    icon: Icons.arrow_downward,
                    count: '',
                    onTap: () {},
                  ),
                  const Gap(16),
                  _InteractionButton(
                    icon: Icons.chat_bubble_outline,
                    count: '12 Answers',
                    onTap: () {},
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

class _InteractionButton extends StatelessWidget {
  final IconData icon;
  final String count;
  final VoidCallback onTap;

  const _InteractionButton({
    required this.icon,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          if (count.isNotEmpty) ...[
            const Gap(4),
            Text(
              count,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
