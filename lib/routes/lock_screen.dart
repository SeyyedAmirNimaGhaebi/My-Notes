import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/routes/settings_screen.dart';
import 'package:my_notes/widgets/passwordtextfield.dart';
import 'package:my_notes/widgets/sheet_button.dart';
import '../controllers/settings_controller.dart';
import '../widgets/listTileCustom.dart';

final settingsController = Get.find<SettingsController>();

class LockScreen extends StatelessWidget {
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = settingsController.primaryColor!;
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
          'Lock',
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
      body: GetBuilder<SettingsController>(
        builder: (controller) {
          return Column(
            children: [
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                from: 30,
                child: Container(
                  width: Get.width,
                  color: color,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      listTileCustom(
                        leading: Icons.password,
                        title: controller.password == '0' ? 'Set password' : 'Change password',
                        trailing: const SizedBox(
                          width: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        isSwitch: false,
                        onTap: () {
                          showButtonSheetSetPassword(controller.password == '0' ? false : true);
                        },
                        enable: true,
                      ),
                      line(),
                      listTileCustom(
                        leading: Icons.fingerprint,
                        title: 'Enable fingerprint',
                        trailing: Switch(
                          value: controller.biometric!,
                          activeColor: settingsController.themeColor,
                          trackOutlineColor: MaterialStatePropertyAll(
                            settingsController.notification!
                                ? settingsController.themeColor!.withOpacity(0.1)
                                : Colors.grey,
                          ),
                          inactiveTrackColor: Colors.transparent,
                          thumbColor: MaterialStatePropertyAll(
                            settingsController.notification!
                                ? settingsController.themeColor
                                : Colors.grey,
                          ),
                          onChanged: (value) {},
                        ),
                        isSwitch: true,
                        onTap: () {},
                        enable: controller.password == '0' ? false : true,
                      ),
                      line(),
                      listTileCustom(
                        leading: Icons.close,
                        title: 'Remove lock for all notes and categories',
                        trailing: const Text(''),
                        isSwitch: false,
                        onTap: () {
                          checkPassword();
                        },
                        enable: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showButtonSheetSetPassword(bool change) {
    Get.bottomSheet(
      SizedBox(
        height: change ? 350 : 280,
        child: GetBuilder<SettingsController>(
          builder: (controller) {
            return Column(
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
                Visibility(
                  visible: change,
                  child: TextFieldPassword(
                    hintText: 'Enter now password',
                    textController: controller.changePasswordController,
                    hidePin: 0,
                  ),
                ),
                Visibility(
                  visible: controller.error0,
                  child: const Text(
                    'passwordet eshebahe',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldPassword(
                  hintText: change ? 'Enter new password' : 'Enter password',
                  textController: controller.passwordController,
                  hidePin: 1,
                ),
                Visibility(
                  visible: controller.error1,
                  child: Text(
                    controller.passwordController!.text.isEmpty
                        ? 'Please enter your password'
                        : 'Please enter a stronger password',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldPassword(
                  hintText: change ? 'Re-enter new password' : 'Re-enter password',
                  textController: controller.passwordController2,
                  hidePin: 2,
                ),
                Visibility(
                  visible: controller.error2,
                  child: const Text(
                    'Please enter your password',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Visibility(
                  visible: controller.error2 ? false : controller.error3,
                  child: const Text(
                    'The password does not match',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const Expanded(
                  child: Text(''),
                ),
                SheetButton(
                  text: controller.password == '0' ? 'Set password' : 'Change password',
                  onTap: () {
                    if (change == false) {
                      controller.error1 =
                          controller.passwordController!.text.isEmpty ? true : false;
                      controller.error1 =
                          controller.passwordController!.text.length >= 4 ? false : true;

                      controller.error2 =
                          controller.passwordController2!.text.isEmpty ? true : false;

                      controller.error3 = controller.passwordController!.text ==
                              controller.passwordController2!.text
                          ? false
                          : true;
                      if (controller.error1 || controller.error2 || controller.error3) {
                      } else {
                        controller.password = controller.passwordController!.text;

                        controller.saveData();
                        controller.error1 = false;
                        controller.error2 = false;
                        controller.error3 = false;
                        controller.passwordController!.clear();
                        controller.passwordController2!.clear();

                        Get.back();
                      }
                      controller.update();
                    } else {
                      controller.error0 =
                          controller.changePasswordController!.text != controller.password
                              ? true
                              : false;
                      controller.error1 =
                          controller.passwordController!.text.isEmpty ? true : false;
                      controller.error1 =
                          controller.passwordController!.text.length >= 4 ? false : true;

                      controller.error2 =
                          controller.passwordController2!.text.isEmpty ? true : false;

                      controller.error3 = controller.passwordController!.text ==
                              controller.passwordController2!.text
                          ? false
                          : true;
                    }
                  },
                  onCancel: () {
                    controller.error1 = false;
                    controller.error2 = false;
                    controller.error3 = false;
                    controller.passwordController!.clear();
                    controller.passwordController2!.clear();
                  },
                ),
                const SizedBox(
                  height: 7,
                ),
              ],
            );
          },
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

void checkPassword() {
  Get.bottomSheet(
    SizedBox(
      height: 150,
      child: GetBuilder<SettingsController>(
        builder: (controller) {
          return Column(
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
                'Place enter your password',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldPassword(
                hintText: 'Pales enter password',
                textController: controller.passwordController2,
                hidePin: 2,
              ),
            ],
          );
        },
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
