import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:la8iny/core/utils/app_constants.dart';
import 'package:la8iny/features/auth/data/models/user_model.dart';
import 'package:la8iny/features/tabs/chat_tab/data/data_sources/chat_data_source.dart';
import 'package:la8iny/features/tabs/chat_tab/data/models/chat_message.dart';
import 'package:la8iny/features/tabs/chat_tab/data/models/chat_room.dart';

@LazySingleton(as: ChatDataSource)
class ChatDataSourceImpl implements ChatDataSource {
  final FirebaseFirestore _firestore;
  const ChatDataSourceImpl(this._firestore);

  CollectionReference<User> _getUserCollection() {
    return _firestore
        .collection(AppConstants.usersCollection)
        .withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromMap(snapshot.data() ?? {}),
          toFirestore: (user, _) => user.toMap(),
        );
  }

  CollectionReference<ChatRoom> _getRoomsCollection() {
    return _firestore
        .collection(AppConstants.roomsCollection)
        .withConverter<ChatRoom>(
          fromFirestore: (snapshot, _) {
            return ChatRoom.fromMap(snapshot.data() ?? {});
          },
          toFirestore: (room, _) => room.toMap(),
        );
  }

  CollectionReference<ChatMessage> _getMessagesCollection(String roomId) {
    return _firestore
        .collection(AppConstants.roomsCollection)
        .doc(roomId)
        .collection(AppConstants.messagesCollection)
        .withConverter<ChatMessage>(
          fromFirestore: (snapshot, _) {
            return ChatMessage.fromMap(snapshot.data() ?? {});
          },
          toFirestore: (message, _) => message.toMap(),
        );
  }

  @override
  Future<List<User>> searchUsers(String query) async {
    final QuerySnapshot<User> querySnapshot = await _getUserCollection()
        .where(
          "fullname_lowercase",
          isGreaterThanOrEqualTo: query.toLowerCase(),
        )
        .where("fullname_lowercase", isLessThan: '${query.toLowerCase()}\uf8ff')
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // Future<bool> _checkIfChatExists(User targetUser, User currentUser) async {
  //   final List<String> sortedIds = [currentUser.id, targetUser.id]..sort();
  //   final String chatRoomId = '${sortedIds[0]}_${sortedIds[1]}';

  //   final doc = await _firestore
  //       .collection(AppConstants.roomsCollection)
  //       .doc(chatRoomId)
  //       .get();

  //   return doc.exists;
  // }

  @override
  Future<ChatRoom> createChat({
    required User targetUser,
    required User currentUser,
  }) async {
    // final bool isExists = await _checkIfChatExists(targetUser, currentUser);
    // if (isExists) throw Exception('Chat already exists');

    final List<String> sortedIds = [currentUser.id, targetUser.id]..sort();
    final String chatRoomId = '${sortedIds[0]}_${sortedIds[1]}';

    final existingDoc = await _getRoomsCollection().doc(chatRoomId).get();

    if (existingDoc.exists && existingDoc.data() != null) {
      return existingDoc.data()!;
    }

    final ChatRoom chatRoom = ChatRoom(
      id: chatRoomId,
      participantIds: [targetUser.id, currentUser.id],
      participants: {targetUser.id: targetUser, currentUser.id: currentUser},
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _getRoomsCollection().doc(chatRoomId).set(chatRoom);

    return chatRoom;
  }

  @override
  Stream<List<ChatRoom>> getChatRooms(String userId) {
    return _getRoomsCollection()
        .where('participantIds', arrayContains: userId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Future<List<ChatRoom>> getChatRoomsPaginated(
    String userId, {
    int limit = 20,
    String? lastRoomId,
  }) async {
    // Filter chat rooms by userID
    Query<ChatRoom> query = _getRoomsCollection()
        .where('participantIds', arrayContains: userId)
        .orderBy('updatedAt', descending: true)
        .limit(limit);

    if (lastRoomId != null) {
      final lastDocSnapshot = await _firestore
          .collection(AppConstants.roomsCollection)
          .doc(lastRoomId)
          .get();

      if (lastDocSnapshot.exists) {
        query = query.startAfterDocument(lastDocSnapshot);
      }
    }

    final QuerySnapshot<ChatRoom> querySnapshot = await query.get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<List<ChatMessage>> getChatMessagesPaginated(
    String roomId, {
    int limit = 20,
    String? lastMessageId,
  }) async {
    final messagesRef = _getMessagesCollection(roomId);
    Query<ChatMessage> query = messagesRef
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (lastMessageId != null) {
      final lastDocSnapshot = await messagesRef.doc(lastMessageId).get();

      if (lastDocSnapshot.exists) {
        query = query.startAfterDocument(lastDocSnapshot);
      }
    }

    final QuerySnapshot<ChatMessage> querySnapshot = await query.get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Stream<List<ChatMessage>> listenToChatMessages(String roomId) {
    return _getMessagesCollection(roomId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Future<void> sendMessage(String roomId, ChatMessage message) async {
    final WriteBatch batch = _firestore.batch();

    final DocumentReference<ChatMessage> messageDocRef = message.id.isEmpty
        ? _getMessagesCollection(roomId).doc()
        : _getMessagesCollection(roomId).doc(message.id);

    final ChatMessage messageToSave = message.id.isEmpty
        ? message.copyWith(id: messageDocRef.id)
        : message;

    batch.set(messageDocRef, messageToSave);

    final roomDocRef = _firestore
        .collection(AppConstants.roomsCollection)
        .doc(roomId);

    batch.update(roomDocRef, {
      'lastMessage': messageToSave.toMap(),
      'updatedAt': DateTime.now().toIso8601String(),
    });

    await batch.commit();
  }

  @override
  Future<void> markMessageAsRead(String roomId, String messageId) async {
    final messageDocRef = _firestore
        .collection(AppConstants.roomsCollection)
        .doc(roomId)
        .collection(AppConstants.messagesCollection)
        .doc(messageId);

    final roomDocRef = _firestore
        .collection(AppConstants.roomsCollection)
        .doc(roomId);

    final WriteBatch batch = _firestore.batch();
    batch.update(messageDocRef, {'isRead': true});

    final roomDoc = await roomDocRef.get();
    if (roomDoc.exists) {
      final roomData = roomDoc.data();
      final lastMsg = roomData?['lastMessage'];
      if (lastMsg is Map<String, dynamic> && lastMsg['id'] == messageId) {
        batch.update(roomDocRef, {'lastMessage.isRead': true});
      }
    }

    await batch.commit();
  }

  @override
  Future<void> updateUserOnlineStatus(String userId, bool isOnline) async {
    final updates = <String, dynamic>{'isOnline': isOnline};
    if (!isOnline) {
      updates['lastSeen'] = DateTime.now().toIso8601String();
    }

    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .update(updates);
  }

  @override
  Future<void> updateUserLastSeen(String userId) async {
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .update({'lastSeen': DateTime.now().toIso8601String()});
  }

  @override
  Stream<bool> getUserOnlineStatus(String userId) {
    return _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .snapshots()
        .map((snapshot) {
          final data = snapshot.data();
          if (data == null) return false;
          return data['isOnline'] as bool? ?? false;
        });
  }
}
