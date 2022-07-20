import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pdf_maker/common/helper/ad_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreenController extends GetxController {
  RxBool isLoading = false.obs;
  String? uId, uName, uEmail, uPhotoUrl;

  late AdWidget? adWidget;

  late BannerAdListener listener;

  final AdManagerBannerAd myBanner = AdManagerBannerAd(
    adUnitId: AdHelper.bannerAdUnitId,
    sizes: [
      AdSize.banner,
    ],
    request: AdManagerAdRequest(),
    listener: AdManagerBannerAdListener(),
  );

  RequestConfiguration? requestConfiguration;

  // MobileAds().getRequestConfiguration();

  initAds() async {
    requestConfiguration = RequestConfiguration(
      // testDeviceIds: [
      //   "7DC439E3F9AB79A198A10BB10E256801"
      // ],
    );
    await MobileAds.instance.updateRequestConfiguration(requestConfiguration!);
  }

  @override
  void onInit() async {
    await getUserDetails();
    initAds();
    listener = BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) {
        print('Ad loaded.');
      },

      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.

        print('BannerAd failedToLoad: $error');
        myBanner.dispose();

        ad.dispose();
        print('Ad failed to load: $error');
      },

      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    );

    adWidget = AdWidget(
      ad: myBanner,
    );
    myBanner.load();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myBanner.dispose();

    super.dispose();
  }

  getUserDetails() async {
    isLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = prefs.getString('UserId') ?? '';
    uName = prefs.getString('UserName') ?? '';
    uEmail = prefs.getString('UserEmail') ?? '';
    uPhotoUrl = prefs.getString('UserPhoto') ?? '';

    if (kDebugMode) {
      print(
          'uId : $uId \nuName : $uName \nuEmail : $uEmail \nuPhotoUrl : $uPhotoUrl');
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
