import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:la8iny/features/auth/data/models/user_model.dart';
import 'package:la8iny/features/tabs/chat_tab/data/models/chat_room.dart';
import 'package:la8iny/features/tabs/chat_tab/data/repository/chat_repo.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/controllers/chat_cubit/chat_states.dart';

@injectable
class ChatCubit extends Cubit<ChatStates> {
  final ChatRepo _chatRepo;
  ChatCubit(this._chatRepo) : super(const ChatStates());

  StreamSubscription<List<ChatRoom>>? _chatSubscription;

  Future<void> createChatRoom({
    required User targetUser,
    required User currentUser,
  }) async {
    emit(state.copyWith(createChatStatus: .loading));

    try {
      final chat = await _chatRepo.createChat(
        targetUser: targetUser,
        currentUser: currentUser,
      );

      emit(state.copyWith(createChatStatus: .created, room: chat));
    } catch (e) {
      emit(
        state.copyWith(
          createChatStatus: .failure,
          createChatFailure: e.toString(),
        ),
      );
    }
  }

  Future<void> watchChatRooms(String userId) async {
    await _chatSubscription?.cancel();

    emit(state.copyWith(roomsStatus: .loading));

    _chatSubscription = _chatRepo
        .getChatRooms(userId)
        .listen(
          (rooms) {
            if (rooms.isEmpty) {
              emit(state.copyWith(roomsStatus: .empty));
            } else {
              emit(state.copyWith(roomsStatus: .loaded, rooms: rooms));
            }
          },
          onError: (error, stackTrace) {
            print(error);
            emit(
              state.copyWith(
                roomsStatus: .failure,
                roomsFailure: error.toString(),
              ),
            );
          },
        );
  }

  @override
  Future<void> close() async {
    await _chatSubscription?.cancel();
    return super.close();
  }
}
