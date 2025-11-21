import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class SkillMarketplaceScreen extends HookWidget {
  const SkillMarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);
    final searchController = useTextEditingController();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Skill Marketplace',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.teal.shade700,
                          Colors.green.shade600,
                          Colors.lime.shade500,
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(painter: _GridPatternPainter()),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.teal.shade50, Colors.green.shade50],
                ),
              ),
              child: Column(
                children: [
                  const Gap(20),
                  // Search Bar
                  _SearchBar(controller: searchController),
                  const Gap(20),
                  // Stats Cards
                  _StatsSection(),
                  const Gap(20),
                  // Tab Selector
                  _TabSelector(
                    selectedTab: selectedTab.value,
                    onTabChanged: (index) => selectedTab.value = index,
                  ),
                  const Gap(20),
                  // Content based on tab
                  if (selectedTab.value == 0) ...[
                    _OffersSection(),
                  ] else ...[
                    _RequestsSection(),
                  ],
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _FloatingActionButton(),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;

  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08 * 255),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Search skills...',
            hintStyle: TextStyle(color: Colors.grey.shade400),
            prefixIcon: Icon(Icons.search, color: Colors.teal.shade600),
            suffixIcon: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade600, Colors.green.shade600],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.tune, color: Colors.white, size: 20),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 800),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: _StatCard(
                    icon: Icons.local_offer,
                    label: 'Active Offers',
                    value: '${(247 * value).toInt()}',
                    color: Colors.blue,
                  ),
                );
              },
            ),
          ),
          const Gap(12),
          Expanded(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 900),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: _StatCard(
                    icon: Icons.help_outline,
                    label: 'Requests',
                    value: '${(189 * value).toInt()}',
                    color: Colors.orange,
                  ),
                );
              },
            ),
          ),
          const Gap(12),
          Expanded(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1000),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: _StatCard(
                    icon: Icons.handshake,
                    label: 'Matches',
                    value: '${(156 * value).toInt()}',
                    color: Colors.green,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.3 * 255),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1 * 255),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const Gap(8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class _TabSelector extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const _TabSelector({required this.selectedTab, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05 * 255),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: selectedTab == 0
                        ? LinearGradient(
                            colors: [
                              Colors.teal.shade600,
                              Colors.green.shade600,
                            ],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_offer,
                        size: 18,
                        color: selectedTab == 0
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                      const Gap(8),
                      Text(
                        'Offers',
                        style: TextStyle(
                          color: selectedTab == 0
                              ? Colors.white
                              : Colors.grey.shade600,
                          fontWeight: selectedTab == 0
                              ? FontWeight.bold
                              : FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: selectedTab == 1
                        ? LinearGradient(
                            colors: [
                              Colors.orange.shade600,
                              Colors.amber.shade600,
                            ],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.help_outline,
                        size: 18,
                        color: selectedTab == 1
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                      const Gap(8),
                      Text(
                        'Requests',
                        style: TextStyle(
                          color: selectedTab == 1
                              ? Colors.white
                              : Colors.grey.shade600,
                          fontWeight: selectedTab == 1
                              ? FontWeight.bold
                              : FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OffersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final offers = [
      {
        'user': 'Sarah Chen',
        'avatar': '👩‍💼',
        'skill': 'Flutter Development',
        'level': 'Expert',
        'price': 'Free',
        'rating': 4.9,
        'sessions': 45,
        'category': 'Mobile',
      },
      {
        'user': 'Mike Johnson',
        'avatar': '👨‍💻',
        'skill': 'UI/UX Design',
        'level': 'Advanced',
        'price': '\$50/hr',
        'rating': 4.8,
        'sessions': 32,
        'category': 'Design',
      },
      {
        'user': 'Emily Davis',
        'avatar': '👩‍🎨',
        'skill': 'React Native',
        'level': 'Intermediate',
        'price': 'Free',
        'rating': 4.7,
        'sessions': 28,
        'category': 'Mobile',
      },
      {
        'user': 'Alex Kumar',
        'avatar': '👨‍🔬',
        'skill': 'System Design',
        'level': 'Expert',
        'price': '\$75/hr',
        'rating': 5.0,
        'sessions': 67,
        'category': 'Architecture',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Skills',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...offers.asMap().entries.map((entry) {
            final index = entry.key;
            final offer = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _OfferCard(offer: offer),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  final Map<String, dynamic> offer;

  const _OfferCard({required this.offer});

  @override
  Widget build(BuildContext context) {
    final isFree = offer['price'] == 'Free';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05 * 255),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade400, Colors.green.shade400],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    offer['avatar'] as String,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer['user'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    const Gap(4),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber.shade600,
                          size: 14,
                        ),
                        const Gap(4),
                        Text(
                          '${offer['rating']}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          '${offer['sessions']} sessions',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: isFree
                      ? LinearGradient(
                          colors: [Colors.green.shade400, Colors.teal.shade400],
                        )
                      : LinearGradient(
                          colors: [
                            Colors.purple.shade400,
                            Colors.pink.shade400,
                          ],
                        ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  offer['price'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.teal.shade200, width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.code, color: Colors.teal.shade700, size: 20),
                const Gap(8),
                Expanded(
                  child: Text(
                    offer['skill'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    offer['level'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.category, size: 14, color: Colors.grey.shade600),
                    const Gap(4),
                    Text(
                      offer['category'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Connect',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RequestsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final requests = [
      {
        'user': 'John Smith',
        'avatar': '👨‍💼',
        'skill': 'GraphQL',
        'urgency': 'High',
        'budget': '\$100',
        'description': 'Need help with GraphQL schema design',
      },
      {
        'user': 'Lisa Wang',
        'avatar': '👩‍💻',
        'skill': 'Docker',
        'urgency': 'Medium',
        'budget': 'Negotiable',
        'description': 'Looking for Docker containerization guidance',
      },
      {
        'user': 'Tom Brown',
        'avatar': '👨‍🎓',
        'skill': 'AWS',
        'urgency': 'Low',
        'budget': '\$50',
        'description': 'AWS deployment best practices needed',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skill Requests',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const Gap(16),
          ...requests.asMap().entries.map((entry) {
            final index = entry.key;
            final request = entry.value;
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _RequestCard(request: request),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final Map<String, dynamic> request;

  const _RequestCard({required this.request});

  @override
  Widget build(BuildContext context) {
    final urgency = request['urgency'] as String;
    final urgencyColor = urgency == 'High'
        ? Colors.red
        : urgency == 'Medium'
        ? Colors.orange
        : Colors.blue;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: urgencyColor.withValues(alpha: 0.3 * 255),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: urgencyColor.withValues(alpha: 0.1 * 255),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade400, Colors.amber.shade400],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    request['avatar'] as String,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['user'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'Looking for: ${request['skill']}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: urgencyColor.withValues(alpha: 0.15 * 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  urgency,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: urgencyColor,
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              request['description'] as String,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ),
          const Gap(12),
          Row(
            children: [
              Icon(Icons.attach_money, size: 18, color: Colors.green.shade600),
              const Gap(4),
              Text(
                'Budget: ${request['budget']}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Respond',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: Colors.teal.shade600,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Post Skill',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1 * 255)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const gridSize = 30.0;

    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
