import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class ReviewScreen extends HookWidget {
  final String mentorName;
  const ReviewScreen({super.key, required this.mentorName});

  @override
  Widget build(BuildContext context) {
    final rating = useState(0);
    final feedbackController = useTextEditingController();
    final selectedTags = useState<Set<String>>({});

    final tags = [
      'Knowledgeable',
      'Patient',
      'Good Communication',
      'Helpful',
      'Expert',
      'Friendly',
    ];

    void showSuccessDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 64),
              const Gap(16),
              const Text(
                'Review Submitted!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Gap(8),
              Text('Thanks for reviewing $mentorName.'),
            ],
          ),
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.pop(context); // Close dialog
          Navigator.pop(context); // Close screen
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Write a Review')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'How was your session with $mentorName?',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Gap(32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: AnimatedScale(
                  scale: index < rating.value ? 1.2 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    index < rating.value ? Icons.star : Icons.star_border,
                    size: 40,
                    color: Colors.amber,
                  ),
                ),
                onPressed: () => rating.value = index + 1,
              );
            }),
          ),
          const Gap(32),
          const Text(
            'What did you like?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Gap(12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((tag) {
              final isSelected = selectedTags.value.contains(tag);
              return FilterChip(
                label: Text(tag),
                selected: isSelected,
                onSelected: (selected) {
                  final newTags = Set<String>.from(selectedTags.value);
                  if (selected) {
                    newTags.add(tag);
                  } else {
                    newTags.remove(tag);
                  }
                  selectedTags.value = newTags;
                },
              );
            }).toList(),
          ),
          const Gap(32),
          TextField(
            controller: feedbackController,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Additional Feedback',
              hintText: 'Share more details about your experience...',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
          const Gap(32),
          FilledButton(
            onPressed: () {
              if (rating.value > 0) {
                showSuccessDialog();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select a rating')),
                );
              }
            },
            child: const Text('Submit Review'),
          ),
        ],
      ),
    );
  }
}
