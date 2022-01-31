import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/screens/home_screen/home_screen.dart';
import 'package:pdf_maker/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  bool? onBoardingValue = false;


  getOnBoardingValue() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    onBoardingValue = prefs.getBool("onboarding");

    if(onBoardingValue == true) {
      Get.off(() => HomeScreen());
    }
    else{
      Get.off(() => OnBoardingScreen());
    }
  }






  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print('Splash Controller Init Method');
    }
    Timer(const Duration(seconds: 1), () => getOnBoardingValue());
  }


}