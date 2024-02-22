import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:dev_dictionary/src/views/detail/desktop_details_page.dart';
import 'package:dev_dictionary/src/views/detail/detail_screen.dart';
import 'package:dev_dictionary/src/views/responsive/responsive.dart';

import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.word});
  final Word word;
  
  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return BigScreenDetailsPage(word: word,);
    } else if (Responsive.isTablet(context)) {
      return BigScreenDetailsPage(word: word, );
    } else {
      return MobileDetailsScreen(word: word);
    }
  }
}
