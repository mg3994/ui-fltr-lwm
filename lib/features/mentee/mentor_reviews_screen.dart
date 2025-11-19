import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class MentorReviewsScreen extends HookWidget {
  final String mentorName;
  final double averageRating;

  const MentorReviewsScreen({
    super.key,
    required this.mentorName,
    required this.averageRating,
  });

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {
        'reviewer': 'John Doe',
        'avatar': 'https://i.pravatar.cc/150?u=10',
        'rating': 5.0,
        'date': '2 days ago',
        'comment':
            'Excellent mentor! Very knowledgeable and patient. Helped me understand Flutter state management concepts clearly.',
        'helpful': 12,
      },
      {
        'reviewer': 'Jane Smith',
        'avatar': 'https://i.pravatar.cc/150?u=11',
        'rating': 5.0,
        'date': '1 week ago',
        'comment':
            'Amazing session! Got practical insights on building production-ready apps. Highly recommended!',
        'helpful': 8,
      },
      {
        'reviewer': 'Mike Johnson',
        'avatar': 'https://i.pravatar.cc/150?u=12',
        'rating': 4.0,
        'date': '2 weeks ago',
        'comment':
            'Good mentor with solid knowledge. Would have liked more hands-on examples.',
        'helpful': 5,
      },
      {
        'reviewer': 'Sarah Williams',
        'avatar': 'https://i.pravatar.cc/150?u=13',
        'rating': 5.0,
        'date': '3 weeks ago',
        'comment':
            'Best mentoring experience I\'ve had! Clear explanations and great teaching style.',
        'helpful': 15,
      },
      {
        'reviewer': 'Tom Brown',
        'avatar': 'https://i.pravatar.cc/150?u=14',
        'rating': 4.0,
        'date': '1 month ago',
        'comment':
            'Very helpful session. Learned a lot about Flutter animations and performance optimization.',
        'helpful': 6,
      },
    ];

    final ratingDistribution = {5: 85, 4: 12, 3: 2, 2: 1, 1: 0};

    return Scaffold(
      appBar: AppBar(title: const Text('Reviews')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Overall Rating Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Icon(
                        index < averageRating.floor()
                            ? Icons.star
                            : index < averageRating
                            ? Icons.star_half
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 28,
                      );
                    }),
                  ),
                  const Gap(8),
                  Text(
                    'Based on ${reviews.length} reviews',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Gap(24),

                  // Rating Distribution
                  ...ratingDistribution.entries.map((entry) {
                    final stars = entry.key;
                    final percentage = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Text('$stars'),
                          const Gap(4),
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const Gap(12),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: percentage / 100,
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const Gap(12),
                          SizedBox(
                            width: 40,
                            child: Text(
                              '$percentage%',
                              textAlign: TextAlign.end,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          const Gap(24),

          // Reviews List
          const Text(
            'All Reviews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(16),

          ...reviews.map((review) => _ReviewCard(review: review)),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(review['avatar'] as String),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review['reviewer'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Gap(4),
                      Text(
                        review['date'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < (review['rating'] as double).floor()
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 18,
                    );
                  }),
                ),
              ],
            ),
            const Gap(12),
            Text(review['comment'] as String),
            const Gap(12),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up_outlined, size: 18),
                  label: Text('Helpful (${review['helpful']})'),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.flag_outlined, size: 18),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
