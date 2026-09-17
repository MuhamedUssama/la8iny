import 'package:injectable/injectable.dart';
import 'package:la8iny/features/auth/data/models/user_model.dart';
import 'package:la8iny/features/tabs/chat_tab/data/data_sources/chat_data_source.dart';
import 'package:la8iny/features/tabs/chat_tab/data/repository/chat_repo.dart';

@LazySingleton(as: ChatRepo)
class ChatRepoImpl implements ChatRepo {
  final ChatDataSource _dataSource;
  const ChatRepoImpl(this._dataSource);

  @override
  Future<List<User>> searchUsers(String query) {
    return _dataSource.searchUsers(query);
  }
}
