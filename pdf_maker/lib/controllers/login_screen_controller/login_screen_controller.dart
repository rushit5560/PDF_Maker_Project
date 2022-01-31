import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pdf_maker/screens/home_screen/home_screen.dart';

class LoginScreenController extends GetxController {
  RxBool isLoading = false.obs;
  final FacebookLogin  plugin = FacebookLogin(debug: true);
  FacebookAccessToken? _token;
  FacebookUserProfile? profile1;
  String? _imageUrl;
  String? _email;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateLoginInfo();
  }

  Future<void> updateLoginInfo() async {
    final plugin1 = plugin;
    final token = await plugin1.accessToken;
    FacebookUserProfile? profile;
    String? email;
    String? imageUrl;

    if (token != null) {
      print("token===$token");
      profile = await plugin1.getUserProfile();
      print("profile===$profile");
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin1.getUserEmail();
      }
      imageUrl = await plugin1.getProfileImageUrl(width: 100);
    }

    //setState(() {
      _token = token;
      profile1 = profile;
      _email = email;
      _imageUrl = imageUrl;
    //});
  }

  Future googleAuthentication(context) async {
    isLoading(true);
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
    isLoading(false);
  }

  Future<void> onPressedLogInButton() async {
    await plugin.logIn(
        permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ]);
    await updateLoginInfo();
    await plugin.logOut();
  }

}