import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class FeedbackScreen extends HookWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feedbackType = useState('Bug Report');
    final subjectController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final rating = useState(0);

    final feedbackTypes = [
      'Bug Report',
      'Feature Request',
      'General Feedback',
      'Complaint',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Send Feedback')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'We value your feedback!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          Text(
            'Help us improve LinkWithMentor by sharing your thoughts.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const Gap(32),

          // Feedback Type
          const Text(
            'Feedback Type',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          Wrap(
            spacing: 8,
            children: feedbackTypes.map((type) {
              final isSelected = feedbackType.value == type;
              return ChoiceChip(
                label: Text(type),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) feedbackType.value = type;
                },
              );
            }).toList(),
          ),

          const Gap(24),

          // Rating (for General Feedback)
          if (feedbackType.value == 'General Feedback') ...[
            const Text(
              'How would you rate your experience?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Gap(8),
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
            const Gap(24),
          ],

          // Subject
          TextField(
            controller: subjectController,
            decoration: const InputDecoration(
              labelText: 'Subject',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.title),
            ),
          ),

          const Gap(16),

          // Description
          TextField(
            controller: descriptionController,
            maxLines: 6,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Please provide as much detail as possible...',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),

          const Gap(24),

          // Attach Screenshot
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.attach_file),
            label: const Text('Attach Screenshot (Optional)'),
          ),

          const Gap(32),

          // Submit Button
          FilledButton(
            onPressed: () {
              if (subjectController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Feedback Sent!'),
                    content: const Text(
                      'Thank you for your feedback. We\'ll review it and get back to you soon.',
                    ),
                    actions: [
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          Navigator.pop(context); // Close feedback screen
                        },
                        child: const Text('Done'),
                      ),
                    ],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill in all required fields'),
                  ),
                );
              }
            },
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('Submit Feedback'),
          ),

          const Gap(24),

          // Contact Info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Need immediate help?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Gap(12),
                  Row(
                    children: [
                      const Icon(Icons.email, size: 20),
                      const Gap(8),
                      Text(
                        'support@linkwithmentor.com',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      const Icon(Icons.chat_bubble, size: 20),
                      const Gap(8),
                      Text(
                        'Live Chat: 9 AM - 5 PM EST',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
