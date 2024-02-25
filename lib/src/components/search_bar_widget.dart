import 'package:dev_dictionary/src/views/responsive/responsive.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../controllers/word_data_controller.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key,
    required this.textEditingController,
    required this.controller,
  }) : super(key: key);
  final TextEditingController textEditingController;
  final WordDataController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Card(
        elevation: 2,
        child: SizedBox(
          height: 60,
          width: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width / 3
              : Responsive.isTablet(context)
                  ? MediaQuery.of(context).size.width / 1.5
                  : MediaQuery.of(context).size.width,
          child: TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.deepPurple.shade100,
              hintText: 'শব্দের অর্থ খুঁজুন...',
              hintStyle: const TextStyle(
                color: Colors.black54,
                fontFamily: 'Borno',
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: textEditingController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        controller.clearSearchResults();
                      },
                    )
                  : null,
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                controller.searchData(value);
              } else {
                controller.clearSearchResults();
              }
            },
            onEditingComplete: () {
              if (textEditingController.text.isNotEmpty) {
                controller.searchData(textEditingController.text);
              } else {
                controller.clearSearchResults();
              }
            },
            onFieldSubmitted: (value) {
              if (textEditingController.text.isNotEmpty) {
                controller.searchData(textEditingController.text);
              } else {
                controller.clearSearchResults();
              }
            },
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
