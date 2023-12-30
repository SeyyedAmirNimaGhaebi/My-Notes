import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_notes/controllers/nvigation_bar_controller.dart';
import 'package:my_notes/models/translator.dart';
import 'package:my_notes/routes/calendar_screen.dart';
import 'package:my_notes/routes/notes_screen.dart';
import 'package:my_notes/routes/settings_screen.dart';
import 'package:my_notes/routes/todos_screen.dart';

import '../controllers/settings_controller.dart';

List<Widget> bottomTabs = <Widget>[
  NotesScreen(),
  ToDosScreen(),
  CalenderScreen(),
  SettingsScreen(),
];

final settingsController = Get.find<SettingsController>();

// ignore: must_be_immutable
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: bottomTabs.elementAt(Get.find<NavigationBarController>().index.value),
        bottomNavigationBar: Container(
          color: settingsController.isDark
              ? const Color.fromRGBO(15, 15, 15, 1)
              : const Color.fromRGBO(233, 233, 233, 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 6.0,
            ),
            child: GNav(
              backgroundColor: settingsController.isDark
                  ? const Color.fromRGBO(15, 15, 15, 1)
                  : const Color.fromRGBO(233, 233, 233, 1),
              color: settingsController.isDark ? Colors.white70 : Colors.grey.shade700,
              activeColor: settingsController.themeColor,
              tabBackgroundColor: settingsController.isDark
                  ? const Color.fromRGBO(30, 30, 30, 1)
                  : const Color.fromRGBO(242, 242, 242, 1),
              gap: 4,
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 14.0,
              ),
              tabs: [
                GButton(
                  icon: Iconsax.note,
                  text: Translator.tabNotes.tr,
                ),
                GButton(
                  icon: Icons.check,
                  text: Translator.tabTodos.tr,
                ),
                const GButton(
                  icon: Iconsax.calendar,
                  text: "Calender",
                ),
                GButton(
                  icon: Icons.settings,
                  text: Translator.tabSettings.tr,
                ),
              ],
              selectedIndex: Get.find<NavigationBarController>().index.value,
              onTabChange: (index) {
                Get.find<NavigationBarController>().index.value = index;
              },
            ),
          ),
        ),
      );
    });
  }
}
