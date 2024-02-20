import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildPopupDialog(BuildContext context) {
  return GetBuilder<WordPropertyController>(
      init: WordPropertyController(),
      builder: (controller) {
        return AlertDialog(
          title: const Text('Change Font Size'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Font Size: ${controller.fontSize.value.round()}',
                style: GoogleFonts.roboto(
                  fontSize: controller.fontSize.value,
                ),
              ),
              Slider(
                min: 10,
                max: 28,
                value: controller.fontSize.value,
                onChanged: (value) {
                  controller.changeFontSize(value);
                  controller.update();
                },
                label: controller.fontSize.value.round().toString(),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ],
        );
      });
}
