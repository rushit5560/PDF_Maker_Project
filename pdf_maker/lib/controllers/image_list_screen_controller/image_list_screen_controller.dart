import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pdf_maker/common/helper/ad_helper.dart';

class ImageListScreenController extends GetxController{


  late AdWidget? adWidget;

  late BannerAdListener listener;
  late RewardedAd rewardedAd;

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              loadRewardedAd();
            },
          );
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

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
      testDeviceIds: [
        "7DC439E3F9AB79A198A10BB10E256801",
      ],
    );
    await MobileAds.instance.updateRequestConfiguration(requestConfiguration!);
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
    loadRewardedAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myBanner.dispose();

    super.dispose();
  }
}