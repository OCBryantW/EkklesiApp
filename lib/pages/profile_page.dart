import 'package:comp_vis_project/feature/custom_card_button_3.dart';
import 'package:comp_vis_project/main.dart'; // Untuk akses 'supabase'
import 'package:comp_vis_project/pages/login_page.dart';
import 'package:comp_vis_project/pages/user_info.dart';
import 'package:comp_vis_project/styles/customBtnStyle.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Fungsi untuk mengambil data profil dari tabel 'profiles' di Supabase
  Future<Map<String, dynamic>> _fetchUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw 'Anda belum login';
    }

    final response =
        await supabase.from('profiles').select().eq('id', user.id).single();

    return response;
  }

  // Fungsi logout yang benar menggunakan Supabase
  Future<void> _handleSignOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }

    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const GoogleLoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            final userProfile = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildProfileHeader(userProfile),
                  const SizedBox(height: 24),
                  _buildStatsCard(userProfile),
                  const SizedBox(height: 24),
                  _buildMenuList(context),
                ],
              ),
            );
          }
          return const Center(child: Text('Tidak ada data'));
        },
      ),
    );
  }

  Widget _buildProfileHeader(Map<String, dynamic> profile) {
    final avatarUrl = profile['avatar_url'];

    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
          child: avatarUrl == null
              ? const Icon(Icons.person, size: 60, color: Colors.white)
              : null,
        ),
        const SizedBox(height: 12),
        Text(
          profile['full_name'] ?? 'Nama Tidak Ada',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          profile['email'] ?? 'Email Tidak Ada',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildStatsCard(Map<String, dynamic> profile) {
    // Pastikan Anda punya kolom 'exp' dan 'streak' di tabel 'profiles'
    // Jika tidak ada, nilainya akan menjadi 0
    final exp = profile['exp'] ?? 0;
    final streak = profile['streak'] ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: CustomCardButton3(
              title: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      exp.toString(), // Menggunakan data 'exp' dari Supabase
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              bgColor: const Color.fromARGB(255, 247, 247, 247),
              shadowTitle: false,
              subtitle: 'EXP Points',
              textColor: const Color(0xFF000000),
              shadowSubtitle: true,
              width: 140,
            ),
          ),
          const SizedBox(width: 25),
          Expanded(
            child: CustomCardButton3(
              title: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.orange,
                    ),
                    Text(
                      streak.toString(), // Menggunakan data 'streak' dari Supabase
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              bgColor: const Color.fromARGB(255, 247, 247, 247),
              shadowTitle: false,
              subtitle: 'Streak',
              textColor: const Color(0xFF000000),
              shadowSubtitle: true,
              width: 140,
            ),
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
                  boxShadow: Custombtnstyle.neumorphicShadows),
              child: ListTile(
                leading: const Icon(Icons.account_circle, color: Colors.teal),
                title: const Text('Info Profil'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserInfo()),
                  );
                  setState(() {});
                },
              ),
            )),
        Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  boxShadow: Custombtnstyle.neumorphicShadows),
              child: ListTile(
                leading: const Icon(Icons.settings, color: Colors.teal),
                title: const Text('Pengaturan'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            )),
        Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  boxShadow: Custombtnstyle.neumorphicShadows),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Keluar'),
                onTap: _handleSignOut, // Menggunakan fungsi logout yang baru
              ),
            )),
      ],
    );
  }
}