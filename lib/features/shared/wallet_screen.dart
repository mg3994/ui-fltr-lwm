import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class WalletScreen extends HookWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final balance = 1250.50;
    final pendingEarnings = 350.00;

    final transactions = [
      {
        'type': 'credit',
        'title': 'Session Payment',
        'description': 'Flutter State Management session with John Doe',
        'amount': 50.00,
        'date': '2 hours ago',
        'status': 'completed',
        'icon': Icons.video_call,
      },
      {
        'type': 'credit',
        'title': 'Referral Bonus',
        'description': 'Jane Smith signed up using your code',
        'amount': 50.00,
        'date': '1 day ago',
        'status': 'completed',
        'icon': Icons.people,
      },
      {
        'type': 'debit',
        'title': 'Withdrawal',
        'description': 'Bank transfer to ****1234',
        'amount': -200.00,
        'date': '2 days ago',
        'status': 'completed',
        'icon': Icons.account_balance,
      },
      {
        'type': 'credit',
        'title': 'Session Payment',
        'description': 'UI/UX Design review with Mike Johnson',
        'amount': 45.00,
        'date': '3 days ago',
        'status': 'completed',
        'icon': Icons.video_call,
      },
      {
        'type': 'credit',
        'title': 'Milestone Bonus',
        'description': '100 sessions completed achievement',
        'amount': 100.00,
        'date': '5 days ago',
        'status': 'completed',
        'icon': Icons.emoji_events,
      },
      {
        'type': 'credit',
        'title': 'Session Payment',
        'description': 'Career coaching with Sarah Williams',
        'amount': 60.00,
        'date': '1 week ago',
        'status': 'pending',
        'icon': Icons.video_call,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        actions: [
          IconButton(icon: const Icon(Icons.history), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Balance Card
          Card(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Balance',
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimary.withValues(alpha: 0.9),
                      fontSize: 14,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    '\$${balance.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      Icon(
                        Icons.hourglass_empty,
                        size: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.onPrimary.withValues(alpha: 0.9),
                      ),
                      const Gap(4),
                      Text(
                        'Pending: \$${pendingEarnings.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimary.withValues(alpha: 0.9),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Gap(16),

          // Quick Actions
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Add Funds'),
                ),
              ),
              const Gap(12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_upward),
                  label: const Text('Withdraw'),
                ),
              ),
            ],
          ),

          const Gap(24),

          // Stats
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'This Month',
                  value: '\$450',
                  icon: Icons.calendar_today,
                  color: Colors.green,
                ),
              ),
              const Gap(12),
              Expanded(
                child: _StatCard(
                  title: 'Total Earned',
                  value: '\$3,250',
                  icon: Icons.trending_up,
                  color: Colors.blue,
                ),
              ),
            ],
          ),

          const Gap(24),

          // Transactions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),
          const Gap(12),

          ...transactions.map(
            (transaction) => _TransactionCard(transaction: transaction),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const Gap(8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Gap(4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const _TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction['type'] == 'credit';
    final amount = transaction['amount'] as double;
    final isPending = transaction['status'] == 'pending';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isCredit
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            transaction['icon'] as IconData,
            color: isCredit ? Colors.green : Colors.red,
          ),
        ),
        title: Text(transaction['title'] as String),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(4),
            Text(
              transaction['description'] as String,
              style: const TextStyle(fontSize: 12),
            ),
            const Gap(4),
            Row(
              children: [
                Text(
                  transaction['date'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                if (isPending) ...[
                  const Gap(8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Pending',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: Text(
          '${amount >= 0 ? '+' : ''}\$${amount.abs().toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isCredit ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}

