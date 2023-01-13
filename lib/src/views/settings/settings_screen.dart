import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../components/popup_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordDataController>(
        init: WordDataController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor:
                controller.isDarkMode.value ? Colors.white : bgColor,
            appBar: AppBar(
              backgroundColor:
                  controller.isDarkMode.value ? Colors.white : bgColor,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color:
                      controller.isDarkMode.value ? Colors.black : Colors.white,
                  size: 25,
                ),
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color:
                      controller.isDarkMode.value ? Colors.black : Colors.white,
                  fontSize: controller.fontSize.value,
                ),
              ),
            ),
            body: GetBuilder<WordDataController>(
                init: WordDataController(),
                builder: (controller) {
                  return Column(
                    children: [
                      const SizedBox(height: defaultPadding),
                      Padding(
                        padding: const EdgeInsets.only(left: defaultPadding),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: controller.isDarkMode.value
                                  ? Colors.black
                                  : Colors.white,
                              size: 30,
                            ),
                            const SizedBox(width: 25),
                            PopupMenuButton(
                              onSelected: (value) {},
                              initialValue: controller.isDarkMode.value
                                  ? "Dark Theme"
                                  : "Light Theme",
                              splashRadius: 10,
                              tooltip: controller.isDarkMode.value
                                  ? "Dark Theme"
                                  : "Light Theme",
                              onCanceled: () {},
                              color: controller.isDarkMode.value
                                  ? Colors.black
                                  : Colors.white,
                              child: Text("Change Theme",
                                  style: TextStyle(
                                    color: controller.isDarkMode.value
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: controller.fontSize.value,
                                  )),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  onTap: () {
                                    controller.isDarkMode.value == true
                                        ? controller.toggleDarkMode()
                                        : null;
                                  },
                                  value: "Dark Theme",
                                  child: Text("Dark Theme",
                                      style: TextStyle(
                                        color: controller.isDarkMode.value
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: controller.fontSize.value,
                                      )),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    controller.isDarkMode.value == false
                                        ? controller.toggleDarkMode()
                                        : null;
                                  },
                                  value: "Light Theme",
                                  child: Text("Light Theme",
                                      style: TextStyle(
                                        color: controller.isDarkMode.value
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: controller.fontSize.value,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                buildPopupDialog(context),
                          );
                        },
                        leading: Icon(
                          Icons.format_size,
                          color: controller.isDarkMode.value
                              ? Colors.black
                              : Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Change Font Size',
                          style: TextStyle(
                            color: controller.isDarkMode.value
                                ? Colors.black
                                : Colors.white,
                            fontSize: controller.fontSize.value,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          FlutterShare.share(
                            title: 'Share App',
                            text: 'Share App',
                            linkUrl: 'https://play.google.com/store/apps',
                            chooserTitle: 'Share App',
                          );
                        },
                        leading: Icon(
                          Icons.share,
                          color: controller.isDarkMode.value
                              ? Colors.black
                              : Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Share App',
                          style: TextStyle(
                            color: controller.isDarkMode.value
                                ? Colors.black
                                : Colors.white,
                            fontSize: controller.fontSize.value,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.star,
                          color: controller.isDarkMode.value
                              ? Colors.black
                              : Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Rate App',
                          style: TextStyle(
                            color: controller.isDarkMode.value
                                ? Colors.black
                                : Colors.white,
                            fontSize: controller.fontSize.value,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.logout,
                          color: controller.isDarkMode.value
                              ? Colors.black
                              : Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                            color: controller.isDarkMode.value
                                ? Colors.black
                                : Colors.white,
                            fontSize: controller.fontSize.value,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          );
        });
  }

  Widget changeThemePopupDialog(BuildContext context) {
    return GetBuilder<WordDataController>(
        init: WordDataController(),
        builder: (controller) {
          return AlertDialog(
            backgroundColor:
                controller.isDarkMode.value ? Colors.white : bgColor,
            title: Text(
              'Change Theme',
              style: TextStyle(
                color:
                    controller.isDarkMode.value ? Colors.black : Colors.white,
                fontSize: controller.fontSize.value,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    controller.isDarkMode.value == true
                        ? controller.toggleDarkMode()
                        : null;
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.lightbulb_outline,
                    color: controller.isDarkMode.value
                        ? Colors.black
                        : Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(
                      color: controller.isDarkMode.value
                          ? Colors.black
                          : Colors.white,
                      fontSize: controller.fontSize.value,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    controller.isDarkMode.value == false
                        ? controller.toggleDarkMode()
                        : null;
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.lightbulb_outline,
                    color: controller.isDarkMode.value
                        ? Colors.black
                        : Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    'Light Mode',
                    style: TextStyle(
                      color: controller.isDarkMode.value
                          ? Colors.black
                          : Colors.white,
                      fontSize: controller.fontSize.value,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
