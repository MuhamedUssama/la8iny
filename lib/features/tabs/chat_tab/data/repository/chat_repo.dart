import 'package:la8iny/features/auth/data/models/user_model.dart';

import 'package:la8iny/features/tabs/chat_tab/data/models/chat_message.dart';
import 'package:la8iny/features/tabs/chat_tab/data/models/chat_room.dart';

abstract interface class ChatRepo {
  Future<List<User>> searchUsers(String query);
  Stream<List<ChatRoom>> getChatRooms(String userId);
  Future<List<ChatRoom>> getChatRoomsPaginated(
    String userId, {
    int limit = 20,
    String? lastRoomId,
  });
  Future<ChatRoom> createChat({
    required User targetUser,
    required User currentUser,
  });
  Stream<List<ChatMessage>> listenToChatMessages(String roomId);
  Future<List<ChatMessage>> getChatMessagesPaginated(
    String roomId, {
    int limit = 20,
    String? lastMessageId,
  });
  Future<void> sendMessage(String roomId, ChatMessage message);
  Future<void> markMessageAsRead(String roomId, String messageId);
  Future<void> updateUserOnlineStatus(String userId, bool isOnline);
  Future<void> updateUserLastSeen(String userId);
  Stream<bool> getUserOnlineStatus(String userId);
}
