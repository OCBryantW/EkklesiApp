import 'package:comp_vis_project/services/firebase_services.dart';
import '../services/firebase_services.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseServices _services = FirebaseServices();

  Future<UserModel?> getUser(String uid) async {
    final doc = await _services.firestore.collection('users').doc(uid).get();
    if(doc.exists){
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  Future<void> updateUser(UserModel user) async {
    await _services.firestore.collection('users').doc(user.uid).update(user.toMap());
  }
}