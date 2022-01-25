import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/controllers/login_screen_controller/login_screen_controller.dart';
import 'package:pdf_maker/screens/login_screen/login_screen_widgets.dart';

class LoginScreen extends StatelessWidget {
  final loginScreenController = Get.put(LoginScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const MainBackgroundWidget(),

          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                welcomeText(),

                socialLogin()
              ],
            ),
          )

        ],
      ),
    );
  }
}
