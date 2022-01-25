import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/screens/home_screen/home_screen.dart';

class welcomeText extends StatelessWidget {
  const welcomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Welcome to Scan4PDF",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30, fontFamily: "", fontWeight: FontWeight.bold),
      ),
    );
  }
}

class socialLogin extends StatefulWidget {
  //const socialLogin({Key? key}) : super(key: key);
  final FacebookLogin  plugin = FacebookLogin(debug: true);

  @override
  _socialLoginState createState() => _socialLoginState();
}

class _socialLoginState extends State<socialLogin> {
  //Connectivity connectivity = Connectivity();
  FacebookAccessToken? _token;
  FacebookUserProfile? _profile;
  String? _imageUrl;
  String? _email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateLoginInfo();
  }

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
                      SizedBox(width: 15),
                      Text(
                        "Login With Google",
                        style: TextStyle(
                          fontFamily: "",
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
            _onPressedLogInButton().then((value) {
              if(_profile!.userId.isNotEmpty){
                Get.to(() => HomeScreen());
              }

            });
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
                      SizedBox(width: 15),
                      Text(
                        "Login With Facebook",
                        style: TextStyle(
                          fontFamily: "",
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
        SizedBox(height: 20,),

        GestureDetector(
          onTap: (){
            Get.to(() => HomeScreen());
          },
          child: Container(
            child: Text("Skip", style: TextStyle(
              fontFamily: "", fontSize: 19, decoration: TextDecoration.underline
            ),),
          ),
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
      User? user = result.user;

      if (result != null) {
        Get.to(() => HomeScreen());
      }
    }
  }

  Future<void> _onPressedLogInButton() async {
    await widget.plugin.logIn(
        permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    await _updateLoginInfo();
    await widget.plugin.logOut();
  }

  Future<void> _updateLoginInfo() async {
    final plugin = widget.plugin;
    final token = await plugin.accessToken;
    FacebookUserProfile? profile;
    String? email;
    String? imageUrl;

    if (token != null) {
      print("token===$token");
      profile = await plugin.getUserProfile();
      print("profile===$profile");
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin.getUserEmail();
      }
      imageUrl = await plugin.getProfileImageUrl(width: 100);
    }

    setState(() {
      _token = token;
      _profile = profile;
      _email = email;
      _imageUrl = imageUrl;
    });
  }
}
