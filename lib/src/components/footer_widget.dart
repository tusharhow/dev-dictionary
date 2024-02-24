import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/src/router/app_route_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Center(
                  child: Text(
                    'ডেভ',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Borno',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'ডিকশনারি',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontFamily: 'Borno',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * 4),
            child: Text(
              'Dev Dictionary: Your ultimate online Bengali dictionary for developers, offering a comprehensive collection\nof programming and tech terms in Bengali.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          const Text(AppConstants.footerText,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              )),
          const SizedBox(height: 5),
          Text.rich(
            TextSpan(
              text: 'Developed by ',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              children: [
                TextSpan(
                    text: 'Tushar Mahmud',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launchUrl(
                          Uri.parse('https://www.facebook.com/tusharhow'))),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text.rich(
            TextSpan(
              text: 'Contributors: ',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: 'See all contributors',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => context
                        .go('/${AppRouteConstants.contributionRouteName}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
