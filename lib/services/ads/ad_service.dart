import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  /// Initialize Mobile Ads SDK
  Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  // -------------------------------
  // TEST AD UNIT IDS
  // -------------------------------
  final String bannerAdUnit = Platform.isAndroid ? "ca-app-pub-5627324410826009~9647302957" : "ca-app-pub-5627324410826009/2032343294";
  final String interstitialAdUnit = Platform.isAndroid ? "ca-app-pub-5627324410826009~9647302957" : "ca-app-pub-5627324410826009/3808459399";
  final String nativeAdUnit = Platform.isAndroid ? "ca-app-pub-5627324410826009~9647302957" : "ca-app-pub-5627324410826009/8469952654";


  // -------------------------------
  // BANNER AD
  // -------------------------------
  BannerAd? bannerAd;

  Future<void> loadBanner() async {
    bannerAd = BannerAd(
      adUnitId: bannerAdUnit,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => print("Banner Loaded"),
        onAdFailedToLoad: (ad, err) {
          print("Banner Load Failed: ${err.message}");
          ad.dispose();
        },
      ),
    );

    await bannerAd!.load();
  }

  void disposeBanner() {
    bannerAd?.dispose();
  }

  // -------------------------------
  // INTERSTITIAL AD
  // -------------------------------
  InterstitialAd? _interstitialAd;

  Future<void> loadInterstitial() async {
    await InterstitialAd.load(
      adUnitId: interstitialAdUnit,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print("Interstitial Loaded");
          _interstitialAd = ad;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (err) {
          print("Interstitial Failed: ${err.message}");
        },
      ),
    );
  }

  void showInterstitial() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
    } else {
      print("Interstitial not ready");
      loadInterstitial();
    }
  }


  // -------------------------------
  // NATIVE AD
  // -------------------------------
  static NativeAd? nativeAd;
  static RxBool isNativeAdLoaded = false.obs;
  static NativeAd? nativeBannerAd;
  static RxBool isNativeBannerAdLoaded = false.obs;

  static void loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: Platform.isAndroid ? "ca-app-pub-5627324410826009~9647302957" : "ca-app-pub-5627324410826009/8469952654",
      factoryId: "factoryId",
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          print("Native Ad Loaded");
          isNativeAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          print("Native Ad Failed: $error");
          isNativeAdLoaded.value = false;
          // ad.dispose();

          // Retry
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium, // small/medium
      ),
    );
    nativeAd!.load();
  }

  static void loadNativeBannerAd() {
    nativeBannerAd = NativeAd(
      adUnitId: Platform.isAndroid ? "ca-app-pub-5627324410826009~9647302957" : "ca-app-pub-5627324410826009/8469952654",
      factoryId: "factoryId",
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          print("Native Ad Loaded");
          isNativeBannerAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          print("Native Ad Failed: $error");
          isNativeBannerAdLoaded.value = false;
          // ad.dispose();

          // Retry
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small, // small/medium
      ),
    );
    nativeBannerAd!.load();
  }

  static void disposeNativeAd() {
    nativeAd?.dispose();
    nativeAd = null;
    isNativeAdLoaded.value = false;
  }

  static void disposeNativeBannerAd() {
    isNativeBannerAdLoaded.value = false;
    nativeBannerAd?.dispose();
    nativeBannerAd = null;
  }


}
