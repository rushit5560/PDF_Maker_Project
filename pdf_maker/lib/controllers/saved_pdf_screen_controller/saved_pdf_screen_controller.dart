import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pdf_maker/common/helper/ad_helper.dart';
import 'package:pdf_maker/common/store_draft_data/store_draft_data.dart';

class SavedPdfScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  LocalStorage localStorage = LocalStorage();
  RxList<String> storeImageList = RxList();
  RxList<String> storePdfList = RxList();
  late TabController tabController;

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

  getStorageImages() async {
    isLoading(true);
    storeImageList.value = await localStorage.getStorageImageList();
    if (storeImageList.isEmpty) {
      storeImageList.value = [];
    }
    isLoading(false);
  }

  getStoragePdfs() async {
    isLoading(true);
    storePdfList.value = await localStorage.getStoragePdfList();
    isLoading(false);
  }

  updateStorageImages(int i) async {
    isLoading(true);
    storeImageList.removeAt(i);
    print('Remove at $i : $storeImageList');
    await localStorage.updateStorageImageList(storeImageList);
    getStorageImages();
    isLoading(false);
  }

  updateStoragePdfs(int i) async {
    isLoading(true);
    storePdfList.removeAt(i);
    print('Remove at $i : $storePdfList');
    localStorage.updateStoragePdfList(storePdfList);
    getStoragePdfs();
    isLoading(false);
  }

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    getStorageImages();
    getStoragePdfs();
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
    tabController.dispose();
    super.dispose();
  }

  loading() {
    isLoading(true);
    isLoading(false);
  }
}
