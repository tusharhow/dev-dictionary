import 'package:dev_dictionary/src/views/about/about_us.dart';
import 'package:dev_dictionary/src/views/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../views/about/contact_us.dart';
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Center(
                  child: Text(
                    'ডেভ',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Borno',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'ডিকশনারি',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontFamily: 'Borno',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          ListTile(
            onTap: () {
              Get.to(() => BookMarkScreen());
            },
            leading: const Icon(
              Icons.bookmark,
              color: Colors.white,
              size: 25,
            ),
            title: Text(
              'Bookmark',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(() => SettingsScreen());
            },
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25,
            ),
            title: Text(
              'Settings',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(() => const AboutUsScreen());
            },
            leading: const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 25,
            ),
            title: Text(
              'About Us',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(() => const ContactUsScreen());
            },
            leading: const Icon(
              Icons.contact_mail,
              color: Colors.white,
              size: 25,
            ),
            title: Text(
              'Contact Us',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
