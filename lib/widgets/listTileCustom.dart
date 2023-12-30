import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

// ignore: must_be_immutable
class listTileCustom extends StatelessWidget {
  IconData leading;
  String title;
  Widget trailing;
  bool isSwitch;
  VoidCallback onTap;
  bool enable;

  listTileCustom({
    required this.leading,
    required this.title,
    required this.trailing,
    required this.isSwitch,
    required this.onTap,
    required this.enable,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    return SizedBox(
      width: Get.width,
      height: 40,
      child: InkWell(
        onTap: enable ? onTap : null,
        child: Container(
          foregroundDecoration: BoxDecoration(
            color: enable ? null : settingsController.primaryColor!.withOpacity(0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  Icon(
                    leading,
                    size: 26,
                    color: const Color.fromRGBO(131, 131, 131, 1),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      color: settingsController.isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  trailing,
                  SizedBox(
                    width: isSwitch ? 0 : 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
