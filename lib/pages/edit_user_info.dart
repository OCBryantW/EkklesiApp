import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comp_vis_project/feature/custom_card_button_2.dart';
import 'package:comp_vis_project/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:comp_vis_project/model_data.dart';

class EditUserInfo extends StatefulWidget{
  final UserModel user;

  const EditUserInfo({super.key, required this.user});

  @override
  State<EditUserInfo> createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfo> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController addressController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.fullName);
    ageController = TextEditingController(text: widget.user.age.toString());
    addressController = TextEditingController(text: widget.user.address);
    phoneController = TextEditingController(text: widget.user.phone);
  }

  void _saveChanges() async {
    // NANTI SAAT MENGGUNAKAN FIREBASE, setState DIKOMEN AJA GANTI 
    // SAMA KOMEN YANG DIBAWAHNYA
    setState(() {
      widget.user.fullName = nameController.text;
      widget.user.age = int.tryParse(ageController.text) ?? widget.user.age;
      widget.user.address = addressController.text;
      widget.user.phone = phoneController.text;
    });

    await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update(widget.user.toMap());

    Navigator.pop(context); // keluar dari EditUserInfoPage
    // Navigator.pop(context); // keluar dari UserInfoPage
  }

  void _cancelChanges() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Informasi Pengguna")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama Lengkap"),
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Umur"),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: "Alamat"),
            ),
            TextField(
              controller: TextEditingController(text: widget.user.email),
              enabled: false,
              decoration: const InputDecoration(labelText: "Email (tidak bisa diubah)"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "No. Telepon"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCardButton2(
                  width: 150,
                  title: const Text('Simpan'), 
                  shadowTitle: true, 
                  shadowSubtitle: false,
                  icon: Icons.check_circle_rounded,
                  // iconColor: Colors.white,
                  // textColor: Colors.white,
                  bgColor: Colors.teal,
                  onTap: _saveChanges,
                ),
                CustomCardButton2(
                  width: 150,
                  title: const Text('Batalkan'), 
                  shadowTitle: true, 
                  shadowSubtitle: false,
                  icon: Icons.cancel_rounded,
                  // iconColor: Colors.black,
                  // textColor: Colors.black,
                  bgColor: Colors.redAccent,
                  onTap: _cancelChanges,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}