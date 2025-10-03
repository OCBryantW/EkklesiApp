import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'package:comp_vis_project/pages/home_page.dart';
import 'package:comp_vis_project/pages/login_page.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    print("DEBUG: AuthWrapper rebuild, user = $user");

    if (user == null) {
      return const LoginPage();
    } else {
      return const HomePage();
    }
  }
}
