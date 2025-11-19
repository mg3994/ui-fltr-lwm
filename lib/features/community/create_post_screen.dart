import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class CreatePostScreen extends HookWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final bodyController = useTextEditingController();
    final selectedTag = useState<String?>('Flutter');

    final tags = ['Flutter', 'Career', 'Interview', 'Resume', 'Dart'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Question'),
        actions: [
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  bodyController.text.isNotEmpty) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Question Posted!')),
                );
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'e.g. How to optimize Flutter performance?',
              border: OutlineInputBorder(),
            ),
          ),
          const Gap(16),
          const Text(
            'Select Tag',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          Wrap(
            spacing: 8,
            children: tags.map((tag) {
              return ChoiceChip(
                label: Text(tag),
                selected: selectedTag.value == tag,
                onSelected: (selected) {
                  if (selected) selectedTag.value = tag;
                },
              );
            }).toList(),
          ),
          const Gap(16),
          TextField(
            controller: bodyController,
            maxLines: 10,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Describe your question in detail...',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
    );
  }
}
