import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:la8iny/features/auth/data/models/user_model.dart';
import 'package:la8iny/features/tabs/chat_tab/data/repository/chat_repo.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/controllers/chat_cubit/chat_states.dart';

@injectable
class ChatCubit extends Cubit<ChatStates> {
  final ChatRepo _chatRepo;
  ChatCubit(this._chatRepo) : super(const ChatStates());

  Future<void> createChatRoom({
    required User targetUser,
    required User currentUser,
  }) async {
    emit(state.copyWith(status: .loading));

    try {
      final chat = await _chatRepo.createChat(
        targetUser: targetUser,
        currentUser: currentUser,
      );

      emit(state.copyWith(status: .created, room: chat));
    } catch (e) {
      emit(state.copyWith(status: .failure, failure: e.toString()));
    }
  }
}
