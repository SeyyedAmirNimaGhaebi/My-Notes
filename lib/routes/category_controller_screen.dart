import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_notes/routes/settings_screen.dart';
import 'package:my_notes/routes/todos_screen.dart';

import '../constants.dart';
import '../controllers/settings_controller.dart';
import '../controllers/todos_controller.dart';
import '../models/database.dart';
import '../widgets/bottom_sheet_dialog.dart';
import '../widgets/sheet_button.dart';
import '../widgets/textfield.dart';

final settingsController = Get.find<SettingsController>();

class CategoryControllerScreen extends StatelessWidget {
  const CategoryControllerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryBox = Hive.box<CategoryTodo>(categoryTodoBoxName);
    final Todos_Controller categoryTodo = Get.find<Todos_Controller>();
    List<ToDos> todoByCategory;

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
          'Category',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showButtonSheetAddFolder(context);
        },
        backgroundColor: settingsController.themeColor,
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<Todos_Controller>(
        builder: (controller) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final category = categoryBox.values.toList();
              todoByCategory = categoryTodo.getTodoByCategory(name: category[index].name);
              final sortedCategory = category..sort((b, a) => b.id!.compareTo(a.id as num));
              final CategoryTodo categorySort = sortedCategory[index];

              return Visibility(
                key: UniqueKey(),
                visible: categorySort.name != 'All Todos',
                child: Container(
                  width: Get.width,
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  color: settingsController.primaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${categorySort.name!} ',
                        style: const TextStyle(fontSize: 17),
                      ),
                      Text(
                        '(${todoByCategory.length})',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                      ),
                      const Expanded(child: Text('')),
                      Visibility(
                        visible: categoryBox.values.toList()[index].hide,
                        child: Icon(
                          Icons.visibility_off_outlined,
                          color: settingsController.themeColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          final categoryData = categoryBox.values.toList()[index];

                          if (settingsController.password != '0') {
                            categoryData.lock = !categoryData.lock;
                            categoryTodo.update();
                          } else {
                            Get.to(SettingsScreen(
                              getLock: true,
                            ));
                          }
                        },
                        child: Icon(
                          categoryBox.values.toList()[index].lock
                              ? Icons.lock_outline
                              : Icons.lock_open,
                          color: categoryBox.values.toList()[index].lock
                              ? settingsController.themeColor
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 32,
                        child: PopupMenuButton(
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.edit_outlined),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    'Rename',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 3,
                              child: Row(
                                children: [
                                  Icon(categoryBox.values.toList()[index].hide
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    categoryBox.values.toList()[index].hide ? 'Show' : 'Hide',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 2,
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.trash),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Delete',
                                    style: TextStyle(
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
                              showButtonSheetRenameFolder(context, category: categorySort);
                            } else if (value == 2) {
                              BottomSheetDialog bottomSheetDialog = BottomSheetDialog(
                                title: 'Do you want to delete a category?',
                                message:
                                    'By deleting a category, the todos of that category are also deleted. If confirmed, click the "Delete" button.',
                                buttonText: 'Delete',
                                onOK: () {
                                  final categoryData = categoryBox.values.toList()[index];

                                  for (var element in categoryTodo.todoBox.values) {
                                    if (element.category == categoryData.name) {
                                      element.delete();
                                    }
                                  }
                                  categoryData.delete();
                                  categoryTodo.update();
                                  Get.back();
                                },
                                onCancel: () {},
                                builder: const Text(''),
                                size: 200,
                              );
                              bottomSheetDialog.showButtonSheetC(context);
                            } else {
                              categoryBox.values.toList()[index].hide =
                                  !categoryBox.values.toList()[index].hide;
                              categoryBox.values.toList()[index].save();
                              categoryTodo.update();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: categoryBox.length,
          );
        },
      ),
    );
  }

  void showButtonSheetRenameFolder(BuildContext context, {required CategoryTodo category}) {
    final Todos_Controller controller = Get.find<Todos_Controller>();

    controller.categoryNameController!.text = category.name ?? '';
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
              text: 'Rename',
              onTap: () async {
                for (var element in controller.todoBox.values) {
                  if (element.category == category.name) {
                    element.category = controller.categoryNameController!.text;
                    element.save();
                  }
                }
                category.name = controller.categoryNameController!.text;
                category.save();
                Get.back();
                controller.update();
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
}
