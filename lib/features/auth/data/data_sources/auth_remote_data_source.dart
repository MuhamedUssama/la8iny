import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';
import 'package:la8iny/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<User> login({required String email, required String password});
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<void> logout();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  const AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<User> login({required String email, required String password}) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final firebaseUser = userCredential.user;

    if (firebaseUser == null) throw Exception('User not found');

    return User(
      id: firebaseUser.uid,
      fullname: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
    );
  }

  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await userCredential.user?.updateDisplayName(name);
    final firebaseUser = userCredential.user;

    if (firebaseUser == null) throw Exception('User not found');

    return User(
      id: firebaseUser.uid,
      fullname: name,
      email: firebaseUser.email ?? '',
    );
  }

  @override
  Future<void> logout() => _firebaseAuth.signOut();
}
