import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/models/onboarding_screen_model/onboarding_screen_model.dart';
import 'package:pdf_maker/screens/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      title: 'Welcome Scan4PDF With Camera Scanner',
      description: 'Scan documents in high quality using an app. Scan4PDF is the most well-known document scanner app. So now enjoy the perfect scan using our app!!',
    ),
    OnBoardingInfo(
      imageAsset: ImgUrl.service2,
      title: 'Image To PDF Converter',
      description: "It's an excellent app for an image to PDF converter.  Easy to create a PDF file from multiple images. And also, Print your document directly from our scanner application.",
    ),
    OnBoardingInfo(
      imageAsset: ImgUrl.service3,
      title: 'Merge PDF',
      description: 'This app can quickly merge multiple PDFs into one document. You can upload two documents or more and combine them with a single click.',
    ),
  ];

  setOnBoardingValue() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    prefs.setBool("onboarding", true);
  }

}