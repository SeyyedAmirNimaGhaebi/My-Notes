import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/constants.dart';
import 'package:my_notes/models/database.dart';
import 'package:table_calendar/table_calendar.dart';

class Add_Todos_Calendar_Controller extends GetxController {
  var prioritySelected = <bool>[false, true, false].obs;
  TextEditingController? titleController;
  TextEditingController? descriptionController;

  @override
  void onInit() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.onInit();
  }

  void selectPriority(int index) {
    for (var i = 0; i < prioritySelected.length; i++) {
      prioritySelected[i] = i == index ? true : false;
    }
    update();
  }

  void setDefault() {
    prioritySelected[0] = false;
    prioritySelected[1] = true;
    prioritySelected[2] = false;
  }
}

class Calendar_Controller extends GetxController {
  int completedLength = 0;
  Map<String, List<ToDos>> selectedEvents = {};
  DateTime? focusedDay;
  DateTime? selectedDate;
  CalendarFormat format = CalendarFormat.twoWeeks;

  @override
  void onInit() {
    getLength();
    focusedDay = DateTime.now();
    selectedDate = DateTime.now();
    setDateCalendar();
    super.onInit();
  }

  List listOfDayEvents(DateTime dateTime) {
    if (selectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return selectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  void changeFormat(CalendarFormat format){
    this.format = format;
    update();
  }
  void setDateCalendar() {
    selectedEvents.clear();
    final box = Hive.box<ToDos>(calendarBoxName);
    for (int i = 0; i < box.length; i++) {
      final ToDos toDos = box.values.toList()[i];
      if (selectedEvents[DateFormat('yyyy-MM-dd').format(toDos.createDate!)] != null) {
        selectedEvents[DateFormat('yyyy-MM-dd').format(toDos.createDate!)]?.add(toDos);
      } else {
        selectedEvents[DateFormat('yyyy-MM-dd').format(toDos.createDate!)] = [toDos];
      }
    }
    update();
  }

  void getLength() async {
    final box = await Hive.openBox<ToDos>(todoBoxName);
    completedLength = 0;
    for (int i = 0; i < box.length; i++) {
      if (box.values.toList()[i].isCompleted == true) {
        completedLength++;
      }
    }
    update();
  }
}
