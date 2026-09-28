import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la8iny/core/utils/app_colors.dart';
import 'package:la8iny/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:la8iny/features/tabs/chat_tab/data/models/chat_room.dart';

class ChatRooms extends StatelessWidget {
  final List<ChatRoom> rooms;
  const new({super.key, required this.rooms});

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.select(
      (AuthCubit cubit) => cubit.state.currentUserId,
    );

    if (currentUserId == null) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemBuilder: (context, index) => ChatRoomItem(
        key: ValueKey(rooms[index].id),
        room: rooms[index],
        currentUserId: currentUserId,
      ),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsetsDirectional.only(start: 94, end: 24),
        child: Divider(
          height: 1,
          thickness: 0.75,
          color: AppColors.darkTeal.withValues(alpha: 0.15),
        ),
      ),
      itemCount: rooms.length,
    );
  }
}

class ChatRoomItem extends StatelessWidget {
  final ChatRoom room;
  final String currentUserId;
  const new({super.key, required this.room, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    final otherUser = room.getOtherUser(currentUserId);

    if (otherUser == null) {
      return const SizedBox.shrink();
    }

    final name = otherUser.fullname.trim();
    final lastMessage = room.lastMessage;
    final isSentByMe = lastMessage?.senderId == currentUserId;
    final hasUnreadMessage =
        lastMessage != null &&
        lastMessage.receiverId == currentUserId &&
        !lastMessage.isRead;

    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      minVerticalPadding: 12,
      horizontalTitleGap: 14,
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primaryTeal,
            child: Text(
              name.isEmpty ? '?' : name.characters.take(2).toString(),
              style: const TextStyle(
                color: AppColors.onPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (otherUser.isOnline)
            PositionedDirectional(
              end: 0,
              bottom: 0,
              child: Semantics(
                label: 'Online',
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.darkTeal,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.onPrimary, width: 2.5),
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              name.isEmpty ? 'Unknown user' : name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.fieldText,
                fontSize: 17,
                fontWeight: hasUnreadMessage
                    ? FontWeight.w700
                    : FontWeight.w600,
              ),
            ),
          ),
          if (lastMessage != null) ...[
            const SizedBox(width: 8),
            Text(
              _formatTimestamp(context, lastMessage.timestamp),
              style: TextStyle(
                color: hasUnreadMessage
                    ? AppColors.primaryTeal
                    : AppColors.secondaryText,
                fontSize: 12,
                fontWeight: hasUnreadMessage
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: [
            if (lastMessage != null && isSentByMe) ...[
              Icon(
                lastMessage.isRead
                    ? Icons.done_all_rounded
                    : Icons.done_rounded,
                size: 17,
                color: lastMessage.isRead
                    ? AppColors.primaryTeal
                    : AppColors.secondaryText,
                semanticLabel: lastMessage.isRead ? 'Read' : 'Sent',
              ),
              const SizedBox(width: 5),
            ],
            Expanded(
              child: Text(
                lastMessage?.content ?? 'Start a conversation',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: hasUnreadMessage
                      ? AppColors.darkTeal
                      : AppColors.fieldText.withValues(alpha: 0.8),
                  fontSize: 14,
                  fontWeight: hasUnreadMessage
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
            ),
            if (hasUnreadMessage) ...[
              const SizedBox(width: 10),
              Semantics(
                label: 'Unread message',
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryTeal,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(BuildContext context, DateTime timestamp) {
    final localTimestamp = timestamp.toLocal();
    final now = DateTime.now();
    final localizations = MaterialLocalizations.of(context);
    final isToday =
        localTimestamp.year == now.year &&
        localTimestamp.month == now.month &&
        localTimestamp.day == now.day;

    if (isToday) {
      return localizations.formatTimeOfDay(
        TimeOfDay.fromDateTime(localTimestamp),
        alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
      );
    }

    return localizations.formatShortDate(localTimestamp);
  }
}
