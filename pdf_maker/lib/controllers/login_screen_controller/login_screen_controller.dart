import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pdf_maker/screens/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends GetxController {
  RxBool isLoading = false.obs;
  final FacebookLogin  plugin = FacebookLogin(debug: true);
  FacebookAccessToken? _token;
  FacebookUserProfile? profile1;
  String? _imageUrl;
  String? _email;
  FacebookUserProfile? profile;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateLoginInfo();
  }

  Future<void> updateLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final plugin1 = plugin;
    final token = await plugin1.accessToken;
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
      if(profile!.userId.isNotEmpty){
        String name = "${profile!.firstName} ${profile!.lastName!}";
         //email = plugin1.getUserEmail();
       // String photoUrl = plugin1.getProfileImageUrl(width: 100).toString();

        prefs.setString('UserId', profile!.userId);
        prefs.setString('UserName', name);
        prefs.setString('UserEmail', email!);
        prefs.setString('UserPhoto', imageUrl!.toString());
        prefs.setBool('isLoggedIn', true);

        String? id = prefs.getString('UserId');
        String? username = prefs.getString('UserName');
        String? useremail = prefs.getString('UserEmail');
        String? userphoto = prefs.getString('UserPhoto');
        print('id : $id \nusername : $username \nuseremail : $useremail \nuserphoto : $userphoto');
      }

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
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

      if (result.toString().isNotEmpty) {
        // All Details Save in Preference
        prefs.setString('UserId', result.user!.uid);
        prefs.setString('UserName', result.user!.displayName!);
        prefs.setString('UserEmail', result.user!.email!);
        prefs.setString('UserPhoto', result.user!.photoURL!);
        prefs.setBool('isLoggedIn', true);

        Get.off(() => HomeScreen());
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