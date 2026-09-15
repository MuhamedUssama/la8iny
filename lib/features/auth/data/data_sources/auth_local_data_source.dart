import 'package:injectable/injectable.dart';
import 'package:la8iny/core/services/shared_pref_service.dart';
import 'package:la8iny/core/utils/app_constants.dart';
import 'package:la8iny/features/auth/data/models/user_model.dart';

abstract interface class AuthLocalDataSource {
  Future<void> cacheUser(User user);
  Future<User?> getCachedUser();
  Future<void> removeCachedUser();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> cacheUser(User user) async {
    await SharedPrefService.setString(AppConstants.cacheUserKey, user.toJson());
  }

  @override
  Future<User?> getCachedUser() async {
    final userJson = SharedPrefService.getString(AppConstants.cacheUserKey);
    return userJson != null ? User.fromJson(userJson) : null;
  }

  @override
  Future<void> removeCachedUser() {
    return SharedPrefService.remove(AppConstants.cacheUserKey) ??
        Future.value(null);
  }
}
