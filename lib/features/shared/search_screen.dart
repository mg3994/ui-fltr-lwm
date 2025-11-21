import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final searchResults = useState<List<Map<String, dynamic>>>([]);
    final isSearching = useState(false);
    final selectedFilter = useState('All');

    final filters = ['All', 'Mentors', 'Sessions', 'Questions', 'Resources'];

    void performSearch(String query) {
      if (query.isEmpty) {
        searchResults.value = [];
        return;
      }

      isSearching.value = true;

      // Simulate search delay
      Future.delayed(const Duration(milliseconds: 800), () {
        if (context.mounted) {
          searchResults.value = [
            {
              'type': 'mentor',
              'title': 'Sarah Jenkins',
              'subtitle': 'Senior Flutter Developer',
              'image': 'https://i.pravatar.cc/150?u=1',
              'rating': 4.9,
            },
            {
              'type': 'session',
              'title': 'Flutter State Management',
              'subtitle': 'Tomorrow at 2:00 PM',
              'icon': Icons.calendar_today,
            },
            {
              'type': 'question',
              'title': 'How to optimize Flutter performance?',
              'subtitle': '12 answers • 24 upvotes',
              'icon': Icons.forum,
            },
            {
              'type': 'resource',
              'title': 'Flutter Best Practices Guide',
              'subtitle': 'Documentation',
              'icon': Icons.book,
            },
          ];
          isSearching.value = false;
        }
      });
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 140,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: 0.2),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              titlePadding: EdgeInsets.zero,
              title: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.outlineVariant.withValues(alpha: 0.5),
                        ),
                      ),
                      child: TextField(
                        controller: searchController,
                        autofocus: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Search mentors, sessions...',
                          hintStyle: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 20),
                                  onPressed: () {
                                    searchController.clear();
                                    searchResults.value = [];
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        onChanged: performSearch,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: filters.map((filter) {
                  final isSelected = selectedFilter.value == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: FilterChip(
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) selectedFilter.value = filter;
                        },
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        selectedColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        checkmarkColor: Theme.of(
                          context,
                        ).colorScheme.onPrimaryContainer,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.transparent
                                : Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 0,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          if (isSearching.value)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (searchResults.value.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.search_off_rounded,
                        size: 48,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    const Gap(24),
                    Text(
                      searchController.text.isEmpty
                          ? 'Start typing to search'
                          : 'No results found',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final result = searchResults.value[index];
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: _SearchResultCard(result: result),
                  );
                }, childCount: searchResults.value.length),
              ),
            ),
        ],
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  final Map<String, dynamic> result;
  const _SearchResultCard({required this.result});

  @override
  Widget build(BuildContext context) {
    final type = result['type'] as String;

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
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                if (type == 'mentor')
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(result['image'] as String),
                      radius: 24,
                    ),
                  )
                else
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      result['icon'] as IconData,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                  ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        result['subtitle'] as String,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (type == 'mentor')
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const Gap(4),
                        Text(
                          '${result['rating']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.outline,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
