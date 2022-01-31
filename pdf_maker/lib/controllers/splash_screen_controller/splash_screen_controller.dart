import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/screens/home_screen/home_screen.dart';
import 'package:pdf_maker/screens/login_screen/login_screen.dart';
import 'package:pdf_maker/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  bool? onBoardingValue = false;
  bool? isLoggedIn = false;


  getOnBoardingValue() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    onBoardingValue = prefs.getBool("onboarding");
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print('isLoggedIn : $isLoggedIn');

    if(onBoardingValue == true) {
      if(isLoggedIn == true){
        Get.off(() => HomeScreen());
      } else {
        Get.off(()=> LoginScreen());
      }
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
    Timer(const Duration(seconds: 2), () => getOnBoardingValue());
  }


}