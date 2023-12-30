// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_notes/bindings/bindings.dart';
import 'package:my_notes/constants.dart';
import 'package:my_notes/controllers/notification_settings_controller.dart';
import 'package:my_notes/controllers/nvigation_bar_controller.dart';
import 'package:my_notes/models/database.dart';
import 'package:my_notes/models/translator.dart';
import 'package:my_notes/routes/home.dart';
import 'package:my_notes/routes/intro_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

const String navigationActionId = 'id_3';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) async {
  if (notificationResponse.payload != 'test') {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(ToDosAdapter());
    await Hive.openBox<ToDos>(todoBoxName);
    Hive.registerAdapter(NotificationSettingsAdapter());
    await Hive.openBox<NotificationSettings>(notificationBoxName);

    var boxValue = Hive.box<ToDos>(todoBoxName);
    final todo = boxValue.values.firstWhere((todo) => todo.title == notificationResponse.payload);
    if (notificationResponse.actionId == 'complete') {
      todo.isCompleted = true;
      todo.hide = !todo.hide!;
      todo.save();
    } else {
      await _configureLocalTimeZone();
      var notification = Hive.box<NotificationSettings>(notificationBoxName).values.toList()[0];

      int snoozeValue = 5;
      switch (notification.snooze) {
        case 1:
          snoozeValue = 5;
          break;
        case 2:
          snoozeValue = 10;
          break;
        case 3:
          snoozeValue = 15;
          break;
        case 4:
          snoozeValue = 30;
          break;
      }

      final random = Random();
      int id = random.nextInt(999999999);
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        notification.isShowTitle! ? todo.title! : 'Reminder',
        notification.isShowDescription! ? todo.description! : '',
        tz.TZDateTime.now(tz.local).add(Duration(minutes: snoozeValue)),
        NotificationDetails(
          android: AndroidNotificationDetails(
            'alarm_clock_channel',
            'Alarm Clock Channel',
            channelDescription: 'Alarm Clock Notification',
            subText: 'todo',
            silent: notification.silent!,
            color: Colors.amber,
            colorized: true,
            ticker: todo.title!,
            actions: <AndroidNotificationAction>[
              const AndroidNotificationAction(
                'complete',
                'Completed',
              ),
              const AndroidNotificationAction(
                'snooze',
                'Snooze',
              ),
            ],
          ),
        ),
        androidScheduleMode: notification.hideAlarmIcon!
            ? AndroidScheduleMode.exactAllowWhileIdle
            : AndroidScheduleMode.alarmClock,
        payload: todo.title!,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureLocalTimeZone();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb && Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String initialRoute = MyApp.routeName;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload = notificationAppLaunchDetails!.notificationResponse?.payload;
    initialRoute = SecondPage.routeName;
  }

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ToDosAdapter());
  Hive.registerAdapter(SettingsDataAdapter());
  Hive.registerAdapter(CategoryTodoAdapter());
  Hive.registerAdapter(NotificationSettingsAdapter());
  await Hive.openBox<ToDos>(todoBoxName);
  await Hive.openBox<ToDos>(calendarBoxName);
  await Hive.openBox<CategoryTodo>(categoryTodoBoxName);
  await Hive.openBox<SettingsData>(settingsBoxName);
  await Hive.openBox<NotificationSettings>(notificationBoxName);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: <String, WidgetBuilder>{
        MyApp.routeName: (_) => MyApp(notificationAppLaunchDetails),
        SecondPage.routeName: (_) => SecondPage(selectedNotificationPayload)
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp(
    this.notificationAppLaunchDetails, {
    Key? key,
  }) : super(key: key);

  static const String routeName = '/';

  final NotificationAppLaunchDetails? notificationAppLaunchDetails;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  QuickActions quickActions = const QuickActions();

  @override
  void initState() {
    super.initState();
    _configureSelectNotificationSubject();
    quickActions.setShortcutItems(
      <ShortcutItem>[
        const ShortcutItem(
          type: "note",
          localizedTitle: "Notes",
          icon: "note",
        ),
        const ShortcutItem(
          type: "todo",
          localizedTitle: "Todos",
          icon: "todo",
        ),
        const ShortcutItem(
          type: "calendar",
          localizedTitle: "Calendar",
          icon: "calendar",
        ),
        const ShortcutItem(
          type: "settings",
          localizedTitle: "Settings",
          icon: "settings",
        ),
      ],
    );
    quickActions.initialize((type) {
      final controller = Get.find<NavigationBarController>();
      switch (type) {
        case 'note':
          controller.index.value = 0;
          break;
        case 'todo':
          controller.index.value = 1;
          break;
        case 'calendar':
          controller.index.value = 2;
          break;
        case 'settings':
          controller.index.value = 3;
          break;
      }
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      await Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => SecondPage(payload),
      ));
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isStarted = false;
    final box = Hive.box<SettingsData>(settingsBoxName);

    if (box.values.isNotEmpty) {
      isStarted = box.values.toList()[0].isStarted;
    }
    return GetMaterialApp(
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      translations: Translator(),
      initialBinding: MyBindings(),
      title: 'My Notes',
      home: isStarted ? const Home() : const IntroScreen(),
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
    );
  }
}

Future<void> zonedScheduleAlarmClockNotification({
  required Duration duration,
  required String title,
  required String message,
  required String payload,
  required String type,
}) async {
  //*Settings
  //Error
  final controller = Get.find<NotificationSettingsController>();
  final random = Random();
  int id = random.nextInt(999999999);
  if (duration.inMinutes > controller.taskReminderDefaultValue!) {
    duration -= Duration(minutes: controller.taskReminderDefaultValue!);
  }
  //*Show
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    controller.isShowTitle! ? title : 'Reminder',
    controller.isShowDescription! ? message : '',
    tz.TZDateTime.now(tz.local).add(duration),
    NotificationDetails(
      android: AndroidNotificationDetails(
        'alarm_clock_channel',
        'Alarm Clock Channel',
        channelDescription: 'Alarm Clock Notification',
        subText: type,
        silent: controller.silent!,
        color: Colors.amber,
        colorized: true,
        ticker: title,
        actions: <AndroidNotificationAction>[
          const AndroidNotificationAction(
            'complete',
            'Completed',
          ),
          const AndroidNotificationAction(
            'snooze',
            'Snooze',
          ),
        ],
      ),
    ),
    androidScheduleMode: controller.hideAlarmIcon!
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.alarmClock,
    payload: payload,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  );
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  print(timeZoneName);
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class SecondPage extends StatefulWidget {
  const SecondPage(
    this.payload, {
    Key? key,
  }) : super(key: key);

  static const String routeName = '/secondPage';

  final String? payload;

  @override
  State<StatefulWidget> createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  String? _payload;

  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Second Screen'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('payload ${_payload ?? ''}'),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back!'),
              ),
            ],
          ),
        ),
      );
}
