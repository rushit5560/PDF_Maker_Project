import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // await Firebase.initializeApp();
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
        dialogTheme: const DialogTheme(
          backgroundColor: AppColor.kLightBlueColor,
          elevation: 10,
          contentTextStyle: TextStyle(
            color: AppColor.kDarkBlueColor,
          ),
          titleTextStyle: TextStyle(color: AppColor.kDarkBlueColor),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          primary: AppColor.kDarkBlueColor,
        )),
      ),
      home: SplashScreen(),
    );
  }
}
