import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'auth_provider.dart';

final userDataProvider = StreamProvider<UserModel?>((ref) {
  final user = ref.watch(authProvider);

  if (user == null) return Stream.value(null);

      final docRef = FirebaseFirestore.instance.collection("users").doc(user.uid);

      return docRef.snapshots().asyncMap((doc) async {
        if (!doc.exists) {
          // kalau user baru → buat default data
          final newUser = UserModel(
            uid: user.uid,
            fullName: user.fullName,
            age: 0,
            address: "-",
            email: user.email,
            phone: user.phone,
            exp: 0,
            streak: 0,
            role: "jemaat",
            isAdmin: false,
          );

          await docRef.set(newUser.toMap());
          return newUser;
        }

        // merge data firebase auth (displayName, email) + firestore (streak, exp, dll)
        final data = doc.data()!;
        return UserModel.fromMap({
          ...data,
          "uid": user.uid,
          "fullName": user.fullName,
          "email": user.email,
        });
      });
});
