import 'package:comp_vis_project/feature/custom_app_bar.dart';
import 'package:comp_vis_project/feature/custom_card_button_2.dart';
import 'package:comp_vis_project/feature/personal_absen_code.dart';
import 'package:comp_vis_project/feature/sorting_data_helper.dart';
import 'package:comp_vis_project/models/admin_model.dart';
import 'package:comp_vis_project/models/user_model.dart';
import 'package:comp_vis_project/pages/coba.dart';
import 'package:comp_vis_project/pages/detail_khotbah.dart';
import 'package:comp_vis_project/pages/login_page.dart';
import 'package:comp_vis_project/pages/persembahan.dart';
import 'package:comp_vis_project/pages/qr_scanner.dart';
import 'package:comp_vis_project/pages/warta_gereja.dart';
import 'package:comp_vis_project/providers/admin_provider.dart';
import 'package:comp_vis_project/providers/user_provider.dart';
import 'package:comp_vis_project/styles/customBtnStyle.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow ;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:comp_vis_project/model_data.dart';
import 'package:comp_vis_project/pages/halaman_khotbah.dart';
import 'package:comp_vis_project/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart'; // untuk cek login google
import 'package:comp_vis_project/model_data.dart';
import 'package:comp_vis_project/pages/halaman_warta.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart' hide BoxDecoration;
import 'package:comp_vis_project/feature/custom_card_button.dart';
import 'package:flutter/material.dart';
import 'package:comp_vis_project/pages/login_page.dart'; 
// import 'package:comp_vis_project/pages/SplashPage.dart';
import 'package:comp_vis_project/services/firebase_services.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HomePage extends ConsumerWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final adminAsync = ref.watch(adminProvider);

    return Scaffold(
      body:  
          
          
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildCongregationCounterCard(/*admin,*/ context),
                  const SizedBox(height: 20),
                  _buildActionButtons(context),
                  const SizedBox(height: 24),
                  _buildRecentSermons(context),
                  const SizedBox(height: 10),
                  _buildWartaGereja(context),
                  const SizedBox(height: kBottomNavigationBarHeight),
                ],
              ),
            ),
          )
        // },
        // loading: () => const Center(child: CircularProgressIndicator()),
        // error: (e, _) => Center(child: Text("Error: $e")),
      // )
    );
  }

  Widget _buildCongregationCounterCard(BuildContext context) {
    return Container(
      // width: 700,
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: 
            Image.asset(
              'assets/images/church.png',
              width: 640,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 56),
            child: Row(
              children: [
                // Icon(Icons.people_alt, size: 40, color: Colors.teal.shade600),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "0 Jemaat",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC6C6C6),
                      ),
                    ),
                    Text(
                      "Jumlah Kehadiran Saat Ini",
                      style: TextStyle(color: Color(0xFF8E8E8E)),
                    ),
                    const SizedBox(height: 20),
                    CustomCardButton2(
                      title: Text('Absensi QR'),
                      width: 180,
                      shadowTitle: true,
                      shadowSubtitle: false,
                      // subtitle: "Tampilkan QR Absen Anda",
                      icon: Icons.qr_code_scanner,
                      iconColor: Colors.black,
                      bgColor: const Color.fromARGB(255, 247, 247, 247),
                      textColor: Colors.black,
                      onTap: (){
                        Navigator.push(
                          context, 
                           MaterialPageRoute(
                            builder: (context) => const ProfilePage(), // SEPERTI INI
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        Expanded(
          child: 
        CustomCardButton2(
          title: Text('QR Scanner'),
          shadowTitle: true,
          shadowSubtitle: false,
          bgColor: const Color(0xFFFA8181),
          textColor: const Color(0xFFFFFFFF),
          icon: Icons.qr_code_scanner,
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => QrScanner()),
            );
          },
        ),
          
          ),
        const SizedBox(width: 8),
        Expanded(child: 
        
        CustomCardButton2(
          title: Text('Persembahan'),
          shadowTitle: true,
          shadowSubtitle: false,
          fontSize: 16,
          bgColor: const Color(0xFFC6E068),
          textColor: const Color(0xFFFFFFFF),
          icon: Icons.card_giftcard,
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Persembahan()),
            );
          },
        ),
        )
      ],
    );
  }

  Widget _buildRecentSermons(BuildContext context) {

  final latestSermons = getLatestToLongestSermons(limit: 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 19),
          child: Text(
            "Kotbah Terbaru",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Hanya menampilkan 2 kotbah terbaru di halaman utama
        ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final sermon = latestSermons[index];
            return CustomCardButton(
              title: sermon.title, 
              subtitle: "${sermon.preacher}\n${sermon.date.day}/${sermon.date.month}/${sermon.date.year}", 
              icon: AppIcons.sermon,
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => DetailKhotbah(sermon: sermon)
                  )
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildWartaGereja(BuildContext context){

  final longestWarta = getLongestToLatestWarta(limit: 3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 19),
          child: Text(
            "Warta Gereja",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            
          ),

        ),
        const SizedBox(height: 16),
        ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final warta = longestWarta[index];
            return CustomCardButton(
              title: warta.title, 
              subtitle: "${warta.preacher}\n${warta.date.day}/${warta.date.month}/${warta.date.year}", 
              icon: AppIcons.warta,
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => WartaGereja(warta: warta)
                  )
                );
              },
            );
          },
        ),
      ],
    );
  }
}