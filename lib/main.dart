import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/src/controllers/theme_controller.dart';
import 'package:dev_dictionary/src/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  final ThemeController themeController = ThemeController();

  runApp(MyApp(
    themeController: themeController,
    router: MyRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.themeController, required this.router})
      : super(key: key);
  final ThemeController themeController;
  final MyRouter router;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.router.routeInformationParser,
      routeInformationProvider: router.router.routeInformationProvider,
      routerDelegate: router.router.routerDelegate,
      title: AppConstants.appName,
      theme: themeController.isDarkMode.value
          ? ThemeData(
              useMaterial3: true,
            )
          : ThemeData(
              useMaterial3: true,
            ),
      themeMode:
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
