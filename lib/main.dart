import 'package:comp_vis_project/feature/custom_app_bar.dart';
// import 'package:comp_vis_project/feature/custom_card_button_2.dart';
// import 'package:comp_vis_project/feature/personal_absen_code.dart';
// import 'package:comp_vis_project/feature/sorting_data_helper.dart';
// import 'package:comp_vis_project/pages/coba.dart';
// import 'package:comp_vis_project/pages/detail_khotbah.dart';
import 'package:comp_vis_project/pages/home_page.dart';
import 'package:comp_vis_project/providers/user_provider.dart';
// import 'package:comp_vis_project/pages/login_page.dart';
// import 'package:comp_vis_project/pages/persembahan.dart';
// import 'package:comp_vis_project/pages/qr_scanner.dart';
// import 'package:comp_vis_project/pages/warta_gereja.dart';
import 'package:comp_vis_project/styles/customBtnStyle.dart';
// import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow ;
// import 'package:pretty_qr_code/pretty_qr_code.dart';
// import 'package:comp_vis_project/model_data.dart';
import 'package:comp_vis_project/pages/halaman_khotbah.dart';
import 'package:comp_vis_project/pages/profile_page.dart';
import 'package:comp_vis_project/wrapper/auth_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart'; // untuk cek login google
// import 'package:comp_vis_project/model_data.dart';
import 'package:comp_vis_project/pages/halaman_warta.dart';
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart' hide BoxDecoration;
// import 'package:comp_vis_project/feature/custom_card_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// final supabase = Supabase.instance.client;
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'EkklesiApp',
      theme: ThemeData(
        // primaryTextTheme: TextStyle(fontFamily: 'inter'),
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white24,
          foregroundColor: Colors.black,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22.0,      // Set the font size
            fontWeight: FontWeight.bold, // Set the font weight
          ),
          elevation: 2,
        ),
        cardTheme: CardThemeData(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            // backgroundColor: Colors.transparent,
            // foregroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AuthWrapper()
    );
  }
}

// Halaman utama dengan Bottom Navigation Bar
class MainScreen extends ConsumerStatefulWidget{
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>{
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){

    final userData = ref.watch(userDataProvider);

    final pages = [
      const HomePage(),
      const HalamanKhotbah(),
      const HalamanWarta(),
      const ProfilePage()

      // ProfileService.isLoggedIn
      //     ? ProfilePage()
      //     : const GoogleLoginPage()
    ];

    return userData.when(
      data: (userModel) {
        if (userModel == null){
          return const Center(child: Text("Belum login"));
        }

        return 
        Scaffold(
          appBar: _selectedIndex == 3
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(127), 
                  child: CustomAppBar(
                    username: userModel.fullName ?? 'Guest', 
                    streak: userModel.streak ?? 0, 
                    // subtitle: "Kiranya kasih karunia menyertai Anda hari ini.", 
                    avatarPath: "assets/images/Castorice_Maid.png"
                  )
                ),

          body: Stack(
            children: [
              pages[_selectedIndex],

              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Container(
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 247, 247),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: Custombtnstyle.appearButton
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: Colors.transparent,
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Khotbah'),
                          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Warta'),
                          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
                        ],
                        currentIndex: _selectedIndex,
                        selectedItemColor: Colors.black,
                        unselectedItemColor: Colors.white, // <- tambahkan ini
                        onTap: _onItemTapped,
                      ),
                    )
                    
                  ),
                ),
              )
            ],
          )
        );

      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Error: $e")),
    );
    
  }
}