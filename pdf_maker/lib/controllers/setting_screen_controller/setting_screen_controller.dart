import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreenController extends GetxController {
  RxBool isLoading = false.obs;
  String? uId, uName, uEmail, uPhotoUrl;

  @override
  void onInit() async {
    await getUserDetails();
    super.onInit();
  }

  getUserDetails() async {
    isLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = prefs.getString('UserId') ?? '';
    uName = prefs.getString('UserName') ?? '';
    uEmail = prefs.getString('UserEmail') ?? '';
    uPhotoUrl = prefs.getString('UserPhoto') ?? '';

    if (kDebugMode) {
      print('uId : $uId \nuName : $uName \nuEmail : $uEmail \nuPhotoUrl : $uPhotoUrl');
    }
    isLoading(false);
  }

  clearUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('UserId');
    prefs.remove('UserName');
    prefs.remove('UserEmail');
    prefs.remove('UserPhoto');
    prefs.setBool('isLoggedIn', false);
  }
}