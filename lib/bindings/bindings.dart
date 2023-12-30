import 'package:get/get.dart';
import 'package:my_notes/controllers/calendar_controller.dart';
import 'package:my_notes/controllers/notes_controller.dart';
import 'package:my_notes/controllers/notification_settings_controller.dart';
import 'package:my_notes/controllers/nvigation_bar_controller.dart';
import 'package:my_notes/controllers/settings_controller.dart';
import 'package:my_notes/controllers/todos_controller.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationBarController());
    Get.lazyPut(() => Add_Notes_Controller());
    Get.put( SettingsController());
    Get.put(Todos_Controller());
    Get.put(Calendar_Controller());
    Get.put(NotificationSettingsController());
    
  }
  
  
}
