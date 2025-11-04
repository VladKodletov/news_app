import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/favorites/favorites_event.dart';
import 'package:news_app/features/news/presentation/bloc/favorites/favorites_state.dart';
import 'package:news_app/features/news/presentation/widgets/favorites_content.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesBloc>().add(const LoadFavorites());
    return Scaffold(
      body: BlocConsumer<FavoritesBloc, FavoritesState>(
        listener: (context, state) {
          if (state is FavoritesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return FavoritesContent(
            state: state,
          );
        },
      ),
    );
  }
}
