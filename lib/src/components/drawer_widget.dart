import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../views/bookmark/bookmark_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: bgColor,
        child: ListView(children: [
          const SizedBox(height: 50),
          Center(
            child: Text(
              'Dev Dictionary',
              style: GoogleFonts.oswald(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 50),
          ListTile(
            onTap: () {
              Get.to(() => const BookMarkScreen());
            },
            leading: const Icon(
              Icons.bookmark,
              color: Colors.white,
              size: 30,
            ),
            title: const Text(
              'Bookmark',
              style: TextStyle(
                color: Colors.white,
                fontSize: defaultPadding,
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 30,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: defaultPadding,
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.info,
              color: Colors.white,
              size: 30,
            ),
            title: const Text(
              'About',
              style: TextStyle(
                color: Colors.white,
                fontSize: defaultPadding,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
