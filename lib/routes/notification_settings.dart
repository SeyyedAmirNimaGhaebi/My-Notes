// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_notes/controllers/notification_settings_controller.dart';
import 'package:my_notes/main.dart';
import 'package:my_notes/routes/calendar_screen.dart';
import 'package:my_notes/widgets/listTileCustom.dart';
import 'package:my_notes/widgets/title.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controllers/settings_controller.dart';
import 'settings_screen.dart';

final settingsController = Get.find<SettingsController>();

class NotificationSettingsScreen extends StatelessWidget {
  NotificationSettingsScreen({super.key});

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _isAndroidPermissionGranted() async {
    await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        // ignore: unnecessary_statements
        false;
  }

  Future<void> _requestPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestNotificationsPermission();
  }

  Color color = settingsController.primaryColor!;
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
          'Notification Settings',
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
      body: GetBuilder<NotificationSettingsController>(
        builder: (controller) {
          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                onEnd: () {
                  controller.isShowTextDescription =
                      controller.isShowDescription == false ? true : false;
                  controller.update();
                },
                width: Get.width,
                height: controller.isShowDescription! ? 135 : 110,
                decoration: BoxDecoration(
                  color: settingsController.primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.all(13),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                          margin: const EdgeInsets.only(right: 8),
                          child: Center(
                            child: Image.asset(
                              'assets/images/note.png',
                              width: 17,
                              height: 17,
                            ),
                          ),
                        ),
                        const Text(
                          'My Notes ● Todo ● now ',
                          style: TextStyle(fontSize: 12.5),
                        ),
                        const Icon(
                          Icons.notifications_on_rounded,
                          size: 12,
                        ),
                        const Expanded(
                          child: Text(''),
                        ),
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: settingsController.backgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.keyboard_arrow_up),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 33, top: 5),
                      child: Row(
                        children: [
                          Text(
                            controller.isShowTitle! ? 'Go to the gym' : 'Reminder',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.isShowTextDescription == true ? false : true,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 33, top: 5),
                        child: Row(
                          children: [
                            Text(
                              'go to the gym in the morning 🌞',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 33, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Completed',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(0, 102, 139, 1),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Snooze',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(0, 102, 139, 1),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: settingsController.primaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        MyCheckBox(
                          value: controller.isShowTitle,
                          onTap: () {
                            controller.isShowTitle = controller.isShowTitle == true ? false : true;
                            controller.saveData();
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Title',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: settingsController.primaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        MyCheckBox(
                          value: controller.isShowDescription,
                          onTap: () {
                            controller.isShowDescription =
                                controller.isShowDescription == true ? false : true;
                            controller.isShowTextDescription = true;
                            controller.saveData();
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Description',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                from: 30,
                child: Container(
                  width: double.infinity,
                  color: color,
                  margin: const EdgeInsets.only(
                    top: 22,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      listTileCustom(
                        leading: Icons.music_off_outlined,
                        title: 'Silent',
                        trailing: Switch(
                          value: controller.silent!,
                          activeColor: settingsController.themeColor,
                          trackOutlineColor: MaterialStatePropertyAll(
                            settingsController.notification!
                                ? settingsController.themeColor!.withOpacity(0.1)
                                : Colors.grey,
                          ),
                          inactiveTrackColor: Colors.transparent,
                          thumbColor: MaterialStatePropertyAll(
                            settingsController.notification!
                                ? settingsController.themeColor
                                : Colors.grey,
                          ),
                          onChanged: (value) {
                            controller.silent = controller.silent == true ? false : true;
                            controller.saveData();
                          },
                        ),
                        isSwitch: true,
                        onTap: () {},
                        enable: true,
                      ),
                      line(),
                      listTileCustom(
                        leading: CupertinoIcons.alarm,
                        title: 'Hide alarm icon',
                        trailing: Switch(
                          value: controller.hideAlarmIcon!,
                          activeColor: settingsController.themeColor,
                          trackOutlineColor: MaterialStatePropertyAll(
                            settingsController.notification!
                                ? settingsController.themeColor!.withOpacity(0.1)
                                : Colors.grey,
                          ),
                          inactiveTrackColor: Colors.transparent,
                          thumbColor: MaterialStatePropertyAll(
                            settingsController.notification!
                                ? settingsController.themeColor
                                : Colors.grey,
                          ),
                          onChanged: (value) {
                            controller.hideAlarmIcon =
                                controller.hideAlarmIcon == true ? false : true;
                            controller.saveData();
                          },
                        ),
                        isSwitch: true,
                        onTap: () {},
                        enable: true,
                      ),
                      line(),
                      listTileCustom(
                        leading: BoxIcons.bx_alarm_snooze,
                        title: 'Snooze',
                        trailing: SizedBox(
                          width: 115,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${controller.snoozeValue} minutes',
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
                          showButtonSheetSnooze();
                        },
                        enable: true,
                      ),
                      line(),
                      listTileCustom(
                        leading: Icons.notifications_none_rounded,
                        title: 'Task reminder default',
                        trailing: SizedBox(
                          width: 180,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                controller.taskReminderDefaultValue == 0
                                    ? ''
                                    : '${controller.taskReminderDefaultValue} minutes before',
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
                          showButtonSheetReminderDefault();
                        },
                        enable: true,
                      ),
                      line(),
                      listTileCustom(
                        leading: BoxIcons.bx_mail_send,
                        title: 'Notification preview',
                        trailing: const Text(''),
                        isSwitch: false,
                        onTap: () async {
                          await _isAndroidPermissionGranted();
                          await _requestPermissions();

                          await zonedScheduleAlarmClockNotification(
                            duration: const Duration(seconds: 1),
                            title: 'Reminder',
                            message: 'go to the gym in the morning 🌞',
                            payload: 'test',
                            type: 'Todo',
                          );
                        },
                        enable: true,
                      ),
                      line(),
                      listTileCustom(
                        leading: Icons.question_mark,
                        title: 'Task reminder does not work',
                        trailing: const Text(''),
                        isSwitch: false,
                        onTap: () => showButtonSheetNotWork(),
                        enable: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showButtonSheetReminderDefault() {
    Get.bottomSheet(
      SizedBox(
        height: 250,
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
              height: 20,
            ),
            SizedBox(
                height: 200,
                child: GetBuilder<NotificationSettingsController>(
                  builder: (controller) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: RadioListTile(
                            title: const Text('Same with due date'),
                            value: 0,
                            groupValue: controller.taskReminderDefault,
                            onChanged: (value) {
                              controller.taskReminderDefault = value;
                              controller.saveData();
                              controller.converterTaskReminderDefault();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: RadioListTile(
                            title: const Text('5 minutes before'),
                            value: 1,
                            groupValue: controller.taskReminderDefault,
                            onChanged: (value) {
                              controller.taskReminderDefault = value;
                              controller.saveData();
                              controller.converterTaskReminderDefault();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: RadioListTile(
                            title: const Text('10 minutes before'),
                            value: 2,
                            groupValue: controller.taskReminderDefault,
                            onChanged: (value) {
                              controller.taskReminderDefault = value;
                              controller.saveData();
                              controller.converterTaskReminderDefault();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: RadioListTile(
                            title: const Text('15 minutes before'),
                            value: 3,
                            groupValue: controller.taskReminderDefault,
                            onChanged: (value) {
                              controller.taskReminderDefault = value;
                              controller.saveData();
                              controller.converterTaskReminderDefault();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: RadioListTile(
                            title: const Text('30 minutes before'),
                            value: 4,
                            groupValue: controller.taskReminderDefault,
                            onChanged: (value) {
                              controller.taskReminderDefault = value;
                              controller.taskReminderDefault = value;
                              controller.saveData();
                              controller.converterTaskReminderDefault();
                            },
                          ),
                        ),
                      ],
                    );
                  },
                )),
            const Expanded(
              child: Text(''),
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

  void showButtonSheetSnooze() {
    Get.bottomSheet(
      SizedBox(
        height: 220,
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
              height: 20,
            ),
            GetBuilder<NotificationSettingsController>(
              builder: (controller) {
                return Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: RadioListTile(
                        title: const Text('5 minutes before'),
                        value: 1,
                        groupValue: controller.snooze,
                        onChanged: (value) {
                          controller.snooze = value;
                          controller.saveData();
                          controller.converterTaskSnooze();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: RadioListTile(
                        title: const Text('10 minutes before'),
                        value: 2,
                        groupValue: controller.snooze,
                        onChanged: (value) {
                          controller.snooze = value;
                          controller.saveData();
                          controller.converterTaskSnooze();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: RadioListTile(
                        title: const Text('15 minutes before'),
                        value: 3,
                        groupValue: controller.snooze,
                        onChanged: (value) {
                          controller.snooze = value;
                          controller.saveData();
                          controller.converterTaskSnooze();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: RadioListTile(
                        title: const Text('30 minutes before'),
                        value: 4,
                        groupValue: controller.snooze,
                        onChanged: (value) {
                          controller.snooze = value;

                          controller.saveData();
                          controller.converterTaskSnooze();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            const Expanded(
              child: Text(''),
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

  void showButtonSheetNotWork() async {
    PermissionStatus status = await Permission.notification.status;
    Get.bottomSheet(
      SizedBox(
        height: status.isGranted ? 220 : 250,
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
              height: 20,
            ),
            mainTitle(title: 'Notification cannot pop-up', fontSize: SizeTitle.medium),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: Get.width - 16,
                  child: const Text(
                    'Reminder may be cleared from the background by the system. In order to notify you on time, please enable the ignore battery saving mode.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  '● Allow notification',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Expanded(child: Text('')),
                Visibility(
                  visible: status.isGranted,
                  child: const Icon(Icons.check),
                ),
                Visibility(
                  visible: status.isDenied,
                  child: GestureDetector(
                    onTap: (){
                      _isAndroidPermissionGranted();
                      _requestPermissions();
                      Get.back();
                    },
                    child: Container(
                      height: 25,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        border: Border.all(color: settingsController.themeColor!, width: 1),
                        color: settingsController.backgroundColor,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error,
                            color: settingsController.themeColor,
                            
                          ),
                          const Text('permission'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Visibility(
              visible: status.isDenied,
              child: SizedBox(
                width: Get.width - 16,
                child: const Text(
                  'Please allow notification access to be able to use app reminder',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: null,
                ),
              ),
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
