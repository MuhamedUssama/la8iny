import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:la8iny/features/auth/data/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:la8iny/features/tabs/chat_tab/data/repository/chat_repo.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ChatRepo _chatRepo;

  SearchBloc(this._chatRepo) : super(const SearchState()) {
    on<SearchEvent>(
      _search,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 500))
            .distinct()
            .switchMap(mapper);
      },
    );
  }

  Future<void> _search(SearchEvent event, Emitter<SearchState> emit) async {
    if (event.query.isEmpty) {
      emit(state.copyWith(status: .initial, users: const []));
      return;
    }

    emit(state.copyWith(status: SearchStatus.loading));

    try {
      final users = await _chatRepo.searchUsers(event.query);
      emit(state.copyWith(status: .loaded, users: users));
    } catch (e) {
      emit(state.copyWith(status: .failure, failureMessage: e.toString()));
    }
  }
}
