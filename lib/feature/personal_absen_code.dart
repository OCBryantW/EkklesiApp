// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comp_vis_project/model_data.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class PersonalAbsenCode extends StatefulWidget {
  const PersonalAbsenCode({super.key});

  @override
  State<PersonalAbsenCode> createState() => _PersonalAbsenCodeState();
}

class _PersonalAbsenCodeState extends State<PersonalAbsenCode> {
  void _incrementCounter(UserProfile user) {
    setState(() {
      user.streak += 1;
      user.exp += 10;
    });
    // TODO: Simpan ke Firebase
    /*
    FirebaseFirestore.instance.collection("users").doc(currentUser.personalToken).update({
      "counter": FieldValue.increment(1)
    });
    */
  }

  void _showSnackBar(String message, Color color) {
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
  Widget build(BuildContext context) {
    final user = currentUser ?? dummyUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal QR Code Absen"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      /* body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        // KOMEN INI JANGAN DIHAPUS
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user.personalToken) // token jadi ID jemaat
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final streak = data["streak"] ?? 0;
          final exp = data["exp"] ?? 0;
          final attended = data["lastEvent"] == "2025-09-13/07.00";

          if (attended) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showSnackBar("Anda Berhasil Terabsen", Colors.green);
            });
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
                  Text("Streak: $streak, Exp: $exp"),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: PrettyQrView.data(
                      data: user.personalToken,
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
      ),*/
    );
  }
}
