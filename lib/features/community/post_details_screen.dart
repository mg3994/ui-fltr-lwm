import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class PostDetailsScreen extends HookWidget {
  final Map<String, String>? question;

  const PostDetailsScreen({super.key, this.question});

  @override
  Widget build(BuildContext context) {
    final commentController = useTextEditingController();
    final comments = useState<List<Map<String, String>>>([
      {
        'user': 'Sarah Smith',
        'avatar': 'https://i.pravatar.cc/150?u=21',
        'text':
            'I highly recommend Riverpod for its testability and compile-time safety.',
        'time': '2h ago',
      },
      {
        'user': 'Mike Ross',
        'avatar': 'https://i.pravatar.cc/150?u=22',
        'text':
            'Bloc is great for large enterprise apps where you need strict separation of concerns.',
        'time': '5h ago',
      },
    ]);

    final displayQuestion =
        question ??
        {
          'author': 'John Doe',
          'avatar': 'https://i.pravatar.cc/150?u=20',
          'time': '2 hours ago',
          'title': 'How to handle state management in large Flutter apps?',
          'body':
              'I am building a complex app and confused between Riverpod, Bloc, and GetX. What do you recommend for scalability? I need something that is easy to test and maintain.',
          'tag': 'Flutter',
        };

    return Scaffold(
      appBar: AppBar(title: const Text('Question Details')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Question Header
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(displayQuestion['avatar']!),
                    ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayQuestion['author']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          displayQuestion['time']!,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(16),
                Text(
                  displayQuestion['title']!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(12),
                Text(
                  displayQuestion['body']!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(16),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      label: const Text('Flutter'),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                    ),
                    Chip(
                      label: const Text('State Management'),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                    ),
                  ],
                ),
                const Gap(24),
                const Divider(),
                const Gap(16),
                Text(
                  '${comments.value.length} Answers',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(16),

                // Answers List
                ...comments.value.map(
                  (comment) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(comment['avatar']!),
                        ),
                        const Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    comment['user']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    comment['time']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(4),
                              Text(comment['text']!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Add Comment Input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                      hintText: 'Write an answer...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const Gap(12),
                IconButton.filled(
                  onPressed: () {
                    if (commentController.text.isNotEmpty) {
                      comments.value = [
                        ...comments.value,
                        {
                          'user': 'You',
                          'avatar': 'https://i.pravatar.cc/150?u=99',
                          'text': commentController.text,
                          'time': 'Just now',
                        },
                      ];
                      commentController.clear();
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
