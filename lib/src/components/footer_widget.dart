import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220,
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
          const Text(
            'Dev Dictionary is a free online dictionary for developers',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text('Copyright © 2024 by Dev Dictionary',
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
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launchUrl(
                          Uri.parse('https://www.facebook.com/tusharhow'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
