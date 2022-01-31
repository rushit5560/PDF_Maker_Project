import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/controllers/login_screen_controller/login_screen_controller.dart';
import 'package:pdf_maker/screens/home_screen/home_screen.dart';


class LogoModule extends StatelessWidget {
  LogoModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 160,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImgUrl.splashLogo)
        ),
      ),
    );
  }
}


class SocialLoginModule extends StatelessWidget {
  final loginScreenController = Get.find<LoginScreenController>();
  SocialLoginModule({Key? key}) : super(key: key);

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

          GestureDetector(
            onTap: (){
              loginScreenController.isLoading(true);
              loginScreenController.onPressedLogInButton().then((value) {
                if(loginScreenController.profile1!.userId.isNotEmpty){
                  Get.to(() => HomeScreen());
                }

              });
              loginScreenController.isLoading(false);
            },
            child: const FacebookButtonUIModule(),
          ),
          const SizedBox(height: 20),

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
          ),
        ],
      ),
    );
  }



  /*Future googleAuthentication(context) async {
    loginScreenController.isLoading(true);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      // User? user = result.user;

      if (result.toString().isNotEmpty) {
        Get.to(() => HomeScreen());
      }
    }
    loginScreenController.isLoading(false);
  }*/

  /*Future<void> _onPressedLogInButton() async {
    await loginScreenController.plugin.logIn(
        permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    await loginScreenController.updateLoginInfo();
    await loginScreenController.plugin.logOut();
  }*/


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