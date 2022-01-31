import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/controllers/splash_screen_controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  final splashScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kLightBlueColor,
      body: Center(
        child: Image.asset(
            ImgUrl.splashLogo,
          height: Get.width * 0.55,
          width: Get.width * 0.55,
        ),
      ),
    );
  }
}
