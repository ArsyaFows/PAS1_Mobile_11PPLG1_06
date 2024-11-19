import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_06/menus/sport/sportView.dart';
import 'package:pas1_mobile_11pplg1_06/menus/favorite/favorite.dart';
import 'package:pas1_mobile_11pplg1_06/menus/profile/profile.dart';
import '../Binding/binding.dart';
import '../Login/logView.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await getDatabasesPath();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: '/', page: () => LogView()),
        GetPage(name: '/login', page: () => LogView()),
        GetPage(
          name: '/sport',
          page: () => SportView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/favorite',
          page: () => FavoritePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/profile',
          page: () => Profile(),
          binding: HomeBinding(),
        ),
      ],
      initialRoute: '/',
    );
  }
}
