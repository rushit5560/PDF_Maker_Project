import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/controllers/splash_screen_controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  final splashScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    print('Splash Screen On');
    return const Scaffold(
      // body: Image.asset(
      //   'assets/images/splash.jpg',
      //   // height: double.infinity,
      //   fit: BoxFit.cover,
      //   height: Get.height,
      // ),
      body: Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
