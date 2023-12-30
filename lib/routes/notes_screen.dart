// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/controllers/notes_controller.dart';
import 'package:my_notes/models/translator.dart';
import 'package:my_notes/routes/landscape.dart';
import 'package:my_notes/widgets/color_picker.dart';
import 'package:my_notes/widgets/search_textfield.dart';
import 'package:my_notes/widgets/sheet_button.dart';
import 'package:my_notes/widgets/textfield.dart';

import '../controllers/settings_controller.dart';
import '../widgets/title.dart';

double _widthSize = Get.width;
final settingsController = Get.find<SettingsController>();

class NotesScreen extends StatelessWidget {
  final TextEditingController _searchcontroller = TextEditingController();
  Color colorNote = Colors.grey.shade900;

  NotesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Scaffold(
            backgroundColor: settingsController.backgroundColor,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SearchTextField(
                    controller: _searchcontroller,
                    hintText: Translator.searchTabNote.tr,
                    onChange: () {},
                  ),
                ],
              ),
            ),
          )
        : const LandScape();
  }

  void showButtonSheetC() {
    final titleController = TextEditingController();
    final tagController = TextEditingController();
    Get.bottomSheet(
      SizedBox(
        height: 513,
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
              controller: titleController,
              hintText: Translator.addNoteText1.tr,
              icon: null,
            ),
            const SizedBox(
              height: 10,
            ),
            mainTitle(
              title: Translator.addNoteText2.tr,
              fontSize: SizeTitle.medium,
            ),
            const ColorPickerC(),
            const SizedBox(
              height: 10,
            ),
            mainTitle(
              title: 'Category',
              fontSize: SizeTitle.medium,
            ),
            const SizedBox(
              height: 5,
            ),
            mainTitle(
              title: Translator.addNoteText3.tr,
              fontSize: SizeTitle.medium,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFieldC(
                    controller: tagController,
                    hintText: Translator.addNoteText4.tr,
                    icon: Icons.tag,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (tagController.text != '') {
                      Get.find<Add_Notes_Controller>().addTag(tagController.text);
                      tagController.clear();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      color: settingsController.themeColor,
                    ),
                    width: 50,
                    height: 50,
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Get.find<Add_Notes_Controller>().tagsList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        Get.find<Add_Notes_Controller>().tagsList.removeAt(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: settingsController.themeColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        margin: const EdgeInsets.only(left: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Center(
                          child: Text(
                            '# ${Get.find<Add_Notes_Controller>().tagsList[index]}',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Expanded(
              child: Text(''),
            ),
            SheetButton(
                text: Translator.addNoteText5.tr,
                onTap: () {},
                onCancel: () {
                  titleController.clear();
                  Get.find<Add_Notes_Controller>().tagsList.clear();

                  Get.find<Add_Notes_Controller>().color = Colors.grey;
                }),
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
