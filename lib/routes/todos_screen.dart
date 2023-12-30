//*Packages
// ignore_for_file: use_build_context_synchronously
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:my_notes/routes/category_controller_screen.dart';
//*Class
import '../constants.dart';
import '../controllers/settings_controller.dart';
import '../main.dart';
import '../widgets/search_textfield.dart';
import '../models/database.dart';
import '../models/translator.dart';
import '../routes/landscape.dart';
import '../widgets/select_priority.dart';
import '../widgets/sheet_button.dart';
import '../widgets/textfield.dart';
import '../controllers/todos_controller.dart';
import '../widgets/title.dart';
import '../widgets/toast_message.dart';

double width = Get.width;
double height = Get.height;
final settingsController = Get.find<SettingsController>();

class ToDosScreen extends StatelessWidget {
  final box = Hive.box<ToDos>(todoBoxName);
  final categoryBox = Hive.box<CategoryTodo>(categoryTodoBoxName);
  final int length = 0;
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

  ToDosScreen({super.key});
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Scaffold(
        backgroundColor: settingsController.backgroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showButtonSheetAddTodo(context);
          },
          backgroundColor: settingsController.themeColor,
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SearchTextField(
                    controller: Get.find<Todos_Controller>().searchController,
                    hintText: Translator.searchTabTodo.tr,
                    onChange: () {
                      Get.find<Todos_Controller>()
                          .performSearch(Get.find<Todos_Controller>().searchController!.text);
                    },
                  ),
                  SizedBox(
                    width: 32,
                    child: GetBuilder<Todos_Controller>(
                      builder: (controller) {
                        return PopupMenuButton(
                          tooltip: '',
                          position: PopupMenuPosition.over,
                          splashRadius: 20,
                          color: settingsController.primaryColor,
                          icon: Icon(
                            Icons.more_vert,
                            color: settingsController.isDark ? Colors.white : Colors.black,
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(Icons.sort),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Sort',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Row(
                                children: [
                                  Icon(controller.hideCompleted == false
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    controller.hideCompleted == false
                                        ? 'Hide completed'
                                        : 'Show completed',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          elevation: 4,
                          onSelected: (value) {
                            if (value == 1) {
                              showButtonSheetSetSort();
                            }
                            if (value == 2) {
                              controller.hideCompleted = !controller.hideCompleted;
                              controller.isShowComplete = !controller.hideCompleted;
                              controller.turns = controller.hideCompleted ? 0.0 : 0.25;

                              controller.settingsBox.values.toList()[0].hideCompletedTodo =
                                  controller.hideCompleted;
                              controller.settingsBox.values.toList()[0].save();

                              controller.update();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              GetBuilder<Todos_Controller>(
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 8, left: 8, right: 8),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final category = categoryBox.values.toList()[index];

                                return Visibility(
                                  visible: !category.hide,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.changeCategory(
                                          id: category.id!, name: category.name!);
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      decoration: BoxDecoration(
                                        color: category.id == controller.idCategory
                                            ? settingsController.themeColor
                                            : settingsController.themeColor!.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      margin: const EdgeInsets.only(
                                          top: 4, bottom: 4, left: 6, right: 6),
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Center(
                                        child: Text(
                                          category.name!,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                            color: category.id == controller.idCategory
                                                ? Colors.white
                                                : settingsController.isDark
                                                    ? Colors.white
                                                    : Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: categoryBox.length,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: GestureDetector(
                              onTap: () {
                                showButtonSheetAddFolder(context);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                margin: const EdgeInsets.only(top: 3, bottom: 3, right: 3),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(const CategoryControllerScreen());
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                margin: const EdgeInsets.only(top: 3, bottom: 3, right: 3),
                                child: const Center(
                                  child: Icon(
                                    Icons.settings,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                child: GetBuilder<Todos_Controller>(
                  builder: (controller) {
                    final Todos_Controller categoryTodo = Get.find<Todos_Controller>();
                    List<ToDos> todoByCategory;
                    if (categoryTodo.nameCategory == 'All Todos') {
                      todoByCategory = box.values.toList();
                    } else {
                      todoByCategory = categoryTodo.getTodoByCategory();
                    }

                    return CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      slivers: [
                        controller.searchController!.text.isEmpty
                            ? todoByCategory.isNotEmpty
                                ? SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      childCount: todoByCategory.length,
                                      (context, index) {
                                        List<ToDos> sortedTodoByCategory;

                                        switch (controller.sort) {
                                          case 0:
                                            sortedTodoByCategory = List.from(todoByCategory)
                                              ..sort((a, b) => b.priority!.compareTo(a.priority!));
                                            break;
                                          case 1:
                                            sortedTodoByCategory = List.from(todoByCategory)
                                              ..sort((b, a) => b.title!.compareTo(a.title!));
                                            break;
                                          case 2:
                                            sortedTodoByCategory = List.from(todoByCategory)
                                              ..sort((a, b) => b.title!.compareTo(a.title!));
                                            break;
                                          case 3:
                                            sortedTodoByCategory = List.from(todoByCategory)
                                              ..sort((a, b) =>
                                                  b.createDate!.compareTo(a.createDate!));
                                            break;
                                          case 4:
                                            sortedTodoByCategory = List.from(todoByCategory)
                                              ..sort((b, a) =>
                                                  b.createDate!.compareTo(a.createDate!));
                                            break;
                                          default:
                                            sortedTodoByCategory = todoByCategory;
                                        }

                                        final ToDos toDos = sortedTodoByCategory[index];

                                        return FadeOutRight(
                                          animate: toDos.isCompleted!,
                                          child: Visibility(
                                            visible: !toDos.hide!,
                                            child: FadeInRight(
                                              delay: Duration(milliseconds: index * 30),
                                              duration: const Duration(milliseconds: 200),
                                              child: Dismissible(
                                                background: Container(
                                                  color: settingsController.backgroundColor,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        CupertinoIcons.delete,
                                                        color: settingsController.backgroundColor,
                                                      ),
                                                      Text(Translator.todoText9.tr)
                                                    ],
                                                  ),
                                                ),
                                                secondaryBackground: Container(
                                                  color: settingsController.backgroundColor,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        CupertinoIcons.timer,
                                                        color: settingsController.backgroundColor,
                                                      ),
                                                      const Text('Set a reminder'),
                                                    ],
                                                  ),
                                                ),
                                                key: UniqueKey(),
                                                onDismissed: (direction) async {
                                                  if (direction == DismissDirection.startToEnd) {
                                                    var box =
                                                        await Hive.openBox<ToDos>(todoBoxName);
                                                    var todoKey = box.keys.firstWhere((key) =>
                                                        box.get(key)!.title == toDos.title);

                                                    await box.delete(todoKey);
                                                    Get.find<Todos_Controller>().update();
                                                    showToastMessage(
                                                      message: Translator.todoText16.tr,
                                                      icon: null,
                                                      color: null,
                                                      foregroundColor: null,
                                                      toastGravity: ToastGravity.BOTTOM,
                                                      context: context,
                                                    );
                                                  } else {
                                                    _isAndroidPermissionGranted();
                                                    _requestPermissions();
                                                    controller.update();
                                                    late final now = DateTime.now();
                                                    late Time selectedTime =
                                                        Time(hour: now.hour, minute: now.minute);

                                                    await Navigator.of(context).push(
                                                      showPicker(
                                                        showCancelButton: true,
                                                        showSecondSelector: false,
                                                        context: context,
                                                        value: selectedTime,
                                                        iosStylePicker: true,
                                                        onChange: (time) {
                                                          selectedTime = time;
                                                        },
                                                        blurredBackground: true,
                                                        accentColor: settingsController.isDark
                                                            ? null
                                                            : Colors.black,
                                                        unselectedColor: settingsController.isDark
                                                            ? null
                                                            : Colors.black,
                                                        cancelStyle: TextStyle(
                                                          color: settingsController.themeColor!
                                                              .withOpacity(0.6),
                                                          fontSize: 18,
                                                        ),
                                                        okStyle: TextStyle(
                                                          color: settingsController.themeColor,
                                                          fontSize: 18,
                                                        ),
                                                        is24HrFormat: true,
                                                        minuteInterval: TimePickerInterval.ONE,
                                                        height: 350,
                                                        borderRadius: 20.0,
                                                      ),
                                                    );

                                                    final selectedDateTime = DateTime(
                                                      now.year,
                                                      now.month,
                                                      now.day,
                                                      selectedTime.hour,
                                                      selectedTime.minute,
                                                    );

                                                    if (selectedDateTime.isAfter(now)) {
                                                      final duration =
                                                          selectedDateTime.difference(now);
                                                      await zonedScheduleAlarmClockNotification(
                                                        duration: duration,
                                                        title: toDos.title.toString(),
                                                        message: toDos.description.toString(),
                                                        payload: toDos.title.toString(),
                                                        type: 'Todo',
                                                      );
                                                    }
                                                  }
                                                },
                                                child: Card(
                                                  elevation: 1.0,
                                                  shadowColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  margin: const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: ListTile(
                                                            onTap: () {
                                                              //showButtonSheetTodo(toDos);
                                                            },
                                                            title: Text(
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              toDos.title.toString(),
                                                              style: TextStyle(
                                                                decoration: toDos.isCompleted!
                                                                    ? TextDecoration.lineThrough
                                                                    : TextDecoration.none,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                            dense: true,
                                                            subtitle: Text(
                                                              toDos.description.toString(),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                decoration: toDos.isCompleted!
                                                                    ? TextDecoration.lineThrough
                                                                    : TextDecoration.none,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            leading: MyCheckBox(
                                                              value: toDos.isCompleted,
                                                              onTap: () async {
                                                                bool priorityUpdate =
                                                                    !toDos.isCompleted!;

                                                                toDos.isCompleted = priorityUpdate;

                                                                await toDos.save();
                                                                Future.delayed(
                                                                    const Duration(
                                                                        milliseconds: 300),
                                                                    () async {
                                                                  bool hideAnimation =
                                                                      !toDos.hide!;

                                                                  toDos.hide = hideAnimation;

                                                                  await toDos.save();

                                                                  Get.find<Todos_Controller>()
                                                                      .update();
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 5,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(12),
                                                            color: toDos.priority == 0
                                                                ? const Color.fromRGBO(
                                                                    32, 195, 242, 1)
                                                                : toDos.priority == 2
                                                                    ? const Color.fromRGBO(
                                                                        122, 103, 255, 1)
                                                                    : settingsController.isDark
                                                                        ? const Color.fromRGBO(
                                                                            66, 66, 66, 1)
                                                                        : Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : SliverToBoxAdapter(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 0,
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Lottie.asset(
                                              'assets/images/todos.json',
                                              height: 330,
                                              width: 330,
                                              repeat: true,
                                            ),
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 230,
                                                ),
                                                DefaultTextStyle(
                                                  style: const TextStyle(
                                                    fontSize: 19.0,
                                                  ),
                                                  child: AnimatedTextKit(
                                                    totalRepeatCount: 1,
                                                    animatedTexts: [
                                                      TyperAnimatedText(
                                                        Translator.todoText13.tr,
                                                        textStyle: TextStyle(
                                                            color: settingsController.isDark
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontWeight: FontWeight.w300),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                            : controller.searchResults.isNotEmpty
                                ? SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        final toDos = controller.searchResults[index];
                                        List<TextSpan> spans = _highlightOccurrences(
                                          toDos.title.toString(),
                                          controller.searchController!.text,
                                          toDos,
                                        );
                                        return Visibility(
                                          visible: !toDos.isCompleted!,
                                          child: FadeInRight(
                                            delay: Duration(milliseconds: index * 30),
                                            duration: const Duration(milliseconds: 200),
                                            child: Dismissible(
                                              background: Container(
                                                color: settingsController.backgroundColor,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons.delete,
                                                      color: settingsController.backgroundColor,
                                                    ),
                                                    Text(Translator.todoText9.tr)
                                                  ],
                                                ),
                                              ),
                                              key: UniqueKey(),
                                              onDismissed: (direction) async {
                                                if (direction == DismissDirection.startToEnd) {
                                                  var box = await Hive.openBox<ToDos>(todoBoxName);
                                                  var todoKey = box.keys.firstWhere(
                                                      (key) => box.get(key)!.title == toDos.title);
                                                  await box.delete(todoKey);

                                                  Get.find<Todos_Controller>()
                                                      .searchController
                                                      ?.clear();

                                                  Get.find<Todos_Controller>().update();

                                                  showToastMessage(
                                                    message: Translator.todoText16.tr,
                                                    icon: null,
                                                    color: null,
                                                    foregroundColor: null,
                                                    toastGravity: ToastGravity.BOTTOM,
                                                    context: context,
                                                  );
                                                } else {
                                                  var box = await Hive.openBox<ToDos>(todoBoxName);
                                                  var todo = box.values.firstWhere(
                                                      (todo) => todo.title == toDos.title);

                                                  _isAndroidPermissionGranted();
                                                  _requestPermissions();
                                                  controller.update();
                                                  late final now = DateTime.now();
                                                  late Time selectedTime =
                                                      Time(hour: now.hour, minute: now.minute);

                                                  await Navigator.of(context).push(
                                                    showPicker(
                                                      showCancelButton: true,
                                                      showSecondSelector: false,
                                                      context: context,
                                                      value: selectedTime,
                                                      iosStylePicker: true,
                                                      onChange: (time) {
                                                        selectedTime = time;
                                                      },
                                                      blurredBackground: true,
                                                      accentColor: settingsController.isDark
                                                          ? null
                                                          : Colors.black,
                                                      unselectedColor: settingsController.isDark
                                                          ? null
                                                          : Colors.black,
                                                      cancelStyle: TextStyle(
                                                        color: settingsController.themeColor!
                                                            .withOpacity(0.6),
                                                        fontSize: 18,
                                                      ),
                                                      okStyle: TextStyle(
                                                        color: settingsController.themeColor,
                                                        fontSize: 18,
                                                      ),
                                                      is24HrFormat: true,
                                                      minuteInterval: TimePickerInterval.ONE,
                                                      height: 350,
                                                      borderRadius: 20.0,
                                                    ),
                                                  );

                                                  final selectedDateTime = DateTime(
                                                    now.year,
                                                    now.month,
                                                    now.day,
                                                    selectedTime.hour,
                                                    selectedTime.minute,
                                                  );

                                                  if (selectedDateTime.isAfter(now)) {
                                                    final duration =
                                                        selectedDateTime.difference(now);
                                                    await zonedScheduleAlarmClockNotification(
                                                      duration: duration,
                                                      title: todo.title.toString(),
                                                      message: todo.description.toString(),
                                                      payload: toDos.title.toString(),
                                                      type: 'Todo',
                                                    );
                                                  }
                                                }
                                              },
                                              child: Card(
                                                elevation: 1.0,
                                                shadowColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                margin: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: ListTile(
                                                          onTap: () {
                                                            //showButtonSheetTodo(toDos);
                                                          },
                                                          title: RichText(
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            text: TextSpan(
                                                              children: spans,
                                                              style: TextStyle(
                                                                decoration: toDos.isCompleted!
                                                                    ? TextDecoration.lineThrough
                                                                    : TextDecoration.none,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ),
                                                          dense: true,
                                                          subtitle: Text(
                                                            toDos.description.toString(),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              decoration: toDos.isCompleted!
                                                                  ? TextDecoration.lineThrough
                                                                  : TextDecoration.none,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          leading: MyCheckBox(
                                                            value: toDos.isCompleted,
                                                            onTap: () async {
                                                              bool priorityUpdate =
                                                                  !toDos.isCompleted!;
                                                              toDos.isCompleted = priorityUpdate;
                                                              await toDos.save();
                                                              Get.find<Todos_Controller>()
                                                                  .update();
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 5,
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(12),
                                                          color: toDos.priority == 0
                                                              ? const Color.fromRGBO(
                                                                  32, 195, 242, 1)
                                                              : toDos.priority == 2
                                                                  ? const Color.fromRGBO(
                                                                      122, 103, 255, 1)
                                                                  : settingsController.isDark
                                                                      ? const Color.fromRGBO(
                                                                          66, 66, 66, 1)
                                                                      : Colors.white,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      childCount: controller.searchResults.length,
                                    ),
                                  )
                                : SliverToBoxAdapter(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Lottie.asset(
                                              'assets/images/not_found.json',
                                              height: 300,
                                              width: 300,
                                              repeat: false,
                                            ),
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 230,
                                                ),
                                                FadeInUp(
                                                  from: 15,
                                                  child: Text(
                                                    Translator.todoText14.tr,
                                                    style: const TextStyle(
                                                        fontSize: 19.0,
                                                        fontWeight: FontWeight.w300),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                        GetBuilder<Todos_Controller>(
                          builder: (controller) {
                            int completedLength = 0;
                            final Todos_Controller categoryTodo = Get.find<Todos_Controller>();
                            List<ToDos> todoByCategory;
                            if (categoryTodo.nameCategory == 'All Todos') {
                              todoByCategory = box.values.toList();
                            } else {
                              todoByCategory = categoryTodo.getTodoByCategory();
                            }

                            for (int i = 0; i < todoByCategory.length; i++) {
                              if (todoByCategory[i].isCompleted == true) {
                                completedLength++;
                              }
                            }

                            return SliverToBoxAdapter(
                              child: Visibility(
                                visible: !controller.hideCompleted,
                                child: Visibility(
                                  visible: completedLength != 0 &&
                                      controller.searchController!.text.isEmpty,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.changeTurns();
                                      controller.changeShowCompleteList(
                                        controller.isShowComplete ? false : true,
                                      );
                                    },
                                    child: Container(
                                      height: 45,
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Row(
                                        children: [
                                          AnimatedRotation(
                                            turns: controller.turns,
                                            duration: const Duration(milliseconds: 300),
                                            child: InkWell(
                                              onTap: () {
                                                controller.changeTurns();
                                                controller.changeShowCompleteList(
                                                  controller.isShowComplete ? false : true,
                                                );
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(6.0),
                                                child: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Completed $completedLength',
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        GetBuilder<Todos_Controller>(
                          builder: (controller) {
                            final Todos_Controller categoryTodo = Get.find<Todos_Controller>();
                            List<ToDos> todoByCategory;
                            if (categoryTodo.nameCategory == 'All Todos') {
                              todoByCategory = box.values.toList();
                            } else {
                              todoByCategory = categoryTodo.getTodoByCategory();
                            }
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  //*Priority :
                                  final prioritySorted = todoByCategory
                                    ..sort((a, b) => b.priority!.compareTo(a.priority!));

                                  //*A - Z :
                                  final nameSortedAZ = todoByCategory
                                    ..sort((b, a) => b.title!.compareTo(a.title!));

                                  //*Z - A :
                                  final nameSortedZA = todoByCategory
                                    ..sort((a, b) => b.title!.compareTo(a.title!));

                                  //*Create Date :
                                  final createDateSorted = todoByCategory
                                    ..sort((a, b) => b.createDate!.compareTo(a.createDate!));

                                  //*Create Date Old :
                                  final createDateOldSorted = todoByCategory
                                    ..sort((b, a) => b.createDate!.compareTo(a.createDate!));

                                  final ToDos toDos = controller.sort == 0
                                      ? prioritySorted[index]
                                      : controller.sort == 1
                                          ? nameSortedAZ[index]
                                          : controller.sort == 2
                                              ? nameSortedZA[index]
                                              : controller.sort == 3
                                                  ? createDateSorted[index]
                                                  : createDateOldSorted[index];
                                  return FadeOutRight(
                                    animate: !toDos.isCompleted!,
                                    child: Visibility(
                                      visible: controller.isShowComplete && toDos.hide!,
                                      child: FadeInRight(
                                        delay: Duration(milliseconds: index * 30),
                                        duration: const Duration(milliseconds: 200),
                                        child: Dismissible(
                                          direction: DismissDirection.startToEnd,
                                          background: Container(
                                            color: settingsController.backgroundColor,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.delete,
                                                  color: settingsController.backgroundColor,
                                                ),
                                                Text(Translator.todoText9.tr)
                                              ],
                                            ),
                                          ),
                                          key: UniqueKey(),
                                          onDismissed: (direction) async {
                                            if (direction == DismissDirection.startToEnd) {}
                                            var box = await Hive.openBox<ToDos>(todoBoxName);
                                            var todoKey = box.keys.firstWhere(
                                                (key) => box.get(key)!.title == toDos.title);
                                            await box.delete(todoKey);

                                            Get.find<Todos_Controller>().searchController?.clear();

                                            Get.find<Todos_Controller>().update();

                                            showToastMessage(
                                              message: Translator.todoText16.tr,
                                              icon: null,
                                              color: null,
                                              foregroundColor: null,
                                              toastGravity: ToastGravity.BOTTOM,
                                              context: context,
                                            );
                                          },
                                          child: Card(
                                            elevation: 1.0,
                                            shadowColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: ListTile(
                                                      onTap: () {
                                                        //showButtonSheetTodo(toDos);
                                                      },
                                                      title: Text(
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        toDos.title.toString(),
                                                        style: TextStyle(
                                                          decoration: toDos.isCompleted!
                                                              ? TextDecoration.lineThrough
                                                              : TextDecoration.none,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      dense: true,
                                                      subtitle: Text(
                                                        toDos.description.toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          decoration: toDos.isCompleted!
                                                              ? TextDecoration.lineThrough
                                                              : TextDecoration.none,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      leading: MyCheckBox(
                                                        value: toDos.isCompleted,
                                                        onTap: () async {
                                                          bool priorityUpdate =
                                                              !toDos.isCompleted!;

                                                          toDos.isCompleted = priorityUpdate;

                                                          await toDos.save();
                                                          Future.delayed(
                                                              const Duration(milliseconds: 300),
                                                              () async {
                                                            bool hideAnimation = !toDos.hide!;

                                                            toDos.hide = hideAnimation;

                                                            await toDos.save();

                                                            Get.find<Todos_Controller>().update();
                                                          });
                                                          Get.find<Todos_Controller>().update();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 5,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      color: toDos.priority == 0
                                                          ? const Color.fromRGBO(32, 195, 242, 1)
                                                          : toDos.priority == 2
                                                              ? const Color.fromRGBO(
                                                                  122, 103, 255, 1)
                                                              : settingsController.isDark
                                                                  ? const Color.fromRGBO(
                                                                      66, 66, 66, 1)
                                                                  : Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                childCount: todoByCategory.length,
                              ),
                            );
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const LandScape();
    }
  }

  void showButtonSheetAddTodo(BuildContext context) {
    final Add_Todos_Controller controller = Get.put(Add_Todos_Controller());
    final Todos_Controller categoryController = Get.find<Todos_Controller>();
    Get.bottomSheet(
      SizedBox(
        height: 390,
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
            TextFieldC(
              controller: controller.titleController,
              hintText: Translator.todoText2.tr,
              icon: null,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 13),
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: settingsController.isDark ? Colors.grey.shade800 : Colors.white,
                border: Border.all(
                  color: settingsController.backgroundColor!,
                  width: 1,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    maxLines: 20,
                    cursorColor: settingsController.themeColor,
                    controller: controller.descriptionController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: Translator.todoText3.tr,
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: settingsController.isDark ? Colors.white60 : Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            mainTitle(
              title: Translator.todoText4.tr,
              fontSize: SizeTitle.medium,
            ),
            const SizedBox(
              height: 10,
            ),
            SelectPriority(),
            const Expanded(child: Text('')),
            SheetButton(
              text: Translator.todoText8.tr,
              onTap: () async {
                int priority = 0;
                for (int i = 0; i < 3; i++) {
                  if (controller.prioritySelected[i] == true) {
                    priority = i;
                  }
                }
                final box = Hive.box<ToDos>(todoBoxName);
                if (controller.titleController!.text.isNotEmpty) {
                  bool todoExists =
                      box.values.any((todo) => todo.title == controller.titleController!.text);
                  if (todoExists) {
                    showToastMessage(
                      message: Translator.todoText19.tr,
                      icon: Icons.error,
                      color: null,
                      foregroundColor: null,
                      toastGravity: ToastGravity.TOP,
                      context: context,
                    );
                  } else {
                    await box.add(
                      ToDos(
                        priority: priority,
                        title: controller.titleController!.text,
                        description: controller.descriptionController!.text,
                        isCompleted: false,
                        isHistory: false,
                        createDate: DateTime.now(),
                        completionDate: null,
                        hide: false,
                        category: categoryController.nameCategory,
                      ),
                    );
                    controller.titleController!.clear();
                    controller.descriptionController!.clear();
                    controller.setDefault();
                    Get.back();
                    Get.find<Todos_Controller>().update();
                  }
                } else {
                  showToastMessage(
                    message: Translator.todoText20.tr,
                    icon: Icons.error,
                    color: null,
                    foregroundColor: null,
                    toastGravity: ToastGravity.TOP,
                    context: context,
                  );
                }
              },
              onCancel: () {
                controller.titleController!.clear();
                controller.descriptionController!.clear();
                controller.setDefault();
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      backgroundColor: settingsController.backgroundColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}

void showButtonSheetAddFolder(BuildContext context) {
  final Todos_Controller controller = Get.find<Todos_Controller>();
  Get.bottomSheet(
    SizedBox(
      height: 210,
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
          const Text(
            'Add new category',
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldC(
            controller: controller.categoryNameController!,
            hintText: 'The name for the new category',
            icon: null,
          ),
          const Expanded(child: Text('')),
          SheetButton(
            text: 'Add',
            onTap: () async {
              final box = Hive.box<CategoryTodo>(categoryTodoBoxName);
              if (controller.categoryNameController!.text.isNotEmpty) {
                bool categoryExists = box.values
                    .any((category) => category.name == controller.categoryNameController!.text);
                if (categoryExists) {
                  showToastMessage(
                    message: Translator.todoText21.tr,
                    icon: Icons.error,
                    color: null,
                    foregroundColor: null,
                    toastGravity: ToastGravity.TOP,
                    context: context,
                  );
                } else {
                  int index = box.values.last.id!;
                  await box.add(
                    CategoryTodo(
                      name: controller.categoryNameController!.text,
                      id: index += 1,
                      hide: false,
                      lock: false,
                    ),
                  );
                  controller.categoryNameController!.clear();

                  Get.back();

                  controller.update();
                }
              } else {
                showToastMessage(
                  message: Translator.todoText22.tr,
                  icon: Icons.error,
                  color: null,
                  foregroundColor: null,
                  toastGravity: ToastGravity.TOP,
                  context: context,
                );
              }
            },
            onCancel: () {
              controller.categoryNameController!.clear();
            },
          ),
          const SizedBox(
            height: 10,
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

void showButtonSheetSetSort() {
  Get.bottomSheet(
    SizedBox(
      height: 260,
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
          GetBuilder<Todos_Controller>(
            builder: (controller) {
              return Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: RadioListTile(
                      title: const Text('Priority'),
                      value: 0,
                      groupValue: controller.sort,
                      onChanged: (value) {
                        controller.sort = value!;
                        controller.settingsBox.values.toList()[0].sortedTodo = 0;
                        controller.settingsBox.values.toList()[0].save();
                        controller.update();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: RadioListTile(
                      title: const Text('Name A - Z'),
                      value: 1,
                      groupValue: controller.sort,
                      onChanged: (value) {
                        controller.sort = value!;
                        controller.settingsBox.values.toList()[0].sortedTodo = 1;
                        controller.settingsBox.values.toList()[0].save();
                        controller.update();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: RadioListTile(
                      title: const Text('Name Z - A'),
                      value: 2,
                      groupValue: controller.sort,
                      onChanged: (value) {
                        controller.sort = value!;
                        controller.settingsBox.values.toList()[0].sortedTodo = 2;
                        controller.settingsBox.values.toList()[0].save();
                        controller.update();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: RadioListTile(
                      title: const Text('Created time (Newest first)'),
                      value: 3,
                      groupValue: controller.sort,
                      onChanged: (value) {
                        controller.sort = value!;
                        controller.settingsBox.values.toList()[0].sortedTodo = 3;
                        controller.settingsBox.values.toList()[0].save();
                        controller.update();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: RadioListTile(
                      title: const Text('Created time (Oldest first)'),
                      value: 4,
                      groupValue: controller.sort,
                      onChanged: (value) {
                        controller.sort = value!;
                        controller.settingsBox.values.toList()[0].sortedTodo = 4;
                        controller.settingsBox.values.toList()[0].save();
                        controller.update();
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

class MyCheckBox extends StatelessWidget {
  final bool? value;
  final GestureTapCallback onTap;
  const MyCheckBox({Key? key, required this.value, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: !value! ? Border.all(color: Colors.grey, width: 2) : null,
            color: value! ? settingsController.themeColor : null),
        child: value!
            ? const Center(
                child: Icon(
                  CupertinoIcons.check_mark,
                  size: 15,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}

List<TextSpan> _highlightOccurrences(String text, String query, ToDos toDos) {
  final List<TextSpan> spans = [];
  final String lowercaseText = text.toLowerCase();
  final String lowercaseQuery = query.toLowerCase();
  int lastIndex = 0;
  int index = lowercaseText.indexOf(lowercaseQuery);

  while (index != -1) {
    spans.add(
      TextSpan(
        text: text.substring(lastIndex, index),
        style: TextStyle(
          decoration: toDos.isCompleted! ? TextDecoration.lineThrough : TextDecoration.none,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
    spans.add(TextSpan(
      text: text.substring(index, index + query.length),
      style: TextStyle(
        decoration: toDos.isCompleted! ? TextDecoration.lineThrough : TextDecoration.none,
        fontSize: 20,
        color: Colors.amber,
      ),
    ));
    lastIndex = index + query.length;
    index = lowercaseText.indexOf(lowercaseQuery, lastIndex);
  }

  spans.add(TextSpan(
    text: text.substring(lastIndex, text.length),
    style: TextStyle(
      decoration: toDos.isCompleted! ? TextDecoration.lineThrough : TextDecoration.none,
      fontSize: 20,
      color: Colors.black,
    ),
  ));

  return spans;
}
