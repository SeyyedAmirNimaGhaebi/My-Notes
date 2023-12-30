import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_notes/constants.dart';
import 'package:my_notes/models/database.dart';

import '../routes/select_theme_screen.dart';

class SettingsController extends GetxController {
  int activeIndex = 0;
  //Todo: Settings Data
  bool? isStarted;
  bool? notification;
  String? name;
  Color? themeColor;
  Color? primaryColor;
  Color? backgroundColor;
  String? imageUrl;
  bool isDark = false;
  String? language;
  String? firstDayOfWeek;
  int? timeFormat;
  int? dataFormat;
  int? currentIndex;

  //Todo: Lock
  String? password;
  bool? biometric;
  bool isShowPassword = true;
  bool isShowPassword1 = true;
  bool isShowPassword2 = true;
  IconData suffixIcon = Icons.visibility_off;
  IconData suffixIcon1 = Icons.visibility_off;
  IconData suffixIcon2 = Icons.visibility_off;
  bool error0 = false;
  bool error1 = false;
  bool error2 = false;
  bool error3 = false;

  TextEditingController? changePasswordController;
  TextEditingController? passwordController;
  TextEditingController? passwordController2;

  //Todo: Todo Menu
  int? sortedTodo;
  bool? hideCompleted;

  @override
  void onInit() {
    final box = Hive.box<SettingsData>(settingsBoxName);
    if (box.values.isEmpty) {
      box.add(
        SettingsData(
          isStarted: false,
          notification: true,
          name: 'Light',
          lock: false,
          password: '0',
          biometric: false,
          language: 'English',
          firstDayOfWeek: 'Monday',
          timeFormat: 0,
          dataFormat: 0,
          sortedTodo: 0,
          hideCompletedTodo: false,
        ),
      );
    }
    final settings = box.values.toList()[0];
    final themeApp = theme.firstWhere((theme) => theme.name == settings.name);

    isStarted = settings.isStarted;
    notification = settings.notification;
    name = themeApp.name;
    themeColor = themeApp.primaryMain;
    primaryColor = themeApp.primaryColor;
    backgroundColor = themeApp.backgroundColor;
    imageUrl = themeApp.imageUrl;
    isDark = themeApp.isDark;
    password = settings.password;
    biometric = settings.biometric;
    language = settings.language;
    firstDayOfWeek = settings.firstDayOfWeek;
    timeFormat = settings.timeFormat;
    dataFormat = settings.dataFormat;

    if (language == 'English') {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('fa', 'IR'));
    }
    if (isDark) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
    currentIndex = theme.indexWhere((element) => element.name == name);

    final categoryBox = Hive.box<CategoryTodo>(categoryTodoBoxName);
    if (categoryBox.values.isEmpty) {
      categoryBox.add(
        CategoryTodo(name: 'All Todos', id: 1, hide: false, lock: false),
      );
      categoryBox.add(
        CategoryTodo(name: 'Work', id: 2, hide: false, lock: false),
      );
      categoryBox.add(
        CategoryTodo(name: 'Personal', id: 3, hide: false, lock: false),
      );
      categoryBox.add(
        CategoryTodo(name: 'Wishlist', id: 4, hide: false, lock: false),
      );
      categoryBox.add(
        CategoryTodo(name: 'School', id: 5, hide: false, lock: false),
      );
    }
    passwordController = TextEditingController();
    passwordController2 = TextEditingController();
    changePasswordController = TextEditingController();
    super.onInit();
  }

  void changeIndex(int newIndex) {
    activeIndex = newIndex;

    update();
  }

  void changeTheme({
    required String name,
    required Color themeColor,
    required Color primaryColor,
    required Color backgroundColor,
    required bool isDark,
  }) {
    this.name = name;
    this.themeColor = themeColor;
    this.backgroundColor = backgroundColor;
    this.primaryColor = primaryColor;
    this.isDark = isDark;
    currentIndex = theme.indexWhere((element) => element.name == name);
    saveData();
  }

  void saveData() {
    final box = Hive.box<SettingsData>(settingsBoxName);
    final settings = box.values.toList()[0];
    settings.isStarted = isStarted ?? false;
    settings.notification = notification ?? false;
    settings.name = name ?? 'Light';
    settings.password = password ?? '0';
    settings.biometric = biometric ?? false;
    settings.language = language ?? 'English';
    settings.firstDayOfWeek = firstDayOfWeek ?? 'Monday';
    settings.timeFormat = timeFormat ?? 1;
    settings.dataFormat = dataFormat ?? 1;
    settings.save();
    update();
  }
}
