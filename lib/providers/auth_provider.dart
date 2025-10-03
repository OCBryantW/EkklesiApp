import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthNotifier extends StateNotifier<UserModel?>{
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(null){
    _authRepository.authStateChanges.listen((user) async {
      if(user == null) {
        print("DEBUG: user null dari FirebaseAuth");
        state = null;
      } else {
        print("DEBUG: user login => ${user.uid}");
        final userData = await _authRepository.getUserData(user.uid);
        print("DEBUG: userData dari Firestore => $userData");
        state = userData;
      }
    });
  }

  Future<void> login() async {
    final user = await _authRepository.signInWithGoogle();
    print("DEBUG: hasil signInWithGoogle => $user");
    state = user;
  }

  Future<void> logout() async {
    await _authRepository.signOut();
    state = null;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, UserModel?>((ref) {
  return AuthNotifier(AuthRepository());
});

