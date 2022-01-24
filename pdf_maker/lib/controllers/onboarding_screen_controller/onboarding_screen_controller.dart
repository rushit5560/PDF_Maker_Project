import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/models/onboarding_screen_model/onboarding_screen_model.dart';
import 'package:pdf_maker/screens/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreenController extends GetxController {

  var selectedPageIndex = 0.obs;

  var pageController = PageController();
  bool get isLastPage => selectedPageIndex.value == onBoardingPages.length - 1;

  forwardAction() {
    if(isLastPage){
      setOnBoardingValue();
      Get.off(() => HomeScreen());
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnBoardingInfo> onBoardingPages= [
    OnBoardingInfo(
      imageAsset: 'assets/images/service1.png',
      title: 'Sports Accessories',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing slit. Morbi dapibus, sem vel dapibus pellentesque, tellus lectus',
    ),
    OnBoardingInfo(
      imageAsset: 'assets/images/service2.png',
      title: 'Sports Clothes',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing slit. Morbi dapibus, sem vel dapibus pellentesque, tellus lectus',
    ),
    OnBoardingInfo(
      imageAsset: 'assets/images/service3.png',
      title: 'Sports Shoes',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing slit. Morbi dapibus, sem vel dapibus pellentesque, tellus lectus',
    ),
  ];

  setOnBoardingValue() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    prefs.setBool("onboarding", true);
  }


}