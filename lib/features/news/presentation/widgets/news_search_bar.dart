import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/constants/app_asets.dart';
import 'package:news_app/core/constants/constants.dart';

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
  final _categories = NewsCategories.all;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Container(
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: 19),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Search icon
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SvgPicture.asset(
                    AppAssets.searchIcon,
                    height: 32,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: '',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(right: 16),
                    ),
                    onChanged: widget.onSearchChanged,
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      widget.onSearchChanged('');
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Category filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((category) {
                final isSelected = widget.selectedCategory == category;
                return Padding(
                  padding: category == _categories.first
                      ? const EdgeInsets.only(right: 7, left: 19)
                      : const EdgeInsets.only(right: 7),
                  child: FilterChip(
                    label: Text(
                      category[0].toUpperCase() + category.substring(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    backgroundColor: isSelected
                        ? const Color(0xff2F78FF)
                        : const Color(0xffC1C1C1),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    selectedColor: const Color(0xff2F78FF),
                    showCheckmark: false,
                    side: const BorderSide(style: BorderStyle.none),
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
