import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la8iny/core/router/route_names.dart';
import 'package:la8iny/core/utils/app_colors.dart';

import '../controllers/chat_cubit/chat_cubit.dart';

class ChatTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      foregroundColor: AppColors.darkTeal,
      backgroundColor: AppColors.onPrimary,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chats',
            style: TextStyle(
              color: AppColors.darkTeal,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Your conversations',
            style: TextStyle(
              color: AppColors.secondaryText,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      actionsPadding: const EdgeInsetsDirectional.only(end: 24),
      actions: [
        IconButton.filled(
          tooltip: 'Search users',
          style: IconButton.styleFrom(
            backgroundColor: AppColors.primaryTeal,
            foregroundColor: AppColors.onPrimary,
            minimumSize: const Size(48, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              RouteNames.searchScreen,
              arguments: context.read<ChatCubit>(),
            );
          },
          icon: const Icon(Icons.search_rounded, size: 26),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
