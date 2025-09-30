import 'package:comp_vis_project/feature/custom_card_button_2.dart';
import 'package:comp_vis_project/model_data.dart';
import 'package:comp_vis_project/pages/edit_user_info.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Info Profil"),),
      body: Padding(padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow("Nama Lengkap", dummyUser.fullName),
            _buildInfoRow("Umur", "${dummyUser.age}"),
            _buildInfoRow("Alamat", dummyUser.address),
            _buildInfoRow("Email", dummyUser.email),
            _buildInfoRow("No. Telepon", dummyUser.phone),
            const SizedBox(height: 20,),
            Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
      child: IntrinsicWidth(
        child: CustomCardButton2(
          width: 150,
          title: const Text('Edit Info'),
          icon: Icons.edit,
          iconColor: Colors.black,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditUserInfo(user: dummyUser),
              ),
            );
          },
          shadowTitle: false,
          shadowSubtitle: false,
        ),
      ),
    ),
  ],
),

          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text("$label:", style: const TextStyle(fontSize: 16),)),
          Expanded(flex: 3, child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
        ],
      ),
    );
  }
}