import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/controllers/login_screen_controller/login_screen_controller.dart';


class LogoModule extends StatelessWidget {
  LogoModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 160,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImgUrl.loginLogo)
        ),
      ),
    );
  }
}


class SocialLoginModule extends StatelessWidget {
  final loginScreenController = Get.find<LoginScreenController>();
  SocialLoginModule({Key? key}) : super(key: key);
  // FacebookUserProfile? profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              loginScreenController.googleAuthentication(context);
            },
            child: const GoogleButtonUIModule(),
          ),

          const SizedBox(height: 15),

          /*GestureDetector(
            onTap: () async {
              loginScreenController.isLoading(true);
              loginScreenController.onPressedLogInButton().then((value) {
                if(loginScreenController.profile!.userId.isNotEmpty){

                  Get.to(() => HomeScreen());
                }

              });
              loginScreenController.isLoading(false);
            },
            child: const FacebookButtonUIModule(),
          ),*/
          /*const SizedBox(height: 20),

          GestureDetector(
            onTap: () {
              Get.off(() => HomeScreen());
            },
            child: const Text(
              "Skip",
              style: TextStyle(
                fontSize: 19,
                decoration: TextDecoration.underline,
              ),
            ),
          ),*/
        ],
      ),
    );
  }

}

class GoogleButtonUIModule extends StatelessWidget {
  const GoogleButtonUIModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: shadowEffectDecoration(),
      child: Row(
        children: [
          Image.asset(
            ImgUrl.google,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Center(
              child: Text(
                  'LOGIN WITH GOOGLE',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FacebookButtonUIModule extends StatelessWidget {
  const FacebookButtonUIModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: shadowEffectDecoration(),
      child: Row(
        children: [
          Image.asset(
            ImgUrl.facebook,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Center(
              child: Text(
                  'LOGIN WITH FACEBOOK',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}