// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:my_notes/controllers/settings_controller.dart';
import 'package:my_notes/main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

import '../constants.dart';
import '../controllers/calendar_controller.dart';
import '../models/database.dart';
import '../models/translator.dart';
import '../widgets/sheet_button.dart';
import '../widgets/textfield.dart';
import '../widgets/title.dart';
import '../widgets/select_priority_calendar.dart';

final settingsController = Get.find<SettingsController>();

class CalenderScreen extends StatelessWidget {
  CalenderScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settingsController.backgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: settingsController.themeColor,
        onPressed: () {
          showButtonSheetC(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Column(
            children: [
              GetBuilder<Calendar_Controller>(
                builder: (controller) {
                  return TableCalendar(
                    firstDay: DateTime.now(),
                    lastDay: DateTime.now().add(const Duration(days: 90)),
                    focusedDay: controller.focusedDay!,
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(controller.selectedDate, focusedDay)) {
                        controller.selectedDate = selectedDay;
                        controller.focusedDay = focusedDay;
                        controller.update();
                      }
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(controller.selectedDate, day);
                    },
                    eventLoader: controller.listOfDayEvents,
                    locale: "en_US",
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.saturday,
                    weekendDays: const [4, 5],
                    availableGestures: AvailableGestures.all,
                    calendarFormat: controller.format,
                    onFormatChanged: (format) {
                      controller.changeFormat(format);
                    },
                    /*daysOfWeekStyle: DaysOfWeekStyle(
                      dowTextFormatter: (date, locale) {
                        switch (date.weekday) {
                          case 1:
                            return 'شنبه';
                          case 2:
                            return 'یکشنبه';
                          case 3:
                            return 'دوشنبه';
                          case 4:
                            return 'سه‌شنبه';
                          case 5:
                            return 'چهارشنبه';
                          case 6:
                            return 'پنجشنبه';
                          case 7:
                            return 'جمعه';
                          default:
                            return '';
                        }
                      },
                    ),*/
                    calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: settingsController.themeColor,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: settingsController.themeColor!.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        todayTextStyle: TextStyle(
                          color: settingsController.themeColor,
                          fontSize: 17,
                        ),
                        markerDecoration: BoxDecoration(
                          color: settingsController.themeColor,
                          shape: BoxShape.circle,
                        ),
                        markersMaxCount: 1,
                        weekendTextStyle: const TextStyle(color: Colors.red)),
                  );
                },
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: settingsController.primaryColor,
                  borderRadius: BorderRadius.circular(13),
                ),
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(5),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: settingsController.themeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  tabs: [
                    Tab(text: Translator.calenderText4.tr),
                    Tab(text: Translator.calenderText3.tr),
                  ],
                  labelStyle: const TextStyle(
                    fontSize: 16,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: settingsController.isDark ? Colors.white : Colors.black,
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 200,
                      child: GetBuilder<Calendar_Controller>(
                        builder: (controller) {
                          return CustomScrollView(
                            slivers: [
                              controller.listOfDayEvents(controller.selectedDate!).isNotEmpty
                                  ? SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                          final sortedTodos = controller
                                              .listOfDayEvents(controller.selectedDate!)
                                              .toList()
                                            ..sort((a, b) =>
                                                b.priority!.compareTo(a.priority as num));
                                          final ToDos toDos = sortedTodos[index];

                                          return FadeInRight(
                                            delay: Duration(milliseconds: index * 70),
                                            duration: const Duration(milliseconds: 700),
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
                                                    Text(
                                                      Translator.todoText9.tr,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              secondaryBackground: Container(
                                                color: settingsController.backgroundColor,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(CupertinoIcons.timer,
                                                        color: settingsController.backgroundColor),
                                                    const Text(
                                                      'Set a reminder',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              key: UniqueKey(),
                                              onDismissed: (direction) async {
                                                if (direction == DismissDirection.startToEnd) {
                                                  controller
                                                      .listOfDayEvents(controller.selectedDate!)
                                                      .remove(toDos);

                                                  toDos.delete();
                                                  controller.update();
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
                                                color: settingsController.primaryColor,
                                                elevation: 0.0,
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
                                                              Get.find<Calendar_Controller>()
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
                                                        width: 7,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        childCount: controller
                                            .listOfDayEvents(controller.selectedDate!)
                                            .length,
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
                                                'assets/images/todos.json',
                                                height: 240,
                                                width: 240,
                                                repeat: true,
                                              ),
                                              Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 170,
                                                  ),
                                                  DefaultTextStyle(
                                                    style: const TextStyle(
                                                      fontSize: 19.0,
                                                    ),
                                                    child: AnimatedTextKit(
                                                      totalRepeatCount: 1,
                                                      animatedTexts: [
                                                        TyperAnimatedText(
                                                          Translator.calenderText1.tr,
                                                          textStyle: TextStyle(
                                                              fontSize: 17,
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
                                    ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Lottie.asset(
                                      'assets/images/typeing.json',
                                      height: 210,
                                      width: 210,
                                      repeat: true,
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 190,
                                        ),
                                        DefaultTextStyle(
                                          style: const TextStyle(
                                            fontSize: 19.0,
                                          ),
                                          child: AnimatedTextKit(
                                            totalRepeatCount: 1,
                                            animatedTexts: [
                                              TyperAnimatedText(
                                                Translator.calenderText2.tr,
                                                textStyle: TextStyle(
                                                    fontSize: 17,
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showButtonSheetC(BuildContext context) {
    final Add_Todos_Calendar_Controller controller = Get.put(Add_Todos_Calendar_Controller());
    Get.bottomSheet(
      SizedBox(
        height: 400,
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
            SelectPriorityCalendar(),
            const Expanded(
              child: Text(''),
            ),
            SheetButton(
              text: Translator.todoText8.tr,
              onTap: () async {
                int priority = 0;
                final box = Hive.box<ToDos>(calendarBoxName);
                for (int i = 0; i < 3; i++) {
                  if (controller.prioritySelected[i] == true) {
                    priority = i;
                  }
                }
                if (controller.titleController!.text.isNotEmpty) {
                  bool todoExists =
                      box.values.any((todo) => todo.title == controller.titleController!.text);
                  if (!todoExists) {
                    final controllerCalendar = Get.find<Calendar_Controller>();
                    await box.add(
                      ToDos(
                        priority: priority,
                        title: controller.titleController!.text,
                        description: controller.descriptionController!.text,
                        isCompleted: false,
                        isHistory: false,
                        createDate: controllerCalendar.selectedDate,
                        completionDate: null,
                        hide: false,
                        category: null,
                      ),
                    );
                    controller.titleController!.clear();
                    controller.descriptionController!.clear();
                    controller.setDefault();
                    Get.back();
                    Get.find<Calendar_Controller>().setDateCalendar();
                  }
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

class MyCheckBox extends StatelessWidget {
  final bool? value;
  final GestureTapCallback onTap;
  const MyCheckBox({Key? key, required this.value, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: !value! ? 24 : 25,
        height: !value! ? 24 : 25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: !value! ? Border.all(color: Colors.grey, width: 2) : null,
            color: value! ? settingsController.themeColor : null),
        child: value!
            ? const Center(
                child: Icon(
                  Icons.check,
                  size: 17,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
