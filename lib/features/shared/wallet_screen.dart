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
          // Credit Card Visualization
          Container(
            height: 200,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.tertiary,
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available Balance',
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onPrimary.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                    Icon(
                      Icons.contactless,
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimary.withValues(alpha: 0.8),
                    ),
                  ],
                ),
                Text(
                  '\$${balance.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Holder',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary.withValues(alpha: 0.6),
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          'Manish',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Expires',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary.withValues(alpha: 0.6),
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          '12/28',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Gap(24),

          // Pending Balance
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.hourglass_empty,
                    color: Colors.orange,
                  ),
                ),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pending Clearance',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '\$${pendingEarnings.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text('Details')),
              ],
            ),
          ),

          const Gap(24),

          // Quick Actions
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: Icons.add,
                  label: 'Add Funds',
                  onTap: () {},
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Gap(16),
              Expanded(
                child: _ActionButton(
                  icon: Icons.arrow_upward,
                  label: 'Withdraw',
                  onTap: () {},
                  color: Colors.green,
                ),
              ),
              const Gap(16),
              Expanded(
                child: _ActionButton(
                  icon: Icons.swap_horiz,
                  label: 'Transfer',
                  onTap: () {},
                  color: Colors.blue,
                ),
              ),
            ],
          ),

          const Gap(32),

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
          const Gap(16),

          ...transactions.map(
            (transaction) => _TransactionCard(transaction: transaction),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const Gap(8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 12,
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

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isCredit
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            transaction['icon'] as IconData,
            color: isCredit ? Colors.green : Colors.red,
            size: 20,
          ),
        ),
        title: Text(
          transaction['title'] as String,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(4),
            Text(
              transaction['description'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
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
