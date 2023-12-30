import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

final settingsController = Get.find<SettingsController>();

class TrashScreen extends StatelessWidget {
  const TrashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settingsController.backgroundColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            CupertinoIcons.back,
            size: 30,
            color: settingsController.isDark ? Colors.white : Colors.black,
          ),
        ),
        foregroundColor: settingsController.isDark ? Colors.white : Colors.black,
        title: Text(
          'Trash',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: settingsController.isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsController.backgroundColor,
      ),
    );
  }
}
