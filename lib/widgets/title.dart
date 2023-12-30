import 'package:flutter/material.dart';

enum SizeTitle {
  small,
  medium,
  large,
}

Widget mainTitle({required String title,required SizeTitle fontSize, Color? textColor}) {
    double size = 0;
  switch (fontSize) {
    case SizeTitle.small:
      size = 16;
      break;
    case SizeTitle.medium:
      size = 19;
      break;
    case SizeTitle.large:
      size = 22;
      break;
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(
        width: 8,
      ),
      Text(
        title,
        style: TextStyle(fontSize: size,color: textColor),
      ),
    ],
  );
}
