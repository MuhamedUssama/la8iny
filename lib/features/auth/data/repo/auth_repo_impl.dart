import 'package:injectable/injectable.dart';
import 'package:la8iny/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:la8iny/features/auth/data/data_sources/auth_remote_data_base.dart';
import 'package:la8iny/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:la8iny/features/auth/data/models/user_model.dart';
import 'package:la8iny/features/auth/presentation/repo/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final AuthRemoteDataBase _authRemoteDataBase;

  const AuthRepoImpl(
    this._authRemoteDataSource,
    this._authLocalDataSource,
    this._authRemoteDataBase,
  );

  @override
  Future<User> login({required String email, required String password}) async {
    final userCredential = await _authRemoteDataSource.login(
      email: email,
      password: password,
    );

    final user = await _authRemoteDataBase.getUser(userCredential.id);

    _authRemoteDataBase.saveUser(userCredential);

    _authLocalDataSource.cacheUser(user);

    return user;
  }

  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = await _authRemoteDataSource.signUp(
      name: name,
      email: email,
      password: password,
    );

    await _authRemoteDataBase.saveUser(user);
    await _authLocalDataSource.cacheUser(user);

    return user;
  }

  @override
  Future<User?> getUser() => _authLocalDataSource.getCachedUser();

  @override
  Future<void> logout() async {
    await Future.wait([
      _authRemoteDataSource.logout(),
      _authLocalDataSource.removeCachedUser(),
    ]);
  }
}
