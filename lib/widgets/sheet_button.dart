import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/models/translator.dart';

import '../routes/home.dart';


double _widthSize = 0.0;

// ignore: must_be_immutable
class SheetButton extends StatelessWidget {
  final text;
  VoidCallback onTap;
  VoidCallback onCancel;

  SheetButton(
      {required this.text,
      required this.onTap,
      required this.onCancel,
      super.key});

  @override
  Widget build(BuildContext context) {
    _widthSize = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            onCancel();
            Get.back();
          },
          child: Container(
            width: _widthSize / 3 - 13,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: settingsController.isDark
                  ? Colors.black
                  : Colors.white,
            ),
            child: Center(
              child: Text(Translator.addNoteText6.tr,
                  style: const TextStyle(fontSize: 17)),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            width: _widthSize / 3 * 2 - 13,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: settingsController.themeColor,
            ),
            child: Center(
              child: Text(text, style: const TextStyle(fontSize: 17,color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
