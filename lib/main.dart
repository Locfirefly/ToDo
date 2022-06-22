import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:taskmanager/Services/theme_services.dart';
import 'package:taskmanager/UI/home_page.dart';
import 'package:taskmanager/UI/theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'DB/Db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    Icon(FontAwesomeIcons.cloudMoon).toString()
    ,
    [NotificationChannel(
      channelGroupKey: 'test_channel',
      channelKey: 'test_channel',
      channelDescription: 'local nortification',
      channelName: 'local nortification',
      defaultColor: Colors.teal,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    ),
    ]
  );
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,

      home: HomePage()
    );
  }
}


