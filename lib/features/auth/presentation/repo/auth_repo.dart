import 'package:la8iny/features/auth/data/models/user_model.dart';

abstract interface class AuthRepo {
  Future<User> login({required String email, required String password});
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<User?> getUser();
  Future<void> logout();
}
