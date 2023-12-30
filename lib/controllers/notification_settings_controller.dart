import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_notes/models/database.dart';
import '../constants.dart';

class NotificationSettingsController extends GetxController {
  //Todo: Notification
  bool? isShowTitle;
  bool? isShowDescription;
  bool? isShowTextDescription;
  bool? silent;
  bool? hideAlarmIcon;
  int? snooze;
  int? taskReminderDefault;
  int? taskReminderDefaultValue;
  int? snoozeValue;

  @override
  void onInit() {
    final box = Hive.box<NotificationSettings>(notificationBoxName);
    if (box.values.isEmpty) {
      box.add(
        NotificationSettings(
          isShowTitle: true,
          isShowDescription: true,
          silent: false,
          hideAlarmIcon: false,
          snooze: 1,
          taskReminderDefault: 1,
        ),
      );
    }
    final notificationSettings = box.values.toList()[0];

    isShowTitle = notificationSettings.isShowTitle;
    isShowDescription = notificationSettings.isShowDescription;
    silent = notificationSettings.silent;
    hideAlarmIcon = notificationSettings.hideAlarmIcon;
    snooze = notificationSettings.snooze;
    taskReminderDefault = notificationSettings.taskReminderDefault;
    isShowTextDescription = notificationSettings.isShowDescription ?? true ? false : true;
    converterTaskReminderDefault();
    converterTaskSnooze();

    super.onInit();
  }

  void saveData() {
    final box = Hive.box<NotificationSettings>(notificationBoxName);
    final notificationSettings = box.values.toList()[0];

    notificationSettings.isShowTitle = isShowTitle;
    notificationSettings.isShowDescription = isShowDescription;
    notificationSettings.silent = silent;
    notificationSettings.hideAlarmIcon = hideAlarmIcon;
    notificationSettings.snooze = snooze;
    notificationSettings.taskReminderDefault = taskReminderDefault;

    notificationSettings.save();
    update();
  }

  void converterTaskReminderDefault() {
    switch (taskReminderDefault) {
      case 0:
        taskReminderDefaultValue = 0;
        break;
      case 1:
        taskReminderDefaultValue = 5;
        break;
      case 2:
        taskReminderDefaultValue = 10;
        break;
      case 3:
        taskReminderDefaultValue = 15;
        break;
      case 4:
        taskReminderDefaultValue = 30;
        break;
    }
  }

  void converterTaskSnooze() {
    switch (snooze) {
      case 1:
        snoozeValue = 5;
        break;
      case 2:
        snoozeValue = 10;
        break;
      case 3:
        snoozeValue = 15;
        break;
      case 4:
        snoozeValue = 30;
        break;
    }
  }
}
