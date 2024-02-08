import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pdf_maker/common/helper/ad_helper.dart';
import 'package:pdf_maker/common/store_draft_data/store_draft_data.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool cropEnable = true.obs;
  RxBool isCropping = false.obs;
  RxList<File> captureImageList = RxList<File>();
  File? file;
  RxDouble rotation = 0.0.obs;
  RxInt crossAxisCount = 3.obs;
  RxDouble minScale = 1.0.obs;
  RxDouble maxScale = 5.0.obs;

  RxBool permissionGranted = false.obs;

  List<String> localList = [];
  LocalStorage localStorage = LocalStorage();
   InterstitialAd? interstitialAd ;

  late AdWidget? adWidget;

  late BannerAdListener listener;

  final AdManagerBannerAd myBanner = AdManagerBannerAd(
    adUnitId: AdHelper.bannerAdUnitId,
    sizes: [
      AdSize.banner,
    ],
    request: const AdManagerAdRequest(),
    listener: AdManagerBannerAdListener(),
  );

  RequestConfiguration? requestConfiguration;

  // MobileAds.getRequestConfiguration();

  initAds() async {
    requestConfiguration = RequestConfiguration(
      // testDeviceIds: [
      //   "7DC439E3F9AB79A198A10BB10E256801",
      // ],
    );
    await MobileAds.instance.updateRequestConfiguration(requestConfiguration!);
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a interstitial ad: ${err.message}');
        },
      ),
    );
    interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('%ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );
  }

  changeLayoutOnGesture(ScaleUpdateDetails details) {
    if (details.scale >= 1 && details.scale < 1.20) {
      crossAxisCount.value = 3;
    } else if (details.scale >= 1.20 && details.scale < 1.50) {
      crossAxisCount.value = 2;
    } else if (details.scale >= 1.50) {
      crossAxisCount.value = 1;
    } else if (details.scale < 1 && details.scale >= 0.70) {
      crossAxisCount.value = 4;
    } else if (details.scale < 0.70 && details.scale >= 0.40) {
      crossAxisCount.value = 5;
    } else if (details.scale < 0.40) {
      crossAxisCount.value = 6;
    }
  }

  loading() {
    isLoading(true);
    isLoading(false);
  }

  Future getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      permissionGranted.value = true;
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      permissionGranted.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();

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
    loadInterstitialAd();
    await getStoragePermission();
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }
}
