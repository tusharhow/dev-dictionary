import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:dev_dictionary/src/views/about/about_us.dart';
import 'package:dev_dictionary/src/views/about/contact_us.dart';
import 'package:dev_dictionary/src/views/bookmark/bookmark_screen.dart';
import 'package:dev_dictionary/src/views/contrbution/contribution_screen.dart';
import 'package:dev_dictionary/src/views/detail/details_screen.dart';
import 'package:dev_dictionary/src/views/devices/desktop_view.dart';
import 'package:dev_dictionary/src/views/devices/mobile_view.dart';
import 'package:dev_dictionary/src/views/devices/tablet_view.dart';
import 'package:dev_dictionary/src/views/responsive/responsive.dart';
import 'package:dev_dictionary/src/views/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  final GoRouter router = GoRouter(routes: [
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return Responsive(
            mobile: MobileView(),
            desktop: DesktopView(),
            tablet: TabletView(),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'about',
            builder: (BuildContext context, GoRouterState state) {
              return const AboutUsScreen();
            },
          ),
          GoRoute(
            path: 'settings',
            builder: (BuildContext context, GoRouterState state) {
              return SettingsScreen();
            },
          ),
          GoRoute(
            path: 'bookmarks',
            builder: (BuildContext context, GoRouterState state) {
              return BookMarkScreen();
            },
          ),
          GoRoute(
            path: 'contact',
            builder: (BuildContext context, GoRouterState state) {
              return const ContactUsScreen();
            },
          ),
          GoRoute(
            path: 'contribution',
            builder: (BuildContext context, GoRouterState state) {
              return const ContributorsScreen();
            },
          ),
          GoRoute(
            path: 'details/:en',
            builder: (BuildContext context, GoRouterState state) {
              final en = state.pathParameters['en'];

              return FutureBuilder<Word>(
                future: WordDataController().getWordByEn(en!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final word = snapshot.data!;
                    return DetailsScreen(word: word);
                  } else {
                    return const Text('No word found');
                  }
                },
              );
            },
          ),
          GoRoute(
            path: 'page/:page',
            builder: (BuildContext context, GoRouterState state) {
              final page = state.pathParameters['page'];
              return Responsive(
                mobile: MobileView(),
                desktop: DesktopView(),
                tablet: const TabletView(),
              );
            },
          ),
        ])
  ]);
}
