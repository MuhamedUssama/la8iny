// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'search_bloc.dart';

enum SearchStatus { initial, loading, loaded, failure }

extension SearchStatusX on SearchState {
  bool get isInitial => status == SearchStatus.initial;
  bool get isLoading => status == SearchStatus.loading;
  bool get isLoaded => status == SearchStatus.loaded;
  bool get isFailure => status == SearchStatus.failure;
}

@immutable
class SearchState {
  final SearchStatus status;
  final List<User>? users;
  final String? failureMessage;

  const SearchState({
    this.status = SearchStatus.initial,
    this.users,
    this.failureMessage,
  });

  SearchState copyWith({
    SearchStatus? status,
    List<User>? users,
    String? failureMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      users: users ?? this.users,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  bool operator ==(covariant SearchState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        listEquals(other.users, users) &&
        other.failureMessage == failureMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ users.hashCode ^ failureMessage.hashCode;
}
