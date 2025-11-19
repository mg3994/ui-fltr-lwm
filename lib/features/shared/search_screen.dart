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
      Future.delayed(const Duration(milliseconds: 500), () {
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
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) selectedFilter.value = filter;
                    },
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
                      return _SearchResultCard(result: result);
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
      child: ListTile(
        leading: type == 'mentor'
            ? CircleAvatar(
                backgroundImage: NetworkImage(result['image'] as String),
              )
            : CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  result['icon'] as IconData,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
        title: Text(result['title'] as String),
        subtitle: Text(result['subtitle'] as String),
        trailing: type == 'mentor'
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const Gap(4),
                  Text('${result['rating']}'),
                ],
              )
            : const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
