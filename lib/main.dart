import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/utills/localzation.dart';
import 'package:haider/views/choosescreen.dart';
import 'package:haider/views/drawerScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,

    statusBarColor: Colors.white, // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var box;
  @override
  void initState() {
    super.initState();
    box = GetStorage().read('name');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      locale: const Locale('ar', 'EG'),
      // fallbackLocale: const Locale('ar', 'EG'),
      // onInit: () => AddPropertyController(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: box == null ? EnterInfo() : NavDrawerScreen(),
    );
  }
}
