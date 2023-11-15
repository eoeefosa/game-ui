import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:simplegame/src/ads/preloaded_banner_ads.dart';

class AdsController {
  final MobileAds _instance;
  PreloadedBannerAd? _preloadedBannerAd;

  AdsController({required MobileAds instance}) : _instance = instance;
  void dispose() {
    _preloadedBannerAd?.dispose();
  }

  Future<void> initialize() async {
    await _instance.initialize();
  }

  void preloadAd() {
    final adUnitId = defaultTargetPlatform == TargetPlatform ? '' : '';
    _preloadedBannerAd =
        PreloadedBannerAd(size: AdSize.mediumRectangle, adUnitId: adUnitId);
    Future<void>.delayed(const Duration(seconds: 1))
        .then((value) => _preloadedBannerAd!.load());
  }

  PreloadedBannerAd? takePreloadedAd() {
    final ad = _preloadedBannerAd;
    _preloadedBannerAd = null;
    return ad;
  }
}
