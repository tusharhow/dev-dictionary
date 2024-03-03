import 'package:dev_dictionary/src/controllers/bottom_nav_bar_controller.dart';
import 'package:dev_dictionary/src/views/bookmark/bookmark_screen.dart';
import 'package:dev_dictionary/src/views/devices/mobile_view.dart';
import 'package:dev_dictionary/src/views/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});
  final List<Widget> pages = [
   const MobileView(),
 const   BookMarkScreen(),
 const   SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavbarController>(
        builder: (context, tabModel, child) {
          return pages[tabModel.currentIndex];
        },
      ),
      bottomNavigationBar: Consumer<BottomNavbarController>(
        builder: (context, tabModel, child) {
          return BottomNavigationBar(
            currentIndex: tabModel.currentIndex,
            onTap: (index) {
              tabModel.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'Bookmarks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Contributors',
              ),
            ],
          );
        },
      ),
    );
  }
}
