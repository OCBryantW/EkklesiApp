import 'package:comp_vis_project/main.dart';
import 'package:comp_vis_project/model_data.dart';
import 'package:comp_vis_project/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleLoginPage extends StatefulWidget {
  const GoogleLoginPage({super.key});

  @override
  State<GoogleLoginPage> createState() => _GoogleLoginPageState();
}

//KOMEN INI JANGAN DIHAPUS
// class _GoogleLoginPageState extends State<GoogleLoginPage> {
//   GoogleSignInAccount? _user;
class _GoogleLoginPageState extends State<GoogleLoginPage> {
  @override
  void initState() {
    super.initState();
    // Listener ini penting untuk mendeteksi kapan pengguna berhasil login
    // dan kembali dari browser ke aplikasi.
    supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (session != null) {
        // Jika login berhasil, langsung pindah ke halaman utama
        // dan hapus semua halaman sebelumnya (agar tidak bisa back ke login page)
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()), 
          (route) => false,
        );
      }
    });
  }

  Future<void> _signInWithGoogle() async {
    try {
      // Panggil metode login OAuth dari Supabase
      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        // URL ini HARUS SAMA PERSIS dengan yang Anda atur di AndroidManifest.xml
        redirectTo: 'io.supabase.flutterquickstart://login-callback',
      );
    } catch (error) {
      // Jika ada error, tampilkan pesan
      print("Error login Google: $error");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login gagal, coba lagi.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Google")),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.login),
          label: const Text("Login dengan Google"),
          onPressed: _signInWithGoogle,
        )
      ),
    );
  }
}
