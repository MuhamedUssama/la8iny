import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:la8iny/core/utils/app_constants.dart';
import 'package:la8iny/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataBase {
  Future<User> getUser(String id);
  Future<void> saveUser(User user);
}

@LazySingleton(as: AuthRemoteDataBase)
class AuthRemoteDatabaseImpl implements AuthRemoteDataBase {
  final FirebaseFirestore _firestore;

  const AuthRemoteDatabaseImpl(this._firestore);

  @override
  Future<User> getUser(String id) async {
    final snapshot = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(id)
        .get();

    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception('User does not exist');
    }

    return User.fromMap(snapshot.data()!);
  }

  @override
  Future<void> saveUser(User user) async {
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(user.id)
        .set(user.toMap());
  }
}
