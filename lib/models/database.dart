import 'package:hive_flutter/adapters.dart';

part 'database.g.dart';

@HiveType(typeId: 1)
class ToDos extends HiveObject {
  @HiveField(0)
  int? priority;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3, defaultValue: false)
  bool? isCompleted;
  @HiveField(4, defaultValue: false)
  bool? isHistory;
  @HiveField(5)
  DateTime? createDate;
  @HiveField(6)
  DateTime? completionDate;
  @HiveField(7)
  bool? hide;
  @HiveField(8)
  String? category;

  ToDos({
    required this.priority,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.isHistory,
    required this.createDate,
    required this.completionDate,
    required this.hide,
    required this.category,
  });
}

@HiveType(typeId: 2)
class SettingsData extends HiveObject {
  @HiveField(0)
  bool isStarted;
  @HiveField(1)
  bool notification;
  @HiveField(2)
  String name;
  @HiveField(3)
  bool lock;
  @HiveField(4)
  String password;
  @HiveField(5)
  bool biometric;
  @HiveField(6)
  String language;
  @HiveField(7)
  String? firstDayOfWeek;
  @HiveField(8)
  int timeFormat;
  @HiveField(9)
  int dataFormat;
  @HiveField(10)
  int sortedTodo;
  @HiveField(11)
  bool hideCompletedTodo;

  SettingsData({
    required this.isStarted,
    required this.notification,
    required this.name,
    required this.password,
    required this.lock,
    required this.biometric,
    required this.language,
    required this.firstDayOfWeek,
    required this.timeFormat,
    required this.dataFormat,
    required this.sortedTodo,
    required this.hideCompletedTodo,
  });
}

@HiveType(typeId: 3)
class CategoryTodo extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? id;
  @HiveField(2)
  bool hide;
  @HiveField(3)
  bool lock;

  CategoryTodo({
    required this.name,
    required this.id,
    required this.hide,
    required this.lock,
  });
}

@HiveType(typeId: 4)
class NotificationSettings extends HiveObject {
  @HiveField(0)
  bool? isShowTitle;
  @HiveField(1)
  bool? isShowDescription;
  @HiveField(2)
  bool? silent;
  @HiveField(3)
  bool? hideAlarmIcon;
  @HiveField(4)
  int? snooze;
  @HiveField(5)
  int? taskReminderDefault;

  NotificationSettings({
    required this.isShowTitle,
    required this.isShowDescription,
    required this.silent,
    required this.hideAlarmIcon,
    required this.snooze,
    required this.taskReminderDefault,
  });
}
