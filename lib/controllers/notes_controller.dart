import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Add_Notes_Controller extends GetxController{
  String title='';
  final category='All'.obs;
  Color color = Colors.grey;
  var tagsList = <String>[];

  //!Functions:

  void changeCategory(String _category) {
    category.value = _category;
  }

  void addTag(String item) {
    tagsList.add(item);
    update();
  }
}