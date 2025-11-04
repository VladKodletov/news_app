import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/news/presentation/bloc/news_list/news_list_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_list/news_list_event.dart';
import 'package:news_app/features/news/presentation/bloc/news_list/news_list_state.dart';
import 'package:news_app/features/news/presentation/widgets/news_list_content.dart';
import 'package:news_app/features/news/presentation/widgets/news_search_bar.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final ScrollController _scrollController = ScrollController();
  String? _selectedCategory;
  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  void _loadNews() {
    context.read<NewsListBloc>().add(
          FetchTopHeadlines(
            category: _selectedCategory,
            query: _searchQuery,
          ),
        );
  }

  void _refreshNews() {
    context.read<NewsListBloc>().add(
          RefreshNews(
            category: _selectedCategory,
            query: _searchQuery,
          ),
        );
  }

  void _onCategoryChanged(String? category) {
    setState(() {
      _selectedCategory = category;
    });
    _loadNews();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.isEmpty ? null : query;
    });
    _loadNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
             context.push('/favorites');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          NewsSearchBar(
            selectedCategory: _selectedCategory,
            onCategoryChanged: _onCategoryChanged,
            onSearchChanged: _onSearchChanged,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocConsumer<NewsListBloc, NewsListState>(
              listener: (context, state) {
                if (state is NewsListError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return NewsListContent(
                  state: state,
                  scrollController: _scrollController,
                  onRefresh: _refreshNews,
                  onRetry: _loadNews,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}