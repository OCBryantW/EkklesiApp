import 'package:flutter/material.dart';
import 'package:comp_vis_project/model_data.dart';

class EditUserInfo extends StatefulWidget{
  final UserProfile user;

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

  void _saveChanges() {
    // NANTI SAAT MENGGUNAKAN FIREBASE, setState DIKOMEN AJA GANTI 
    // SAMA KOMEN YANG DIBAWAHNYA
    setState(() {
      dummyUser.fullName = nameController.text;
      dummyUser.age = int.tryParse(ageController.text) ?? widget.user.age;
      dummyUser.address = addressController.text;
      dummyUser.phone = phoneController.text;
    });

    // TODO: Update ke Firebase
    // FirebaseFirestore.instance.collection("users").doc(widget.user.email).update({
    //   "fullName": dummyUser.fullName,
    //   "age": dummyUser.age,
    //   "address": dummyUser.address,
    //   "phone": dummyUser.phone,
    // });

    Navigator.pop(context); // keluar dari EditUserInfoPage
    Navigator.pop(context); // keluar dari UserInfoPage
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
                ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: const Text("Simpan Perubahan"),
                ),
                ElevatedButton(
                  onPressed: _cancelChanges,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text("Batalkan"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}