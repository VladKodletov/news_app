// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:news_app/core/constants/app_asets.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_event.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_state.dart';

class DetailFavoriteButton extends StatelessWidget {
  final double? height;

  const DetailFavoriteButton({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsDetailBloc, NewsDetailState>(
      builder: (context, state) {
        if (state is NewsDetailSuccess) {
          return IconButton(
            icon: state.article.isFavorite
                ? SvgPicture.asset(
                    AppAssets.checkFavoriteIconActive,
                    height: height,
                  )
                : SvgPicture.asset(
                    AppAssets.checkFavoriteIcon,
                    height: height,
                  ),
            onPressed: () {
              context.read<NewsDetailBloc>().add(const ToggleFavoriteEvent());
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
