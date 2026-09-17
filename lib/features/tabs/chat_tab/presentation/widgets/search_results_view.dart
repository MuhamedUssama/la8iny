import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la8iny/core/utils/app_colors.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/controllers/search_bloc/search_bloc.dart';
import 'package:lottie/lottie.dart';

import 'user_tile.dart';

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        switch (state.status) {
          case SearchStatus.initial:
            return LottieBuilder.asset(
              'assets/animations/empty_animation.json',
            );
          case SearchStatus.loading:
            return const Center(
              child: CircularProgressIndicator(color: AppColors.darkTeal),
            );
          case SearchStatus.loaded:
            final users = state.users ?? [];
            if (users.isEmpty) {
              return const Center(
                child: Text(
                  'No users found',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 16,
                  ),
                ),
              );
            }
            return ListView.separated(
              itemBuilder: (context, index) => UserTile(user: users[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: users.length,
            );
          case SearchStatus.failure:
            return Center(
              child: Text(
                state.failureMessage ?? "Something went wrong",
                style: const TextStyle(color: AppColors.error),
              ),
            );
        }
      },
    );
  }
}
