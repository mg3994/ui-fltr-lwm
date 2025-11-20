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

    final questions = [
      {
        'id': '1',
        'author': 'John Doe',
        'avatar': 'https://i.pravatar.cc/150?u=20',
        'tag': 'Flutter',
        'title': 'How to handle state management in large Flutter apps?',
        'body':
            'I am building a complex app and confused between Riverpod, Bloc, and GetX. What do you recommend for scalability?',
        'votes': '24',
        'answers': '12',
        'time': '2h ago',
      },
      {
        'id': '2',
        'author': 'Alice Smith',
        'avatar': 'https://i.pravatar.cc/150?u=21',
        'tag': 'Career',
        'title': 'Is it worth learning native Android development in 2024?',
        'body':
            'I am a Flutter developer. Should I also learn Kotlin/Jetpack Compose to be more marketable?',
        'votes': '15',
        'answers': '8',
        'time': '5h ago',
      },
      {
        'id': '3',
        'author': 'Robert Brown',
        'avatar': 'https://i.pravatar.cc/150?u=22',
        'tag': 'Interview',
        'title': 'Top 50 Flutter Interview Questions for Senior Roles',
        'body':
            'I am preparing for a senior dev interview. Can anyone share their recent interview experiences?',
        'votes': '42',
        'answers': '20',
        'time': '1d ago',
      },
      {
        'id': '4',
        'author': 'Emily White',
        'avatar': 'https://i.pravatar.cc/150?u=23',
        'tag': 'Dart',
        'title': 'Understanding Isolates and Event Loop',
        'body':
            'Can someone explain how Isolates work in Dart and when to use them over simple Futures?',
        'votes': '30',
        'answers': '5',
        'time': '2d ago',
      },
    ];

    final filteredQuestions = selectedTag.value == 'All'
        ? questions
        : questions.where((q) => q['tag'] == selectedTag.value).toList();

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
              itemCount: filteredQuestions.length,
              separatorBuilder: (context, index) => const Gap(16),
              itemBuilder: (context, index) {
                return _QuestionCard(question: filteredQuestions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final Map<String, String> question;

  const _QuestionCard({required this.question});

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
            MaterialPageRoute(
              builder: (context) => PostDetailsScreen(question: question),
            ),
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
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(question['avatar']!),
                  ),
                  const Gap(8),
                  Text(
                    question['author']!,
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
                      question['tag']!,
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
              Text(
                question['title']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Gap(8),
              Text(
                question['body']!,
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
                    count: question['votes']!,
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
                    count: '${question['answers']} Answers',
                    onTap: () {},
                  ),
                  const Spacer(),
                  Text(
                    question['time']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
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
