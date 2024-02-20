import 'package:dev_dictionary/src/views/devices/desktop_view.dart';
import 'package:dev_dictionary/src/views/devices/tablet_view.dart';
import 'package:dev_dictionary/src/views/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'src/views/devices/mobile_view.dart';

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dev Dictionary',
      theme: ThemeData.light(useMaterial3: true),
      home: Responsive(
        mobile: MobileView(),
        tablet: TabletView(),
        desktop: DesktopView(),
      ),
    );
  }
}
