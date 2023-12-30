import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/controllers/todos_controller.dart';
import 'package:my_notes/models/translator.dart';

class SelectPriority extends StatelessWidget {
  final Add_Todos_Controller priorityController =
      Get.find<Add_Todos_Controller>();

  SelectPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: GetBuilder<Add_Todos_Controller>(builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () {
                  priorityController.selectPriority(0);
                },
                child: Container(
                  width: Get.width / 3 - 13,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(32, 195, 242, 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(Translator.todoText5.tr),
                      if (priorityController.prioritySelected[0])
                        Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 20,
                          ),
                        )
                      else
                        Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () {
                  priorityController.selectPriority(1);
                },
                child: Container(
                  width: Get.width / 3 - 13,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 139, 26, 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(Translator.todoText6.tr),
                      if (priorityController.prioritySelected[1])
                        Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 20,
                          ),
                        )
                      else
                        Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () {
                  priorityController.selectPriority(2);
                },
                child: Container(
                  width: Get.width / 3 - 13,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(122, 103, 255, 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(Translator.todoText7.tr),
                      if (priorityController.prioritySelected[2])
                        Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 20,
                          ),
                        )
                      else
                        Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
