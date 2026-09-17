part of 'search_bloc.dart';

@immutable
class SearchEvent {
  final String query;

  const SearchEvent(this.query);

  @override
  bool operator ==(covariant SearchEvent other) {
    if (identical(this, other)) return true;
    return other.query == query;
  }

  @override
  int get hashCode => query.hashCode;

  @override
  String toString() => 'SearchEvent(query: $query)';
}
