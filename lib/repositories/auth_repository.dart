import 'package:comp_vis_project/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/firebase_services.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseServices _services = FirebaseServices();

  Stream<User?> get authStateChanges => _services.auth.authStateChanges();

  Future<UserModel?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _services.googleSignIn.signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await _services.auth.signInWithCredential(credential);
    final user = userCredential.user;

    if (user != null){
      final userDoc = _services.firestore.collection('users').doc(user.uid);

      final snapshot = await userDoc.get();

      if(!snapshot.exists){
        final newUser = UserModel(
          uid: user.uid, 
          fullName: user.displayName ?? 'Guest', 
          age: 0, 
          address: '-', 
          email: user.email ?? '-', 
          phone: user.phoneNumber ?? '-', 
          role: 'Jemaat',
          exp: 0,
          streak: 0,
          isAdmin: false,
        );
        await userDoc.set(newUser.toMap());
        return newUser;
      }else{
        final data = snapshot.data()!;

        return UserModel.fromMap(
          {...data,
          "uid": user.uid,
          "fullName": user.displayName,
          "email": user.email ?? data['email']}
        );
      }
    }
    return null;
  }

  Future<void> signOut() async {
    await _services.googleSignIn.signOut();
    await _services.auth.signOut();
  }

  Future<UserModel?> getUserData(String uid) async {
    final doc = await _services.firestore.collection('users').doc(uid).get();
    if (doc.exists && doc.data() != null){
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }
}