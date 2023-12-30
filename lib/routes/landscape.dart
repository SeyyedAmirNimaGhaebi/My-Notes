import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/settings_controller.dart';

class LandScape extends StatelessWidget {
  const LandScape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: settingsController.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: Get.width * 0.25,
                height: Get.width * 0.25,
                child: Lottie.asset('assets/images/warning.json'),
              ),
            ),
            Center(
              child: Text(
                "Please return your phone to portrait mode",
                style: TextStyle(fontSize: Get.height * 0.09),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
