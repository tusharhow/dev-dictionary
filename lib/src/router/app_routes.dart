import 'package:dev_dictionary/src/components/animation/slide_transition.dart';
import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:dev_dictionary/src/router/app_route_constants.dart';
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
        path: AppRouteConstants.homeRouteName,
        builder: (BuildContext context, GoRouterState state) {
          return Responsive(
            mobile: MobileView(),
            desktop: DesktopView(),
            tablet: const TabletView(),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRouteConstants.aboutRouteName,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const AboutUsScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return slideTransition(animation, child);
                },
              );
            },
          ),
          GoRoute(
            path: AppRouteConstants.settingsRouteName,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: SettingsScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return slideTransition(animation, child);
                },
              );
            },
          ),
          GoRoute(
            path: AppRouteConstants.bookmarksRouteName,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: BookMarkScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return slideTransition(animation, child);
                },
              );
            },
          ),
          GoRoute(
            path: AppRouteConstants.contactUsRouteName,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const ContactUsScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return slideTransition(animation, child);
                },
              );
            },
          ),
          GoRoute(
            path: AppRouteConstants.contributionRouteName,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const ContributorsScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return slideTransition(animation, child);
                },
              );
            },
          ),
          GoRoute(
            path: '${AppRouteConstants.detailsRouteName}/:en',
            pageBuilder: (BuildContext context, GoRouterState state) {
              final en = state.pathParameters['en'];

              return CustomTransitionPage(
                key: state.pageKey,
                child: FutureBuilder<Word>(
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
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return slideTransition(animation, child);
                },
              );
            },
          ),
          GoRoute(
            path:
                '${AppRouteConstants.pageRouteName}/:${AppRouteConstants.pageRouteName}',
            pageBuilder: (BuildContext context, GoRouterState state) {
              final page = state.pathParameters['page'];
              return CustomTransitionPage(
                key: state.pageKey,
                child: Responsive(
                  mobile: MobileView(),
                  desktop: DesktopView(),
                  tablet: const TabletView(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return slideTransition(animation, child);
                },
              );
            },
          ),
        ])
  ]);
}
