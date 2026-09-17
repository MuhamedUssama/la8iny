import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:la8iny/core/utils/app_constants.dart';
import 'package:la8iny/features/auth/data/models/user_model.dart';
import 'package:la8iny/features/tabs/chat_tab/data/data_sources/chat_data_source.dart';

@LazySingleton(as: ChatDataSource)
class ChatDataSourceImpl implements ChatDataSource {
  final FirebaseFirestore _firestore;
  const ChatDataSourceImpl(this._firestore);

  @override
  Future<List<User>> searchUsers(String query) async {
    final collectionRef = _firestore.collection(AppConstants.usersCollection);

    final QuerySnapshot<User> querySnapshot = await collectionRef
        .withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromMap(snapshot.data() ?? {}),
          toFirestore: (user, _) => user.toMap(),
        )
        .where(
          "fullname_lowercase",
          isGreaterThanOrEqualTo: query.toLowerCase(),
        )
        .where("fullname_lowercase", isLessThan: '${query.toLowerCase()}\uf8ff')
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
