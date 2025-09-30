import 'package:comp_vis_project/main.dart';
import 'package:comp_vis_project/model_data.dart';
import 'package:comp_vis_project/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginPage extends StatefulWidget {
  const GoogleLoginPage({super.key});

  @override
  State<GoogleLoginPage> createState() => _GoogleLoginPageState();
}

//KOMEN INI JANGAN DIHAPUS
// class _GoogleLoginPageState extends State<GoogleLoginPage> {
//   GoogleSignInAccount? _user;
class _GoogleLoginPageState extends State<GoogleLoginPage> {
  UserProfile? _user;

  // Instance Google SignIn
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn() async {
    try {
      // KOMEN INI JANGAN DIHAPUS
      // final account = await _googleSignIn.signIn(); 
      setState(() {
        // _user = account;
        _user = dummyUser; //JANGAN LUPA UBAH dummyUser menjadi acoount
      });
      currentUser = _user;

      // BAGIAN KOMEN INI JAGAN DIHAPUS BUAT KARENA AKAN KEPAKE
      // if (account != null) {
      //   // TODO: Simpan ke database backend (email, displayName, photoUrl)
      //   print("Login berhasil: ${account.displayName}, ${account.email}");
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text("Login sebagai ${account.displayName}")),
      //   );
      // }

      // Setelah login, balik ke MainPage (bukan langsung ProfilePage)
      // Navigator.pushReplacementNamed(context, "/main");
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (_) => const MainScreen()), 
        (route) => false
      );
      
    } catch (error) {
      print("Error login Google: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login gagal")),
      );
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
          onPressed: _handleSignIn,
        )
      ),
    );
  }
}
