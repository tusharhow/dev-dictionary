import 'package:dev_dictionary/src/controllers/theme_controller.dart';
import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/router/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../components/popup_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WordDataController>(builder: (context, controller, child) {
      return SafeArea(
        child: Scaffold(
          body: Consumer<WordDataController>(
              builder: (context, controller, child) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          buildPopupDialog(context),
                    );
                  },
                  leading: const Icon(
                    Icons.format_size,
                    size: 25,
                  ),
                  title: const Text(
                    'Change Font Size',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Consumer<ThemeController>(
                            builder: (context, themeController, child) {
                          return AlertDialog(
                            title: const Text('Select Theme'),
                            content: SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Light'),
                                        Switch(
                                          value: themeController.isDarkMode,
                                          onChanged: (value) {
                                            themeController.toggleDarkMode();
                                          },
                                          activeTrackColor: Colors.deepPurple,
                                          activeColor: Colors.white,
                                        ),
                                        const Text('Dark'),
                                      ])
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },
                  leading: const Icon(
                    Icons.brightness_6,
                    size: 25,
                  ),
                  title: const Text(
                    'Change Theme',
                    style: TextStyle(
                      fontSize: 16,
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
              ],
            );
          }),
        ),
      );
    });
  }
}
