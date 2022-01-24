import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Final Demo - New Implementation',
      home: SplashScreen(),
    );
  }
}
