import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

double _imageSize = 0.0;

// ignore: must_be_immutable
class SelectLanguage extends StatefulWidget {
  double height;
  String text1;
  String text2;
  Color borderColor;
  SelectLanguage(
      {required this.height,
      required this.text1,
      required this.text2,
      required this.borderColor,
      super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

String language = 'English';

class _SelectLanguageState extends State<SelectLanguage> {
  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    Color color = settingsController.isDark
        ? Colors.black
        : Colors.grey.shade100;
    _imageSize = MediaQuery.of(context).size.width / 2;
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    language = 'English';
                  });
                },
                child: Container(
                  width: _imageSize >= 150 ? 140 : _imageSize - 10,
                  height: _imageSize >= 150 ? widget.height : _imageSize - 40,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      width: 3,
                      color: language == 'English'
                          ? widget.borderColor
                          : color == Colors.black
                              ? Colors.black
                              : Colors.grey.shade100,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.text1,
                      style: TextStyle(
                        fontFamily: widget.text1 == 'English' ? 'Comic' : null,
                        fontSize: 18,
                        color:
                            color == Colors.black ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    language = 'فارسی';
                  });
                },
                child: Container(
                  width: _imageSize >= 150 ? 144 : _imageSize - 10,
                  height: _imageSize >= 150 ? widget.height : _imageSize - 40,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      width: 3,
                      color: language == 'فارسی'
                          ? widget.borderColor
                          : color == Colors.black
                              ? Colors.black
                              : Colors.grey.shade100,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.text2,
                      style: TextStyle(
                        fontFamily: widget.text2 == 'فارسی' ? 'IranSans' : null,
                        fontSize: 18,
                        color:
                            color == Colors.black ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
