import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/controllers/todos_controller.dart';

import '../controllers/settings_controller.dart';

// ignore: must_be_immutable
class SearchTextField extends StatelessWidget {
  String hintText;
  final VoidCallback onChange;
  final TextEditingController? controller;

  SearchTextField({
    required this.controller,
    required this.hintText,
    required this.onChange,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    return Container(
      margin: const EdgeInsets.only(left: 8, top: 10, bottom: 4),
      width: Get.width - 43,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: settingsController.isDark ? Colors.grey.shade800 : Colors.white,
        border: Border.all(
          color: settingsController.backgroundColor!,
          width: 1,
        ),
      ),
      child: Center(
        child: TextField(
          cursorColor: settingsController.themeColor,
          controller: controller,
          onChanged: (value) {
            onChange();
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: settingsController.isDark ? Colors.white60 : Colors.black54,
            ),
            suffixIcon: GetBuilder<Todos_Controller>(
              builder: (controllers) {
                return Visibility(
                  visible: controllers.searchController!.text.isNotEmpty,
                  child: InkWell(
                    onTap: () {
                      controllers.searchController!.clear();
                      controllers.update();
                    },
                    child: Icon(
                      Icons.close,
                      color: settingsController.isDark ? Colors.white60 : Colors.black54,
                    ),
                  ),
                );
              },
            ),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 15,
              color: settingsController.isDark ? Colors.white60 : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
