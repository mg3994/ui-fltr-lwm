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
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search mentors, sessions, questions...',
            border: InputBorder.none,
          ),
          onChanged: performSearch,
        ),
        actions: [
          if (searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                searchResults.value = [];
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
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
                              : Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Search Results
          Expanded(
            child: isSearching.value
                ? const Center(child: CircularProgressIndicator())
                : searchResults.value.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 64,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const Gap(16),
                        Text(
                          searchController.text.isEmpty
                              ? 'Start typing to search'
                              : 'No results found',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: searchResults.value.length,
                    itemBuilder: (context, index) {
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
                    },
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

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: type == 'mentor'
            ? CircleAvatar(
                backgroundImage: NetworkImage(result['image'] as String),
                radius: 24,
              )
            : Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  result['icon'] as IconData,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  size: 24,
                ),
              ),
        title: Text(
          result['title'] as String,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Gap(4), Text(result['subtitle'] as String)],
        ),
        trailing: type == 'mentor'
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                      ),
                    ),
                  ],
                ),
              )
            : const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
