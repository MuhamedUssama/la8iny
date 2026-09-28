// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:la8iny/features/tabs/chat_tab/data/models/chat_room.dart';

enum CreateChatStatus { initial, loading, created, failure }

enum ChatRoomsStatus { initial, loading, loaded, empty, failure }

extension CreateChatStatusX on ChatStates {
  bool get isCreateChatInitial => createChatStatus == CreateChatStatus.initial;
  bool get isCreateChatLoading => createChatStatus == CreateChatStatus.loading;
  bool get isCreateChatCreated => createChatStatus == CreateChatStatus.created;
  bool get isCreateChatFailure => createChatStatus == CreateChatStatus.failure;
}

extension ChatRoomsStatusX on ChatStates {
  bool get isRoomInitial => roomsStatus == ChatRoomsStatus.initial;
  bool get isRoomLoading => roomsStatus == ChatRoomsStatus.loading;
  bool get isRoomLoaded => roomsStatus == ChatRoomsStatus.loaded;
  bool get isRoomEmpty => roomsStatus == ChatRoomsStatus.empty;
  bool get isRoomFailure => roomsStatus == ChatRoomsStatus.failure;
}

@immutable
class ChatStates {
  final ChatRoomsStatus roomsStatus;
  final CreateChatStatus createChatStatus;
  final ChatRoom? room;
  final List<ChatRoom> rooms;
  final String? createChatFailure;
  final String? roomsFailure;

  const ChatStates({
    this.room,
    this.createChatFailure,
    this.roomsFailure,
    this.createChatStatus = .initial,
    this.roomsStatus = .initial,
    this.rooms = const [],
  });

  ChatStates copyWith({
    ChatRoomsStatus? roomsStatus,
    CreateChatStatus? createChatStatus,
    ChatRoom? room,
    List<ChatRoom>? rooms,
    String? createChatFailure,
    String? roomsFailure,
  }) {
    return ChatStates(
      roomsStatus: roomsStatus ?? this.roomsStatus,
      createChatStatus: createChatStatus ?? this.createChatStatus,
      room: room ?? this.room,
      rooms: rooms ?? this.rooms,
      createChatFailure: createChatFailure ?? this.createChatFailure,
      roomsFailure: roomsFailure ?? this.roomsFailure,
    );
  }

  @override
  String toString() {
    return 'ChatStates(roomsStatus: $roomsStatus, createChatStatus: $createChatStatus, room: $room, rooms: $rooms, createChatFailure: $createChatFailure, roomsFailure: $roomsFailure)';
  }

  @override
  bool operator ==(covariant ChatStates other) {
    if (identical(this, other)) return true;

    return other.roomsStatus == roomsStatus &&
        other.createChatStatus == createChatStatus &&
        other.room == room &&
        listEquals(other.rooms, rooms) &&
        other.createChatFailure == createChatFailure &&
        other.roomsFailure == roomsFailure;
  }

  @override
  int get hashCode {
    return roomsStatus.hashCode ^
        createChatStatus.hashCode ^
        room.hashCode ^
        rooms.hashCode ^
        createChatFailure.hashCode ^
        roomsFailure.hashCode;
  }
}
