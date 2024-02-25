import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/src/controllers/bookmark_controller.dart';
import 'package:dev_dictionary/src/controllers/contributor_controller.dart';
import 'package:dev_dictionary/src/controllers/theme_controller.dart';
import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:dev_dictionary/src/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeController()),
        ChangeNotifierProvider(create: (context) => WordDataController()),
        ChangeNotifierProvider(create: (context) => WordPropertyController()),
        ChangeNotifierProvider(create: (context) => BookmarkController()),
        ChangeNotifierProvider(create: (context) => ContributorController()),
      ],
      child: MyApp(
        router: MyRouter(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.router}) : super(key: key);

  final MyRouter router;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(builder: (cx, themeController, cd) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: router.router.routeInformationParser,
        routeInformationProvider: router.router.routeInformationProvider,
        routerDelegate: router.router.routerDelegate,
        title: AppConstants.appName,
        theme:
            themeController.isDarkMode ? ThemeData.dark() : ThemeData.light(),
        themeMode:
            themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      );
    });
  }
}
