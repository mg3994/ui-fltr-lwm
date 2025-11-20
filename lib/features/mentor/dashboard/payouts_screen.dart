import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PayoutsScreen extends StatelessWidget {
  const PayoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payouts & Earnings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Balance Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.tertiary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const Text(
                  'Available Balance',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const Gap(8),
                const Text(
                  '\$1,250.00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(24),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text('Withdraw Funds'),
                ),
              ],
            ),
          ),

          const Gap(32),
          const Text(
            'Transaction History',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(16),

          ...List.generate(5, (index) {
            final isCredit = index % 2 == 0;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: isCredit
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.red.withValues(alpha: 0.1),
                child: Icon(
                  isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isCredit ? Colors.green : Colors.red,
                ),
              ),
              title: Text(isCredit ? 'Session Payment' : 'Withdrawal to Bank'),
              subtitle: Text('Oct ${20 - index}, 2023'),
              trailing: Text(
                isCredit ? '+\$50.00' : '-\$200.00',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isCredit ? Colors.green : Colors.red,
                  fontSize: 16,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

