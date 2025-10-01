// lib/pages/splash_page.dart

import 'package:comp_vis_project/main.dart';
import 'package:comp_vis_project/pages/login_page.dart';
import 'package:comp_vis_project/pages/profile_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Panggil fungsi pengecekan saat halaman ini pertama kali dibuka
    _redirect();
  }

  Future<void> _redirect() async {
    // Beri sedikit jeda untuk memastikan Supabase siap
    await Future.delayed(Duration.zero);

    // Cek apakah ada sesi yang sedang berjalan (user sudah login sebelumnya)
    final session = supabase.auth.currentSession;

    if (!mounted) return;

    if (session != null) {
      // Jika ada sesi, langsung arahkan ke ProfilePage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    } else {
      // Jika tidak ada sesi, arahkan ke GoogleLoginPage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const GoogleLoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Halaman ini hanya menampilkan loading indicator saat proses pengecekan
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}