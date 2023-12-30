import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_notes/constants.dart';
import 'package:my_notes/models/database.dart';

class Add_Todos_Controller extends GetxController {
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

class Todos_Controller extends GetxController {
  TextEditingController? searchController;
  bool hideCompleted = false;
  int sort = 0;
  bool isShowComplete = false;
  List<dynamic> searchResults = [];
  double turns = 0.0;
  bool Complete = true;
  //Todo: Category
  TextEditingController? categoryNameController;
  int idCategory = 1;
  String nameCategory = 'All Todos';
  final todoBox = Hive.box<ToDos>(todoBoxName);
  final settingsBox = Hive.box<SettingsData>(settingsBoxName);

  @override
  void onInit() {
    searchController = TextEditingController();
    categoryNameController = TextEditingController();
    print(settingsBox.values.toList()[0].hideCompletedTodo);
    hideCompleted = settingsBox.values.toList()[0].hideCompletedTodo;
    sort = settingsBox.values.toList()[0].sortedTodo;
    super.onInit();
  }

  void performSearch(String text) async {
    final results = await searchInBox(text);

    searchResults = results;
    update();
  }

  void changeShowCompleteList(bool isShow) {
    isShowComplete = isShow;
    update();
  }

  Future<List<ToDos>> searchInBox(String searchString) async {
    final boxData = await Hive.openBox<ToDos>(todoBoxName);
    var box = getTodoByCategory();
    if (nameCategory == 'All Todos') {
      box = boxData.values.toList();
    }

    var results = <ToDos>[];

    results.addAll(box.where((item) => item.title!.contains(searchString)).toList());
    changeShowCompleteList(false);
    turns = 0.0;
    return results;
  }

  void changeTurns() {
    if (turns == 0.0) {
      turns = 0.25;
    } else {
      turns = 0.0;
    }
    update();
  }

  void changeCategory({required int id, required String name}) {
    idCategory = id;
    nameCategory = name;
    update();
  }

  List<ToDos> getTodoByCategory({String? name = 'no'}) {
    String categoryName = name == 'no' ? nameCategory : name!;
    return todoBox.values.where((todo) => todo.category == categoryName).toList();
  }
}
