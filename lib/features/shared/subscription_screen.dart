import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class SubscriptionScreen extends HookWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPlan = useState('monthly');

    final plans = [
      {
        'id': 'free',
        'name': 'Free',
        'price': 0,
        'period': 'forever',
        'features': [
          '1 session per month',
          'Basic mentor search',
          'Community forum access',
          'Email support',
        ],
        'color': Colors.grey,
      },
      {
        'id': 'monthly',
        'name': 'Pro',
        'price': 29,
        'period': 'month',
        'popular': true,
        'features': [
          'Unlimited sessions',
          'Advanced search filters',
          'Priority booking',
          'Resume & Portfolio builder',
          '24/7 chat support',
          'Analytics dashboard',
        ],
        'color': Colors.blue,
      },
      {
        'id': 'yearly',
        'name': 'Pro Annual',
        'price': 249,
        'period': 'year',
        'savings': 'Save \$99',
        'features': [
          'Everything in Pro',
          '2 months free',
          'Exclusive mentor access',
          'Career coaching sessions',
          'Certification courses',
          'Priority support',
        ],
        'color': Colors.purple,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Subscription Plans')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Choose Your Plan',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Gap(8),
          Text(
            'Unlock premium features and accelerate your growth',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(32),

          // Plans
          ...plans.map((plan) {
            final isSelected = selectedPlan.value == plan['id'];
            final isPopular = plan['popular'] == true;

            return GestureDetector(
              onTap: () => selectedPlan.value = plan['id'] as String,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outlineVariant,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plan['name'] as String,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(4),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$${plan['price']}',
                                        style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                          color: plan['color'] as Color,
                                        ),
                                      ),
                                      const Gap(4),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                        ),
                                        child: Text(
                                          '/${plan['period']}',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 32,
                                ),
                            ],
                          ),
                          if (plan['savings'] != null) ...[
                            const Gap(8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                plan['savings'] as String,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                          const Gap(20),
                          ...(plan['features'] as List<String>).map(
                            (feature) => Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 20,
                                    color: plan['color'] as Color,
                                  ),
                                  const Gap(12),
                                  Expanded(child: Text(feature)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isPopular)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                          child: Text(
                            'MOST POPULAR',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),

          const Gap(24),

          // Subscribe Button
          FilledButton(
            onPressed: () {
              final plan = plans.firstWhere(
                (p) => p['id'] == selectedPlan.value,
              );
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Subscription Confirmed'),
                  content: Text('You have subscribed to ${plan['name']} plan!'),
                  actions: [
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
              );
            },
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
            ),
            child: const Text('Subscribe Now', style: TextStyle(fontSize: 16)),
          ),

          const Gap(16),

          Text(
            'Cancel anytime. No hidden fees.',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
