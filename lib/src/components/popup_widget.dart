import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildPopupDialog(BuildContext context) {
  return Consumer<WordPropertyController>(
      builder: (context, controller, child) {
    return AlertDialog(
      title: const Text('Change Font Size'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Slider(
                value: controller.fontSize,
                onChanged: (value) {
                  controller.changeFontSize(value);
                },
                min: 10,
                max: 40,
              ),
              Text(controller.fontSize.toStringAsFixed(0))
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
              controller.changeFontSize(controller.fontSize);
              Navigator.pop(context);
            },
            child: const Text('Ok')),
      ],
    );
  });
}
