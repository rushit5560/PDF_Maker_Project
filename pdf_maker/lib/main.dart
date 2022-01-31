import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/screens/splash_screen/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Final Demo - New Implementation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColor.kDarkBlueColor,
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
          ),
        // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        //   backgroundColor: AppColor.kDarkBlueColor
        // ),
      ),
      home: SplashScreen(),
    );
  }
}


