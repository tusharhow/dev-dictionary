import 'package:dev_dictionary/src/router/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                fontFamily: 'Borno',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        ListTile(
          onTap: () {
            Navigator.pop(context);
          },
          leading: const Icon(
            Icons.home,
            size: 25,
          ),
          title: Text(
            'Home',
            style: GoogleFonts.inter(
              fontSize: 15,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            context.go('/${AppRouteConstants.bookmarksRouteName}');
          },
          leading: const Icon(
            Icons.bookmark,
            size: 25,
          ),
          title: Text(
            'Bookmark',
            style: GoogleFonts.inter(
              fontSize: 15,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            context.go('/${AppRouteConstants.settingsRouteName}');
          },
          leading: const Icon(
            Icons.settings,
            size: 25,
          ),
          title: Text(
            'Settings',
            style: GoogleFonts.inter(
              fontSize: 15,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            context.go('/${AppRouteConstants.aboutRouteName}');
          },
          leading: const Icon(
            Icons.info_outline,
            size: 25,
          ),
          title: Text(
            'About Us',
            style: GoogleFonts.inter(
              fontSize: 15,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            context.go('/${AppRouteConstants.contactUsRouteName}');
          },
          leading: const Icon(
            Icons.contact_mail,
            size: 25,
          ),
          title: Text(
            'Contact Us',
            style: GoogleFonts.inter(
              fontSize: 15,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            context.go('/${AppRouteConstants.contributionRouteName}');
          },
          leading: const Icon(
            Icons.help_center_outlined,
            size: 25,
          ),
          title: Text(
            'Contributors',
            style: GoogleFonts.inter(
              fontSize: 15,
            ),
          ),
        ),
      ]),
    );
  }
}
