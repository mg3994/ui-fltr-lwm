import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class ReferralScreen extends HookWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final referralCode = 'LINK2024MK';
    final referrals = [
      {
        'name': 'John Doe',
        'avatar': 'https://i.pravatar.cc/150?u=10',
        'status': 'Active',
        'earned': 50,
        'date': '2 days ago',
      },
      {
        'name': 'Jane Smith',
        'avatar': 'https://i.pravatar.cc/150?u=11',
        'status': 'Active',
        'earned': 50,
        'date': '1 week ago',
      },
      {
        'name': 'Mike Johnson',
        'avatar': 'https://i.pravatar.cc/150?u=12',
        'status': 'Pending',
        'earned': 0,
        'date': '3 days ago',
      },
    ];

    final totalEarned = referrals.fold<int>(
      0,
      (sum, ref) => sum + (ref['earned'] as int),
    );
    final activeReferrals = referrals
        .where((r) => r['status'] == 'Active')
        .length;

    return Scaffold(
      appBar: AppBar(title: const Text('Refer & Earn')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Earnings Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.account_balance_wallet,
                    size: 48,
                    color: Colors.green,
                  ),
                  const Gap(16),
                  const Text('Total Earnings', style: TextStyle(fontSize: 16)),
                  const Gap(8),
                  Text(
                    '\$$totalEarned',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatItem(
                        label: 'Active Referrals',
                        value: '$activeReferrals',
                        icon: Icons.people,
                      ),
                      _StatItem(
                        label: 'Pending',
                        value: '${referrals.length - activeReferrals}',
                        icon: Icons.hourglass_empty,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Gap(24),

          // Referral Code Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Referral Code',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Gap(16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          referralCode,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        IconButton.filled(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Code copied to clipboard!'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.copy),
                        ),
                      ],
                    ),
                  ),
                  const Gap(16),
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share),
                    label: const Text('Share Referral Link'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Gap(24),

          // How it Works
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How it Works',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Gap(16),
                  _HowItWorksStep(
                    number: '1',
                    title: 'Share your code',
                    description: 'Send your unique referral code to friends',
                  ),
                  const Gap(12),
                  _HowItWorksStep(
                    number: '2',
                    title: 'They sign up',
                    description:
                        'Your friend creates an account using your code',
                  ),
                  const Gap(12),
                  _HowItWorksStep(
                    number: '3',
                    title: 'You both earn',
                    description:
                        'Get \$50 when they complete their first session',
                  ),
                ],
              ),
            ),
          ),

          const Gap(24),

          // Referrals List
          const Text(
            'Your Referrals',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Gap(12),

          ...referrals.map(
            (referral) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(referral['avatar'] as String),
                ),
                title: Text(referral['name'] as String),
                subtitle: Text(referral['date'] as String),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: referral['status'] == 'Active'
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        referral['status'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: referral['status'] == 'Active'
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ),
                    if (referral['earned'] as int > 0) ...[
                      const Gap(4),
                      Text(
                        '+\$${referral['earned']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const Gap(8),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _HowItWorksStep extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _HowItWorksStep({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Gap(4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
