// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_notes/controllers/settings_controller.dart';

final settingsController = Get.find<SettingsController>();

class TextFieldPassword extends StatelessWidget {
  final TextEditingController? textController;
  String hintText;
  int hidePin;

  TextFieldPassword(
      {required this.hintText, required this.textController, required this.hidePin, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 13),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: settingsController.isDark ? Colors.grey.shade800 : Colors.white,
            border: Border.all(
              color: controller.backgroundColor!,
              width: 1,
            ),
          ),
          child: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(8),
            ],
            onChanged: (value) {
              controller.error1 = false;
              controller.error2 = false;
              controller.error3 = false;
              controller.update();
            },
            controller: textController,
            obscureText: hidePin == 0
                ? controller.isShowPassword
                : hidePin == 1
                    ? controller.isShowPassword1
                    : controller.isShowPassword2,
            cursorColor: controller.themeColor,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Iconsax.lock,
                color: Colors.black54,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  hidePin == 0
                      ? controller.isShowPassword = !controller.isShowPassword
                      : hidePin == 1
                          ? controller.isShowPassword1 = !controller.isShowPassword1
                          : controller.isShowPassword2 = !controller.isShowPassword2;

                  controller.suffixIcon =
                      controller.isShowPassword ? Icons.visibility : Icons.visibility_off;
                  controller.suffixIcon1 =
                      controller.isShowPassword1 ? Icons.visibility : Icons.visibility_off;

                  controller.suffixIcon2 =
                      controller.isShowPassword2 ? Icons.visibility : Icons.visibility_off;

                  controller.update();
                },
                child: Icon(
                  hidePin == 0 ? controller.suffixIcon : hidePin == 1 ? controller.suffixIcon1 : controller.suffixIcon2,
                  color: Colors.black54,
                ),
              ),
              border: InputBorder.none,
              hintText: hintText,
            ),
          ),
        );
      },
    );
  }
}
