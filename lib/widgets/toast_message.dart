import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../routes/home.dart';

void showToastMessage({
  required String message,
  required IconData? icon,
  required Color? color,
  required Color? foregroundColor,
  required ToastGravity toastGravity,
  required BuildContext context,
}) {
  Color color0 =  settingsController.isDark ? Colors.black : Colors.white;
  Color foregroundColor0 = settingsController.isDark ? Colors.white : Colors.black;
  final toast = FToast();
  toast.init(context);

  Widget toastWidget = Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    margin: const EdgeInsets.only(bottom: 100),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: color ?? color0,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 0.7,
          offset: Offset(0, 3),
        )
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon != null
            ? Icon(
                icon,
                color: foregroundColor ?? foregroundColor0,
              )
            : const Text(''),
        icon != null
            ? const SizedBox(
                width: 8,
              )
            : const Text(''),
        Text(
          message,
          style: TextStyle(color: foregroundColor ?? foregroundColor0, fontSize: 16),
        ),
      ],
    ),
  );
  toast.showToast(
    child: toastWidget,
    toastDuration: const Duration(milliseconds: 1500),
    gravity: toastGravity,
  );
}
