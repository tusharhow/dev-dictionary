import 'package:flutter/material.dart';

import '../../constants.dart';
import '../controllers/word_data.dart';

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
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
            filled: true,
            fillColor: bgColor2,
            hintText: 'কিছু লিখুন...',
            hintStyle: const TextStyle(color: Colors.white54),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            suffixIcon: textEditingController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.white54),
                    onPressed: () {
                      controller.searchData('');
                      textEditingController.clear();
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              controller.searchData(value);
            } else {
              controller.searchData('');
            }
          },
          onEditingComplete: () {
            if (textEditingController.text.isNotEmpty) {
              controller.searchData(textEditingController.text);
            } else {
              controller.searchData('');
            }
          },
          onFieldSubmitted: (value) {
            if (textEditingController.text.isNotEmpty) {
              controller.searchData(textEditingController.text);
            } else {
              controller.searchData('');
            }
          },
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
