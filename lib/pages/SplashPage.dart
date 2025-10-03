// // lib/pages/splash_page.dart

// import 'package:comp_vis_project/main.dart';
// import 'package:comp_vis_project/pages/login_page.dart';
// import 'package:comp_vis_project/pages/profile_page.dart';
// import 'package:flutter/material.dart';
// import 'package:comp_vis_project/services/firebase_services.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Panggil fungsi pengecekan saat halaman ini pertama kali dibuka
//     _redirect();
//   }

//   Future<void> _redirect() async {
//     await Future.delayed(const Duration(milliseconds: 500)); // optional loading
//     if (ProfileService.isLoggedIn) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const HomePage()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const GoogleLoginPage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Halaman ini hanya menampilkan loading indicator saat proses pengecekan
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }