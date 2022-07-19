import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/controllers/login_screen_controller/login_screen_controller.dart';

import 'login_screen_widgets.dart';

class LoginScreen extends StatelessWidget {
  final loginScreenController = Get.put(LoginScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kLightBlueColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LogoModule(),
              SocialLoginModule(),
            ],
          ),
        ),
      ),
    );
  }
}
