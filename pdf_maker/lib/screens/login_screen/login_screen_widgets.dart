import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/controllers/login_screen_controller/login_screen_controller.dart';
import 'package:pdf_maker/screens/home_screen/home_screen.dart';

class welcomeText extends StatelessWidget {
  welcomeText({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Text(
      "Welcome to Scan4PDF",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}

class socialLogin extends StatelessWidget {
  final loginScreenController = Get.find<LoginScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            googleAuthentication(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 60,
              width: Get.width/1.5,
              decoration: borderGradientDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                  decoration: containerBackgroundGradient(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImgUrl.google,
                        scale: 2.5,
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "Login With Google",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: (){
            //facebookAuthentication(context);
            loginScreenController.isLoading(true);
            _onPressedLogInButton().then((value) {
              if(loginScreenController.profile1!.userId.isNotEmpty){
                Get.to(() => HomeScreen());
              }

            });
            loginScreenController.isLoading(false);
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 60,
              width: Get.width/1.5,
              decoration: borderGradientDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                  decoration: containerBackgroundGradient(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImgUrl.facebook,
                        scale: 2.5,
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "Login With Facebook",
                        style: TextStyle(

                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        GestureDetector(
          onTap: (){
            Get.off(() => HomeScreen());
          },
          child: const Text("Skip", style: TextStyle(
             fontSize: 19, decoration: TextDecoration.underline
          ),),
        )
      ],
    );
  }

  Future googleAuthentication(context) async {
    // try {
    //   googleSignInManager.signOut();
    //   final result = await googleSignInManager.signIn();
    //   if (result != null) {
    //     if (result.email != "") {
    //       Map params = {
    //         "userName": result.displayName ?? "",
    //         "emailId": result.email,
    //         "serviceName": 'GOOGLE',
    //         "uniqueId": "",
    //         "loginPassword": "",
    //       };
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => IndexScreen()),
    //       );
    //       // _socialLoginAPI(params, state.context);
    //       print("userName");
    //     } else {
    //       // commonMessageDialog(state.context,
    //       //     title: "Error",
    //       //     message:
    //       //     "Your Google account is not linked with email. Please signup and login with email and password.");
    //     }
    //   }
    // } catch (error) {
    //   print(error);
    // }
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
  }

  Future<void> _onPressedLogInButton() async {
    await loginScreenController.plugin.logIn(
        permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    await loginScreenController.updateLoginInfo();
    await loginScreenController.plugin.logOut();
  }


}
