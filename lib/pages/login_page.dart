import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends ConsumerWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final auth = ref.watch(authProvider.notifier);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await auth.login();
          }, 
          child: Text("Login dengan Google")
        ),
      ),
    );
  }
}