import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../components/popup_widget.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final WordPropertyController wordPropertyController =
      Get.put(WordPropertyController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordDataController>(
        init: WordDataController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              backgroundColor: bgColor,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            body: GetBuilder<WordDataController>(
                init: WordDataController(),
                builder: (controller) {
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
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Change Font Size',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
                        leading: const Icon(
                          Icons.share,
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Share App',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Rate App',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
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
