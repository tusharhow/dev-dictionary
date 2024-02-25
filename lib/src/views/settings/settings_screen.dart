import 'package:dev_dictionary/src/controllers/theme_controller.dart';
import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/popup_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WordDataController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 25,
            ),
          ),
          title: const Text(
            'Settings',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        body:
            Consumer<WordDataController>(builder: (context, controller, child) {
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
            ],
          );
        }),
      );
    });
  }
}
