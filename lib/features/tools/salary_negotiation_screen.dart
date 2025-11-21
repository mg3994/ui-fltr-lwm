import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class SalaryNegotiationScreen extends HookWidget {
  const SalaryNegotiationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber.withValues(alpha: 0.3),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Salary Negotiation',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '💰 Know Your Worth',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Salary Calculator Card
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 400),
                    builder: (context, value, child) => Opacity(
                      opacity: value,
                      child: Transform.scale(
                        scale: 0.95 + (0.05 * value),
                        child: child,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.amber.withValues(alpha: 0.1),
                            Theme.of(context).colorScheme.surface,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.amber.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.calculate,
                                  color: Colors.amber,
                                  size: 24,
                                ),
                              ),
                              const Gap(12),
                              const Text(
                                'Salary Calculator',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          const Text(
                            'Estimated Market Range',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                          Row(
                            children: [
                              Expanded(
                                child: _SalaryBox(
                                  label: 'Min',
                                  amount: '\$85K',
                                  color: Colors.orange,
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: _SalaryBox(
                                  label: 'Median',
                                  amount: '\$105K',
                                  color: Colors.amber,
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: _SalaryBox(
                                  label: 'Max',
                                  amount: '\$135K',
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),
                          FilledButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.refresh, size: 16),
                            label: const Text('Recalculate'),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.amber,
                              minimumSize: const Size(double.infinity, 40),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(24),
                  const Text(
                    'Negotiation Scripts',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Gap(12),
                  ...List.generate(3, (index) {
                    final scripts = [
                      {
                        'title': 'Counteroffer Template',
                        'scenario': 'When you receive initial offer',
                        'icon': Icons.message,
                        'color': Colors.blue,
                      },
                      {
                        'title': 'Benefits Negotiation',
                        'scenario': 'Discussing perks and benefits',
                        'icon': Icons.card_giftcard,
                        'color': Colors.purple,
                      },
                      {
                        'title': 'Raise Request',
                        'scenario': 'Annual performance review',
                        'icon': Icons.trending_up,
                        'color': Colors.green,
                      },
                    ];

                    final script = scripts[index];

                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 500 + index * 100),
                      builder: (context, value, child) => Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(-20 * (1 - value), 0),
                          child: child,
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: (script['color'] as Color).withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: (script['color'] as Color).withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              script['icon'] as IconData,
                              color: script['color'] as Color,
                              size: 24,
                            ),
                          ),
                          title: Text(
                            script['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            script['scenario'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: script['color'] as Color,
                          ),
                          onTap: () {},
                        ),
                      ),
                    );
                  }),
                  const Gap(24),
                  const Text(
                    'Expert Tips',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Gap(12),
                  ...List.generate(4, (index) {
                    final tips = [
                      {
                        'tip': 'Research market rates before negotiating',
                        'icon': '🔍',
                      },
                      {
                        'tip': 'Never reveal your current salary first',
                        'icon': '🤐',
                      },
                      {
                        'tip': 'Negotiate total compensation, not just base',
                        'icon': '💼',
                      },
                      {
                        'tip': 'Practice your pitch with a mentor',
                        'icon': '🎯',
                      },
                    ];

                    final tip = tips[index];

                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 700 + index * 80),
                      builder: (context, value, child) =>
                          Opacity(opacity: value, child: child),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.amber.withValues(alpha: 0.05),
                              Theme.of(context).colorScheme.surface,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.amber.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              tip['icon'] as String,
                              style: const TextStyle(fontSize: 24),
                            ),
                            const Gap(12),
                            Expanded(
                              child: Text(
                                tip['tip'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SliverGap(80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.school),
        label: const Text('Take Course'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black87,
      ),
    );
  }
}

class _SalaryBox extends StatelessWidget {
  final String label;
  final String amount;
  final Color color;

  const _SalaryBox({
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const Gap(4),
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
