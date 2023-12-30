import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/widgets/sheet_button.dart';

import '../controllers/settings_controller.dart';

class BottomSheetDialog {
  String? title;
  String? message;
  VoidCallback onOK;
  VoidCallback onCancel;
  String? buttonText;
  Widget? builder;
  double? size;

  BottomSheetDialog({
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onOK,
    required this.onCancel,
    required this.builder,
    this.size,
  });

  void showButtonSheetC(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    Get.bottomSheet(
      SizedBox(
        height: size,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 7,
            ),
            Container(
              width: 35,
              height: 5,
              decoration: BoxDecoration(
                color: settingsController.themeColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Text(title!, style: const TextStyle(fontSize: 20)),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message!, style: const TextStyle(fontSize: 16),textAlign: TextAlign.center,),
            ),
            builder!,
            const Expanded(
              child: Text(''),
            ),
            SheetButton(
              text: buttonText,
              onTap: () {
                onOK();
              },
              onCancel: () => onCancel,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: settingsController.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}
