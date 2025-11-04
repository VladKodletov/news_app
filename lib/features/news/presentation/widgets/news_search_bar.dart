import 'package:flutter/material.dart';
import 'package:news_app/core/constants/constants.dart';

/// Search and filter bar for news
class NewsSearchBar extends StatefulWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String> onSearchChanged;

  const NewsSearchBar({
    super.key,
    this.selectedCategory,
    required this.onCategoryChanged,
    required this.onSearchChanged,
  });

  @override
  State<NewsSearchBar> createState() => _NewsSearchBarState();
}

class _NewsSearchBarState extends State<NewsSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final _categories =  NewsCategories.all;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Search field
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search news...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        widget.onSearchChanged('');
                      },
                    )
                  : null,
            ),
            onChanged: widget.onSearchChanged,
          ),
          const SizedBox(height: 8),
          // Category filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((category) {
                final isSelected = widget.selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      category[0].toUpperCase() + category.substring(1),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      widget.onCategoryChanged(
                        selected ? category : null,
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}