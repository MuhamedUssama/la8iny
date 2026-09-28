import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la8iny/core/router/route_names.dart';
import 'package:la8iny/core/utils/app_colors.dart';

import '../controllers/chat_cubit/chat_cubit.dart';
import '../controllers/chat_cubit/chat_states.dart';
import 'chat_rooms.dart';

class ChatRoomResultsView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      builder: (context, state) {
        switch (state.roomsStatus) {
          case ChatRoomsStatus.initial:
          case ChatRoomsStatus.loading:
            return const Center(
              child: CircularProgressIndicator(color: AppColors.darkTeal),
            );

          case ChatRoomsStatus.failure:
            return ChatRooms(rooms: state.rooms);

          case ChatRoomsStatus.loaded:
            if (state.rooms.isEmpty) return const _EmptyChatRooms();
            return ChatRooms(rooms: state.rooms);

          case ChatRoomsStatus.empty:
            return const _EmptyChatRooms();
        }
      },
      listener: (context, state) {
        if (state.isRoomFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.error,
              content: Text(
                state.roomsFailure ?? '',
                style: const TextStyle(color: Colors.white),
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
    );
  }
}

class _EmptyChatRooms extends StatelessWidget {
  const _EmptyChatRooms();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: (constraints.maxHeight - 48).clamp(0.0, double.infinity),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.primaryTeal,
                  child: Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: AppColors.onPrimary,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'No conversations yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.darkTeal,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Search for someone to start a conversation.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    RouteNames.searchScreen,
                    arguments: context.read<ChatCubit>(),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTeal,
                    foregroundColor: AppColors.onPrimary,
                    elevation: 0,
                    minimumSize: const Size(180, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  icon: const Icon(Icons.search_rounded),
                  label: const Text(
                    'Find someone',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
