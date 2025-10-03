// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comp_vis_project/model_data.dart';
import 'package:comp_vis_project/providers/user_provider.dart';
import 'package:comp_vis_project/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class PersonalAbsenCode extends ConsumerWidget {
  const PersonalAbsenCode({super.key});

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 160,
          left: 16,
          right: 15,
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal QR Code Absen"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: userAsync.when(
        data: (user) {
          if(user == null){
            return const Center(child: Text("Anda belum login akun Google"),);
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Tolong perlihatkan QR ini\nke penjaga pintu yang bertugas.\nTerima Kasih.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text("Streak: ${user.streak}, Exp: ${user.exp}"),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: PrettyQrView.data(
                      data: user.uid,
                      decoration: const PrettyQrDecoration(
                        shape: PrettyQrSmoothSymbol(),
                      ),
                      errorCorrectLevel: QrErrorCorrectLevel.H,
                    ),
                  ),
                ],
              ),
            ),
          );

        },
        loading: () => const Center(child: CircularProgressIndicator(),),
        error: (e, _) => Center(child: Text("Error: $e"),)
      )
    );
  }
}
