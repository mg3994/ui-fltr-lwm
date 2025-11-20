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
            final color = plan['color'] as Color;

            return GestureDetector(
              onTap: () => selectedPlan.value = plan['id'] as String,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: isSelected
                        ? color
                        : Theme.of(context).colorScheme.outlineVariant,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ]
                      : [],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
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
                                          color: color,
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
                                  color: color,
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
                                color: Colors.green.withValues(alpha: 0.1),
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
                          const Gap(24),
                          const Divider(),
                          const Gap(24),
                          ...(plan['features'] as List<String>).map(
                            (feature) => Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 20,
                                    color: color.withValues(alpha: 0.8),
                                  ),
                                  const Gap(12),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
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
                            color: color,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(22),
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
                  icon: const Icon(
                    Icons.check_circle,
                    size: 48,
                    color: Colors.green,
                  ),
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
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: const Text(
              'Subscribe Now',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
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
          const Gap(32),
        ],
      ),
    );
  }
}
