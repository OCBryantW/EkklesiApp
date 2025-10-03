import 'package:comp_vis_project/feature/custom_card_button_2.dart';
import 'package:comp_vis_project/model_data.dart';
import 'package:comp_vis_project/pages/edit_user_info.dart';
import 'package:comp_vis_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';

class UserInfo extends ConsumerWidget {
  const UserInfo ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final userAsync = ref.watch(userDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Info Profil"),),
      body: userAsync.when(
        data: (user) {
          if (user == null){
            return const Center(child: Text("Belum login atau data user tidak ditemukan"));
          }

          return
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow("Nama Lengkap", user.fullName),
                _buildInfoRow("Umur", "${user.age}"),
                _buildInfoRow("Alamat", user.address),
                _buildInfoRow("Email", user.email),
                _buildInfoRow("No. Telepon", user.phone),
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
                              builder: (_) => EditUserInfo(user: user),
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
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Error: $e")),
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