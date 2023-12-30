import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/models/translator.dart';
import 'package:my_notes/routes/achive_screen.dart';
import 'package:my_notes/routes/calendar_screen.dart';
import 'package:my_notes/routes/faq_screen.dart';
import 'package:my_notes/routes/landscape.dart';
import 'package:my_notes/routes/lock_screen.dart';
import 'package:my_notes/routes/notification_settings.dart';
import 'package:my_notes/routes/select_theme_screen.dart';
import 'package:my_notes/routes/trash_screen.dart';
import 'package:my_notes/widgets/bottom_sheet_dialog.dart';
import 'package:my_notes/widgets/listTileCustom.dart';
import 'package:my_notes/widgets/select_language.dart';
import 'package:icons_plus/icons_plus.dart';

import '../controllers/settings_controller.dart';
import '../widgets/title.dart';

final settingsController = Get.find<SettingsController>();
double _widthSize = 0.0;

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  bool? getLock;
  SettingsScreen({this.getLock, super.key});

  @override
  Widget build(BuildContext context) {
    Color color = settingsController.primaryColor!;
    _widthSize = MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (getLock != null) {
        Get.to(const LockScreen());
      }
    });
    return Scaffold(
      backgroundColor: settingsController.backgroundColor,
      appBar: getLock != null
          ? AppBar(
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
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: settingsController.isDark ? Colors.white : Colors.black,
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: settingsController.backgroundColor,
            )
          : null,
      body: GetBuilder<SettingsController>(
        builder: (controller) {
          return MediaQuery.of(context).orientation == Orientation.portrait
              ? SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                       FadeInUp(
                          delay: const Duration(milliseconds: 100),
                          duration: const Duration(milliseconds: 700),
                          child: Container(
                            width: double.infinity,
                            color: color,
                            margin: const EdgeInsets.only(
                              top: 15,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                mainTitle(
                                  title: 'Notification',
                                  fontSize: SizeTitle.medium,
                                  textColor: controller.themeColor,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                listTileCustom(
                                  leading: Iconsax.notification,
                                  title: 'Notification reminder',
                                  trailing: Switch(
                                    value: controller.notification!,
                                    activeColor: controller.themeColor,
                                    trackOutlineColor: MaterialStatePropertyAll(
                                      controller.notification!
                                          ? controller.themeColor!.withOpacity(0.1)
                                          : Colors.grey,
                                    ),
                                    inactiveTrackColor: Colors.transparent,
                                    thumbColor: MaterialStatePropertyAll(
                                      controller.notification!
                                          ? controller.themeColor
                                          : Colors.grey,
                                    ),
                                    onChanged: (value) {
                                      controller.notification = value;
                                      controller.saveData();
                                    },
                                  ),
                                  isSwitch: true,
                                  onTap: () {},
                                  enable: true,
                                ),
                                line(),
                                listTileCustom(
                                  leading: Iconsax.notification_bing,
                                  title: 'Notification settings',
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  isSwitch: false,
                                  onTap: () {
                                    Get.to(
                                      NotificationSettingsScreen(),
                                      transition: Transition.leftToRight,
                                    );
                                  },
                                  enable: controller.notification!,
                                ),
                              ],
                            ),
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 700),
                          child: Container(
                            width: double.infinity,
                            color: color,
                            margin: const EdgeInsets.only(
                              top: 15,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                mainTitle(
                                  title: 'General',
                                  fontSize: SizeTitle.medium,
                                  textColor: controller.themeColor,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                listTileCustom(
                                  leading: Icons.dark_mode,
                                  title: 'Theme',
                                  trailing: SizedBox(
                                    width: 90,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          controller.name!,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                  isSwitch: false,
                                  onTap: () {
                                    Get.to(const SelectThemeScreen(),
                                        transition: Transition.rightToLeft);
                                  },
                                  enable: true,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                line(),
                                listTileCustom(
                                  leading: Iconsax.lock,
                                  title: Translator.settingsText5.tr,
                                  trailing: const SizedBox(
                                    width: 60,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'None',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                  isSwitch: false,
                                  onTap: () {
                                    Get.to(
                                      const LockScreen(),
                                      transition: Transition.leftToRight,
                                    );
                                  },
                                  enable: true,
                                ),
                                line(),
                                listTileCustom(
                                  leading: HeroIcons.language,
                                  title: Translator.settingsText7.tr,
                                  trailing: SizedBox(
                                    width: 70,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          controller.language!,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                  isSwitch: false,
                                  onTap: () {
                                    BottomSheetDialog bottomSheetDialog = BottomSheetDialog(
                                      title: Translator.settingsText16.tr,
                                      message: '',
                                      buttonText: Translator.settingsText13.tr,
                                      onOK: () {
                                        controller.language =
                                            language == 'فارسی' ? 'فارسی' : 'English';
                                        print(language == 'فارسی' ? 'فارسی' : 'English');
                                        if (controller.language == 'English') {
                                          Get.updateLocale(const Locale('en', 'US'));
                                        } else {
                                          Get.updateLocale(const Locale('fa', 'IR'));
                                        }
                                        controller.saveData();
                                        Get.back();
                                      },
                                      onCancel: () {},
                                      builder: SelectLanguage(
                                        height: 74,
                                        text1: 'English',
                                        text2: 'فارسی',
                                        borderColor: controller.themeColor!,
                                      ),
                                      size: 250,
                                    );
                                    bottomSheetDialog.showButtonSheetC(context);
                                  },
                                  enable: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 700),
                          child: Container(
                            width: double.infinity,
                            color: color,
                            margin: const EdgeInsets.only(
                              top: 15,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                mainTitle(
                                  title: 'Date & Time',
                                  fontSize: SizeTitle.medium,
                                  textColor: controller.themeColor,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                listTileCustom(
                                  leading: Icons.calendar_month,
                                  title: 'First day of week',
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  isSwitch: false,
                                  onTap: () => Get.to(const TrashScreen()),
                                  enable: true,
                                ),
                                line(),
                                listTileCustom(
                                  leading: Icons.access_time,
                                  title: 'Time format',
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  isSwitch: false,
                                  onTap: () => Get.to(const ArchiveScreen()),
                                  enable: true,
                                ),
                                line(),
                                listTileCustom(
                                  leading: Icons.date_range,
                                  title: 'Date format',
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  isSwitch: false,
                                  onTap: () => Get.to(const ArchiveScreen()),
                                  enable: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          duration: const Duration(milliseconds: 700),
                          child: Container(
                            width: double.infinity,
                            color: color,
                            margin: const EdgeInsets.only(
                              top: 15,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                mainTitle(
                                  title: 'Folders',
                                  fontSize: SizeTitle.medium,
                                  textColor: controller.themeColor,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                listTileCustom(
                                  leading: CupertinoIcons.trash,
                                  title: Translator.settingsText8.tr,
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  isSwitch: false,
                                  onTap: () => Get.to(const TrashScreen()),
                                  enable: true,
                                ),
                                line(),
                                listTileCustom(
                                  leading: Bootstrap.archive,
                                  title: Translator.settingsText9.tr,
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  isSwitch: false,
                                  onTap: () => Get.to(const ArchiveScreen()),
                                  enable: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 100),
                          duration: const Duration(milliseconds: 700),
                          child: Container(
                            width: double.infinity,
                            color: color,
                            margin: const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                mainTitle(
                                  title: 'About',
                                  fontSize: SizeTitle.medium,
                                  textColor: controller.themeColor,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                listTileCustom(
                                  leading: Iconsax.information,
                                  title: 'Permissions and Access',
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  isSwitch: false,
                                  onTap: () {
                                    Get.to(
                                      const FAQScreen(),
                                      transition: Transition.leftToRight,
                                    );
                                  },
                                  enable: true,
                                ),
                                line(),
                                listTileCustom(
                                  leading: Iconsax.info_circle,
                                  title: 'FAQ',
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  isSwitch: false,
                                  onTap: () {
                                    Get.to(
                                      const FAQScreen(),
                                      transition: Transition.leftToRight,
                                    );
                                  },
                                  enable: true,
                                ),
                                line(),
                                listTileCustom(
                                  leading: BoxIcons.bx_support,
                                  title: 'Report bugs & support',
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  isSwitch: false,
                                  onTap: () {
                                    Get.to(
                                      CalenderScreen(),
                                      transition: Transition.leftToRight,
                                    );
                                  },
                                  enable: true,
                                ),
                                line(),
                                listTileCustom(
                                  leading: Iconsax.android,
                                  title: '${Translator.settingsText10.tr} : 1.0.0',
                                  trailing: const Text(''),
                                  isSwitch: false,
                                  onTap: () {},
                                  enable: true,
                                ),
                                line(),
                                listTileCustom(
                                  leading: BoxIcons.bx_exit,
                                  title: Translator.settingsText11.tr,
                                  trailing: const Text(''),
                                  isSwitch: false,
                                  onTap: () {
                                    BottomSheetDialog bottomSheetDialog = BottomSheetDialog(
                                      title: Translator.settingsText17.tr,
                                      message: Translator.settingsText18.tr,
                                      buttonText: Translator.settingsText19.tr,
                                      onOK: () {
                                        Get.back();
                                        exit(0);
                                      },
                                      onCancel: () {},
                                      builder: const Text(''),
                                      size: 200,
                                    );
                                    bottomSheetDialog.showButtonSheetC(context);
                                  },
                                  enable: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const LandScape();
        },
      ),
    );
  }
}

Widget line() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: settingsController.isDark ? Colors.black : Colors.grey,
    height: 0.5,
    width: _widthSize - 30,
  );
}
