import 'package:injectable/injectable.dart';
import 'package:la8iny/features/auth/data/models/user_model.dart';
import 'package:la8iny/features/tabs/chat_tab/data/data_sources/chat_data_source.dart';
import 'package:la8iny/features/tabs/chat_tab/data/models/chat_message.dart';
import 'package:la8iny/features/tabs/chat_tab/data/models/chat_room.dart';
import 'package:la8iny/features/tabs/chat_tab/data/repository/chat_repo.dart';

@LazySingleton(as: ChatRepo)
class ChatRepoImpl implements ChatRepo {
  final ChatDataSource _dataSource;
  const ChatRepoImpl(this._dataSource);

  @override
  Future<List<User>> searchUsers(String query) {
    return _dataSource.searchUsers(query);
  }

  @override
  Stream<List<ChatRoom>> getChatRooms(String userId) {
    return _dataSource.getChatRooms(userId);
  }

  @override
  Future<List<ChatRoom>> getChatRoomsPaginated(
    String userId, {
    int limit = 20,
    String? lastRoomId,
  }) {
    return _dataSource.getChatRoomsPaginated(
      userId,
      lastRoomId: lastRoomId,
      limit: limit,
    );
  }

  @override
  Future<ChatRoom> createChat({
    required User targetUser,
    required User currentUser,
  }) {
    return _dataSource.createChat(
      targetUser: targetUser,
      currentUser: currentUser,
    );
  }

  @override
  Future<List<ChatMessage>> getChatMessagesPaginated(
    String roomId, {
    int limit = 20,
    String? lastMessageId,
  }) {
    return _dataSource.getChatMessagesPaginated(
      roomId,
      lastMessageId: lastMessageId,
      limit: limit,
    );
  }

  @override
  Stream<List<ChatMessage>> listenToChatMessages(String roomId) {
    return _dataSource.listenToChatMessages(roomId);
  }

  @override
  Stream<bool> getUserOnlineStatus(String userId) {
    return _dataSource.getUserOnlineStatus(userId);
  }

  @override
  Future<void> markMessageAsRead(String roomId, String messageId) {
    return _dataSource.markMessageAsRead(roomId, messageId);
  }

  @override
  Future<void> sendMessage(String roomId, ChatMessage message) {
    return _dataSource.sendMessage(roomId, message);
  }

  @override
  Future<void> updateUserLastSeen(String userId) {
    return _dataSource.updateUserLastSeen(userId);
  }

  @override
  Future<void> updateUserOnlineStatus(String userId, bool isOnline) {
    return _dataSource.updateUserOnlineStatus(userId, isOnline);
  }
}
