import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:news_api_rapid/view/home_screen.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();

 

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}
