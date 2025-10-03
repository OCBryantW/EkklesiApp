import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comp_vis_project/model_data.dart';
import 'package:comp_vis_project/providers/user_provider.dart';
import 'package:comp_vis_project/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:comp_vis_project/services/firebase_services.dart';


class QrScanner extends StatefulWidget {
  @override
  State<QrScanner> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<QrScanner>{
  final Set<String> scannedTokens = {};
  final String currentEvent = "2025-09-13/07.00";

  final MobileScannerController controller = MobileScannerController();

  final Set<String> validTokens = {
    "abc123xyz",
    "dummyToken123",
    "userTokenABC",
    "userTokenXYZ"
  };

  String? lastToken;
  int duplicateCount = 0;
  Timer? holdTimer;

  // --- validasi ke Firebase (nanti bisa dipakai) ---
  Future<bool> _isValidTokenFromFirebase(String token) async {
    try {
      final doc = await FirebaseFirestore.instance.collection("users").doc(token).get();
      return doc.exists;
    } catch (e) {
      print("Error cek token Firebase: $e");
      return false;
    } // sementara return false dulu
  }

  Future <bool> _isValidToken(String token) async{
    // cek versi lokal
    if (validTokens.contains(token)) return true;

    // kalau sudah pakai Firebase tinggal aktifkan
    return await _isValidTokenFromFirebase(token);
  }

  void _handleScan(String token) async{
    if(!await _isValidToken(token)){
      _showSnackBar("QR Tidak Valid!", Colors.red);
      return;
    }

    String uniqueKey = "$token-$currentEvent";

    // Jika token baru → reset state
    if (lastToken != token){
      lastToken = token;
      duplicateCount = 0;
      holdTimer?.cancel(); // hentikan timer lama

      if(!scannedTokens.contains(uniqueKey)){
        scannedTokens.add(uniqueKey);

        // KOMEN INI JANGAN DIHAPUS
        // --- UPDATE FIREBASE DI SINI ---
        try {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(token) // anggap token = documentId
              .update({
            "streak": FieldValue.increment(1),
            "exp": FieldValue.increment(10),
            "lastEvent": currentEvent,
          });

          _showSnackBar("Jemaat Berhasil Terabsen", Colors.green);

          // bool isAdmin = await AdminServices.isAdmin(token);
          // if(isAdmin){
          //   await AdminServices.incrementAdminCounter(token);
          // }

        } catch (e) {
          _showSnackBar("Gagal update Firebase: $e", Colors.red);
        }
        
      } else {
        _showSnackBar("Jemaat Sudah Terabsen", Colors.orange);
      }

      holdTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer){
        if (lastToken == token && scannedTokens.contains(uniqueKey)){
          if (duplicateCount < 2){
            duplicateCount++;
            _showSnackBar("Jemaat Sudah Terabsen", Colors.orange);
          }else{
            timer.cancel();
          }
        }
      });
      lastToken = token;
      duplicateCount = 0;
    }
  }

  void _showSnackBar(String message, Color color){
    ScaffoldMessenger.of(context).clearSnackBars(); //membersihkan snackbar lama
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white),),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 160, 
          left: 16, 
          right: 15
        ),
        duration: const Duration(seconds: 1),
      )
    );
  }

  @override
  void dispose() {
    holdTimer?.cancel();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context){
  //   return Scaffold(
  //     appBar: AppBar(title: Text("Scan QR Jemaat"),),
  //     body: MobileScanner(
  //       onDetect: (barcodeCapture){
  //         final List<Barcode> barcodes = barcodeCapture.barcodes;
  //         for (final barcode in barcodes){
  //           final token = barcode.rawValue;
  //           if(token != null){
  //             _handleScan(token);
  //           }
  //         }
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR Jemaat")),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              onDetect: (barcodeCapture) {
                final List<Barcode> barcodes = barcodeCapture.barcodes;
                for (final barcode in barcodes) {
                  final token = barcode.rawValue;
                  if (token != null) {
                    _handleScan(token);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}