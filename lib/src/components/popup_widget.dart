import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildPopupDialog(BuildContext context) {
  return GetBuilder<WordPropertyController>(
      init: WordPropertyController(),
      builder: (controller) {
        return AlertDialog(
          title: const Text('Change Font Size'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Obx(() => Slider(
                        value: controller.fontSize.value,
                        onChanged: (value) {
                          controller.changeFontSize(value);
                        },
                        min: 10,
                        max: 40,
                      )),
                  Obx(() => Text(controller.fontSize.value
                      .toStringAsFixed(0))),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  controller
                      .changeFontSize(controller.fontSize.value);
                  Navigator.pop(context);
                },
                child: const Text('Ok')),
          ],
        );
      });
}
