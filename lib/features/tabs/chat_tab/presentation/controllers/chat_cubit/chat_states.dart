// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:la8iny/features/tabs/chat_tab/data/models/chat_room.dart';

enum ChatStatus { initial, loading, created, failure }

extension ChatStatusX on ChatStates {
  bool get isInitial => status == ChatStatus.initial;
  bool get isLoading => status == ChatStatus.loading;
  bool get isCreated => status == ChatStatus.created;
  bool get isFailure => status == ChatStatus.failure;
}

@immutable
class ChatStates {
  final ChatStatus status;
  final ChatRoom? room;
  final String? failure;

  const ChatStates({this.room, this.failure, this.status = .initial});

  ChatStates copyWith({ChatStatus? status, ChatRoom? room, String? failure}) {
    return ChatStates(
      status: status ?? this.status,
      room: room ?? this.room,
      failure: failure ?? this.failure,
    );
  }

  @override
  String toString() =>
      'ChatStates(status: $status, room: $room, failure: $failure)';

  @override
  bool operator ==(covariant ChatStates other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.room == room &&
        other.failure == failure;
  }

  @override
  int get hashCode => status.hashCode ^ room.hashCode ^ failure.hashCode;
}
