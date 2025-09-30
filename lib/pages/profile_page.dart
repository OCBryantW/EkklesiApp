import 'package:comp_vis_project/feature/custom_card_button_3.dart';
import 'package:comp_vis_project/feature/custom_card_button_2.dart';
import 'package:comp_vis_project/pages/user_info.dart';
import 'package:comp_vis_project/model_data.dart';
import 'login_page.dart';
import 'edit_user_info.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow ;
import 'package:comp_vis_project/styles/customBtnStyle.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class ProfilePage extends StatefulWidget{
  final UserProfile user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void _handleSignOut(BuildContext context){

    // KOMEN INI JANGAN DIHAPUS
    // await _googleSignIn.signOut();
    currentUser = null;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logout Berhasil")),
    );
    Navigator.of(context).pushReplacementNamed("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Saya'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildStatsCard(),
            const SizedBox(height: 24),
            _buildMenuList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Color.fromARGB(255, 170, 170, 170),
          child: Icon(Icons.person, size: 60, color: Colors.white),
        ),
        const SizedBox(height: 12),
        Text(
          dummyUser.fullName,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          dummyUser.email,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return 
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomCardButton3(
                title: Center(
                  child: 
                  Row(
                    mainAxisSize: MainAxisSize.min,
                      children: [
                        // const Icon(
                        //   Icons.local_fire_department,
                        //   color: Colors.orange,
                        // ),
                        Text(
                          widget.user.exp.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                ),
                bgColor: Color.fromARGB(255, 247, 247, 247),
                shadowTitle: false, 
                subtitle: 'EXP Points',
                textColor: Color(0xFF000000),
                shadowSubtitle: true,
                width: 140,
              ),
            ),
            const SizedBox(width: 25),

            Expanded(
              child: 
              CustomCardButton3(
                title: Center(
                  child: 
                  Row(
                    mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: Colors.orange,
                        ),
                        Text(
                          widget.user.streak.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                ),
                bgColor: Color.fromARGB(255, 247, 247, 247),
                shadowTitle: false, 
                subtitle: 'Streak',
                textColor: Color(0xFF000000),
                shadowSubtitle: true,
                width: 140,
              )
            )
          ],
        ),
      );
  }

  Widget _buildMenuList(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
              boxShadow: Custombtnstyle.neumorphicShadows
            ),
            child: ListTile(
              leading: const Icon(Icons.account_circle, color: Colors.teal),
              title: const Text('Info Profil'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                await Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const UserInfo()),
                );
                setState (() {});
              },
            ),
          )
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
              boxShadow: Custombtnstyle.neumorphicShadows
            ),
            child: ListTile(
              leading: const Icon(Icons.settings, color: Colors.teal),
              title: const Text('Pengaturan'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          )
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
              boxShadow: Custombtnstyle.neumorphicShadows
            ),
            child:ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Keluar'),
              onTap: () => _handleSignOut(context),
            ),
          )
        ),
      ],
    );
  }
}