import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/routes/home.dart';

import '../controllers/settings_controller.dart';

List<ThemeApp> theme = [
  //Todo: Main
  ThemeApp(
    name: 'Light',
    backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
    primaryMain: const Color.fromRGBO(71, 114, 250, 1),
    primaryColor: const Color.fromRGBO(255, 255, 255, 1),
    imageUrl: 'assets/images/theme/light.png',
    isDark: false,
  ),
  ThemeApp(
    name: 'Light(Gold)',
    backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
    primaryMain: const Color.fromRGBO(255, 140, 0, 1),
    primaryColor: const Color.fromRGBO(255, 255, 255, 1),
    imageUrl: 'assets/images/theme/light(gold).png',
    isDark: false,
  ),
  ThemeApp(
    name: 'Dark',
    primaryMain: const Color.fromRGBO(71, 114, 250, 1),
    backgroundColor: const Color.fromRGBO(21, 30, 39, 1),
    primaryColor: const Color.fromRGBO(29, 39, 51, 1),
    imageUrl: 'assets/images/theme/dark.png',
    isDark: true,
  ),
  ThemeApp(
    name: 'Dark(Gold)',
    primaryMain: const Color.fromRGBO(255, 140, 0, 1),
    backgroundColor: const Color.fromRGBO(21, 30, 39, 1),
    primaryColor: const Color.fromRGBO(29, 39, 51, 1),
    imageUrl: 'assets/images/theme/dark(gold).png',
    isDark: true,
  ),
  ThemeApp(
    name: 'Night',
    primaryMain: const Color.fromRGBO(71, 114, 250, 1),
    backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
    primaryColor: const Color.fromRGBO(24, 24, 25, 1),
    imageUrl: 'assets/images/theme/night.png',
    isDark: true,
  ),
  ThemeApp(
    name: 'Night(Gold)',
    primaryMain: const Color.fromRGBO(255, 140, 0, 1),
    backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
    primaryColor: const Color.fromRGBO(24, 24, 25, 1),
    imageUrl: 'assets/images/theme/night(gold).png',
    isDark: true,
  ),
  //Todo: Colors
  ThemeApp(
    name: 'Yellow',
    primaryMain: const Color.fromRGBO(255, 162, 6, 1),
    backgroundColor: const Color.fromRGBO(255, 246, 229, 1),
    primaryColor: const Color.fromRGBO(255, 255, 255, 1),
    imageUrl: 'assets/images/theme/yellow.png',
    isDark: false,
  ),
  ThemeApp(
    name: 'Green',
    primaryMain: const Color.fromRGBO(12, 206, 156, 1),
    backgroundColor: const Color.fromRGBO(230, 250, 245, 1),
    primaryColor: const Color.fromRGBO(255, 255, 255, 1),
    imageUrl: 'assets/images/theme/green.png',
    isDark: false,
  ),
  ThemeApp(
    name: 'Blue',
    primaryMain: const Color.fromRGBO(71, 114, 250, 1),
    backgroundColor: const Color.fromRGBO(236, 241, 255, 1),
    primaryColor: const Color.fromRGBO(255, 255, 255, 1),
    imageUrl: 'assets/images/theme/blue.png',
    isDark: false,
  ),
  ThemeApp(
    name: 'Pink',
    primaryMain: const Color.fromRGBO(252, 120, 151, 1),
    backgroundColor: const Color.fromRGBO(255, 241, 244, 1),
    primaryColor: const Color.fromRGBO(255, 255, 255, 1),
    imageUrl: 'assets/images/theme/pink.png',
    isDark: false,
  ),
  ThemeApp(
    name: 'Grey',
    primaryMain: const Color.fromRGBO(125, 127, 132, 1),
    backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
    primaryColor: const Color.fromRGBO(255, 255, 255, 1),
    imageUrl: 'assets/images/theme/grey.png',
    isDark: false,
  ),
  ThemeApp(
    name: 'Black',
    primaryMain: const Color.fromRGBO(32, 37, 60, 1),
    backgroundColor: const Color.fromRGBO(221, 222, 221, 1),
    primaryColor: const Color.fromRGBO(255, 255, 255, 1),
    imageUrl: 'assets/images/theme/black.png',
    isDark: false,
  ),
  //Todo: Pro
  ThemeApp(
    name: 'Material You',
    primaryMain: const Color.fromRGBO(3, 28, 64, 1),
    backgroundColor: const Color.fromRGBO(229, 231, 235, 1),
    primaryColor: const Color.fromRGBO(255, 255, 255, 1),
    imageUrl: 'assets/images/theme/material_you.png',
    isDark: false,
  ),
];

class SelectThemeScreen extends StatelessWidget {
  const SelectThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (controller) {
        final pageViewController =
            PageController(viewportFraction: 0.8, initialPage: controller.currentIndex ?? 0);
        return Scaffold(
          backgroundColor: controller.backgroundColor,
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
            title: const Text(
              'Choose Your Diary Theme',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: controller.backgroundColor,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Text(
                  theme[controller.currentIndex ?? 0].name,
                  style: TextStyle(
                    fontSize: 22,
                    color: controller.isDark ? Colors.white : Colors.black,
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    itemCount: theme.length,
                    physics: const BouncingScrollPhysics(),
                    controller: pageViewController,
                    onPageChanged: (index) {
                      controller.changeIndex(index);
                      controller.changeTheme(
                        name: theme[index].name,
                        themeColor: theme[index].primaryMain,
                        primaryColor: theme[index].primaryColor,
                        backgroundColor: theme[index].backgroundColor,
                        isDark: theme[index].isDark,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(theme[index].imageUrl),
                            fit: BoxFit.fill,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: controller.themeColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: double.infinity,
                  height: 55,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          pageViewController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          color: controller.currentIndex == 0
                              ? controller.themeColor
                              : controller.primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (controller.isDark) {
                            Get.changeTheme(ThemeData.dark());
                            controller.isDark = true;
                          } else {
                            Get.changeTheme(ThemeData.light());
                            controller.isDark = false;
                          }

                          Get.offAll(Home());
                        },
                        child: Text(
                          'USE IT',
                          style: TextStyle(
                            color: controller.primaryColor,
                            fontFamily: 'Comic',
                            fontSize: 22,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          pageViewController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          color: controller.currentIndex == 12
                              ? controller.themeColor
                              : controller.primaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ThemeApp {
  String name;
  Color backgroundColor;
  Color primaryMain;
  Color primaryColor;
  String imageUrl;
  bool isDark;

  ThemeApp({
    required this.name,
    required this.backgroundColor,
    required this.primaryMain,
    required this.primaryColor,
    required this.imageUrl,
    required this.isDark,
  });
}
