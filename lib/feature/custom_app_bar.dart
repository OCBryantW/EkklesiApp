import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final int streak;
  // final String subtitle;
  final String avatarPath;

  const CustomAppBar({
    Key? key,
    required this.username,
    required this.streak,
    // required this.subtitle,
    required this.avatarPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 28),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, $username",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Kiranya kasih karunia Tuhan\nmenyertai Anda hari ini.",
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            ),

            const Spacer(),

            const Icon(Icons.local_fire_department, color: Colors.amber, size: 31,),
            const SizedBox(width: 4),
            Text(
              '$streak',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),

            const SizedBox(width: 12),

            const CircleAvatar(
              radius: 25,
              backgroundColor: Color.fromARGB(255, 170, 170, 170),
              child: Icon(Icons.person, size: 35, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(127);
}