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
                icon: Icon(
                  index < rating.value ? Icons.star : Icons.star_border,
                  size: 40,
                  color: Colors.amber,
                ),
                onPressed: () => rating.value = index + 1,
              );
            }),
          ),
          const Gap(32),
          TextField(
            controller: feedbackController,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Your Feedback',
              hintText: 'What did you like? What could be better?',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
          const Gap(32),
          FilledButton(
            onPressed: () {
              if (rating.value > 0) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Review Submitted!')),
                );
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
