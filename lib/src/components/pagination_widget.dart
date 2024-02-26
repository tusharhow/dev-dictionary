import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({
    super.key,
    required this.wordController,
  });
  final WordDataController wordController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: wordController.currentPage <
              (wordController.wordData.length / wordController.itemsPerPage)
                  .ceil()
          ? () {
              wordController.nextPage(context);
            }
          : () {
              wordController.previousPage(context);
            },
      child: Text(wordController.currentPage <
              (wordController.wordData.length / wordController.itemsPerPage)
                  .ceil()
          ? 'Load More'
          : 'Previous Page'),
    );
  }
}
