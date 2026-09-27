import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la8iny/core/router/route_names.dart';
import 'package:la8iny/core/utils/app_colors.dart';
import 'package:la8iny/features/auth/data/models/user_model.dart';
import 'package:la8iny/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/controllers/chat_cubit/chat_cubit.dart';

class UserTile extends StatelessWidget {
  final User user;

  const new({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () async {
        await context
            .read<ChatCubit>()
            .createChatRoom(
              targetUser: user,
              currentUser: context.read<AuthCubit>().state.user!,
            )
            .then((value) {
              if (!context.mounted) return;
              Navigator.pushNamed(context, RouteNames.chatScreen);
            });
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.softTeal,
            child: Text(
              user.fullname.isNotEmpty ? user.fullname[0].toUpperCase() : '?',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryTeal,
              ),
            ),
          ),
          if (user.isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        user.fullname,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTeal,
        ),
      ),
      subtitle: Text(
        user.email,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 13, color: AppColors.secondaryText),
      ),
      trailing: const Icon(
        Icons.chat_bubble_outline_rounded,
        color: AppColors.primaryTeal,
        size: 22,
      ),
    );
  }
}
