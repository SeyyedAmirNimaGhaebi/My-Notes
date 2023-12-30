import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

// ignore: must_be_immutable
class TextFieldC extends StatelessWidget {
  final TextEditingController? controller;
  String hintText;
  IconData? icon;

  TextFieldC({
    required this.controller,
    required this.hintText,
    required this.icon,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: settingsController.isDark ? Colors.grey.shade800 : Colors.white,
        border: Border.all(
          color: settingsController.backgroundColor!,
          width: 1,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: icon == null ? 10 : 0),
          child: TextField(
            cursorColor: settingsController.themeColor,
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: icon != null
                  ? Icon(
                      icon,
                      color: settingsController.isDark ? Colors.white60 : Colors.black54,
                    )
                  : null,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 15,
                color: settingsController.isDark ? Colors.white60 : Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
