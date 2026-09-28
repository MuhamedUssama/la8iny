import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la8iny/core/utils/app_colors.dart';
import 'package:la8iny/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:la8iny/features/auth/presentation/cubit/auth_state.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/controllers/chat_cubit/chat_cubit.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/widgets/chat_room_results_view.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/widgets/chat_tab_app_bar.dart';

class ChatTab extends StatefulWidget {
  const new({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  void initState() {
    super.initState();

    _watchRooms(context.read<AuthCubit>().state.currentUserId);
  }

  void _watchRooms(String? userId) {
    if (userId == null) return;

    log('UserId: $userId');
    context.read<ChatCubit>().watchChatRooms(userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.currentUserId != current.currentUserId,
      listener: (context, state) {
        _watchRooms(state.currentUserId);
      },
      child: Scaffold(
        backgroundColor: AppColors.onPrimary,
        appBar: const ChatTabAppBar(),
        body: const ChatRoomResultsView(),
      ),
    );
  }
}
