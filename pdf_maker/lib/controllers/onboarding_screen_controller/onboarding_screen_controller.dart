import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/models/onboarding_screen_model/onboarding_screen_model.dart';
import 'package:pdf_maker/screens/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf_maker/common/img_url.dart';

class OnBoardingScreenController extends GetxController {

  var selectedPageIndex = 0.obs;

  var pageController = PageController();
  bool get isLastPage => selectedPageIndex.value == onBoardingPages.length - 1;

  forwardAction() {
    if(isLastPage){
      setOnBoardingValue();
      Get.off(() => LoginScreen());
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnBoardingInfo> onBoardingPages= [
    OnBoardingInfo(
      imageAsset: ImgUrl.service1,
      title: 'Dummy Text',
      description: 'Dummy Text Dummy Text Dummy Text Dummy Text Dummy Text Dummy Text Dummy Text Dummy Text',
    ),
    OnBoardingInfo(
      imageAsset: ImgUrl.service2,
      title: 'Dummy Text',
      description: 'Dummy Text Dummy Text Dummy Text Dummy Text Dummy Text Dummy Text Dummy Text Dummy Text',
    ),
    OnBoardingInfo(
      imageAsset: ImgUrl.service3,
      title: 'Dummy Text',
      description: 'Dummy Text Dummy Text Dummy Text Dummy Text Dummy Text Dummy Text Dummy Text Dummy Text',
    ),
  ];

  setOnBoardingValue() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    prefs.setBool("onboarding", true);
  }


}