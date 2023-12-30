import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/models/translator.dart';

Color NoteColor = Colors.grey;
String ColorName = 'Select color';

class ColorPickerC extends StatefulWidget {
  const ColorPickerC({super.key});

  @override
  State<ColorPickerC> createState() => _ColorPickerCState();
}

class _ColorPickerCState extends State<ColorPickerC> {
  @override
  void initState() {
    ColorName = Translator.addNoteText7.tr;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ColorWidget(
                    const Color.fromRGBO(255, 185, 0, 1), Translator.color1.tr),
                ColorWidget(
                    const Color.fromRGBO(255, 140, 0, 1), Translator.color2.tr),
                ColorWidget(
                    const Color.fromRGBO(247, 99, 12, 1), Translator.color3.tr),
                ColorWidget(
                    const Color.fromRGBO(202, 80, 16, 1), Translator.color4.tr),
                ColorWidget(
                    const Color.fromRGBO(218, 59, 1, 1), Translator.color5.tr),
                ColorWidget(const Color.fromRGBO(239, 105, 80, 1),
                    Translator.color6.tr),
                ColorWidget(
                    const Color.fromRGBO(209, 52, 56, 1), Translator.color7.tr),
                ColorWidget(
                    const Color.fromRGBO(255, 67, 67, 1), Translator.color8.tr),
                ColorWidget(
                    const Color.fromRGBO(231, 72, 86, 1), Translator.color9.tr),
                ColorWidget(const Color.fromRGBO(232, 17, 35, 1),
                    Translator.color10.tr),
                ColorWidget(
                    const Color.fromRGBO(234, 0, 94, 1), Translator.color11.tr),
                ColorWidget(
                    const Color.fromRGBO(195, 0, 82, 1), Translator.color12.tr),
                ColorWidget(const Color.fromRGBO(227, 0, 140, 1),
                    Translator.color13.tr),
                ColorWidget(const Color.fromRGBO(191, 0, 119, 1),
                    Translator.color14.tr),
                ColorWidget(const Color.fromRGBO(194, 57, 179, 1),
                    Translator.color15.tr),
                ColorWidget(const Color.fromRGBO(154, 0, 137, 1),
                    Translator.color16.tr),
                ColorWidget(const Color.fromRGBO(0, 120, 215, 1),
                    Translator.color17.tr),
                ColorWidget(
                    const Color.fromRGBO(0, 99, 177, 1), Translator.color18.tr),
                ColorWidget(const Color.fromRGBO(142, 140, 216, 1),
                    Translator.color19.tr),
                ColorWidget(const Color.fromRGBO(107, 105, 214, 1),
                    Translator.color20.tr),
                ColorWidget(const Color.fromRGBO(135, 100, 184, 1),
                    Translator.color21.tr),
                ColorWidget(const Color.fromRGBO(116, 77, 169, 1),
                    Translator.color22.tr),
                ColorWidget(const Color.fromRGBO(177, 70, 194, 1),
                    Translator.color23.tr),
                ColorWidget(const Color.fromRGBO(136, 23, 152, 1),
                    Translator.color24.tr),
                ColorWidget(const Color.fromRGBO(0, 153, 188, 1),
                    Translator.color25.tr),
                ColorWidget(const Color.fromRGBO(45, 125, 154, 1),
                    Translator.color26.tr),
                ColorWidget(const Color.fromRGBO(0, 183, 195, 1),
                    Translator.color27.tr),
                ColorWidget(const Color.fromRGBO(3, 131, 135, 1),
                    Translator.color28.tr),
                ColorWidget(const Color.fromRGBO(0, 178, 148, 1),
                    Translator.color29.tr),
                ColorWidget(const Color.fromRGBO(1, 133, 116, 1),
                    Translator.color30.tr),
                ColorWidget(const Color.fromRGBO(0, 204, 106, 1),
                    Translator.color31.tr),
                ColorWidget(const Color.fromRGBO(16, 137, 62, 1),
                    Translator.color32.tr),
                ColorWidget(const Color.fromRGBO(122, 117, 116, 1),
                    Translator.color33.tr),
                ColorWidget(
                    const Color.fromRGBO(93, 90, 88, 1), Translator.color34.tr),
                ColorWidget(const Color.fromRGBO(104, 118, 138, 1),
                    Translator.color35.tr),
                ColorWidget(const Color.fromRGBO(81, 92, 107, 1),
                    Translator.color36.tr),
                ColorWidget(const Color.fromRGBO(86, 124, 115, 1),
                    Translator.color37.tr),
                ColorWidget(const Color.fromRGBO(72, 104, 96, 1),
                    Translator.color38.tr),
                ColorWidget(
                    const Color.fromRGBO(73, 130, 5, 1), Translator.color39.tr),
                ColorWidget(const Color.fromRGBO(16, 124, 16, 1),
                    Translator.color40.tr),
                ColorWidget(const Color.fromRGBO(118, 118, 118, 1),
                    Translator.color41.tr),
                ColorWidget(
                    const Color.fromRGBO(76, 74, 72, 1), Translator.color42.tr),
                ColorWidget(const Color.fromRGBO(105, 121, 126, 1),
                    Translator.color43.tr),
                ColorWidget(
                    const Color.fromRGBO(74, 84, 89, 1), Translator.color44.tr),
                ColorWidget(const Color.fromRGBO(100, 124, 100, 1),
                    Translator.color45.tr),
                ColorWidget(
                    const Color.fromRGBO(80, 92, 82, 1), Translator.color46.tr),
                ColorWidget(const Color.fromRGBO(132, 117, 69, 1),
                    Translator.color47.tr),
                ColorWidget(const Color.fromRGBO(126, 115, 95, 1),
                    Translator.color48.tr),
                ColorWidget(Colors.white, Translator.color49.tr),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget ColorWidget(Color color, String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          NoteColor = color;
          ColorName = name;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: color,
            width: 1,
          ),
        ),
      ),
    );
  }
}
