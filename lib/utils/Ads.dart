import 'package:admob_flutter/admob_flutter.dart';
import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:facebook_audience_network/ad/ad_interstitial.dart';
import 'package:facebook_audience_network/ad/ad_rewarded.dart';
import 'package:flutter/cupertino.dart';
import 'package:guide_gaming/constances/Constances.dart';

import 'Intents.dart';

class Ads {
//  static banner() {
//    return AdmobBanner(
//      adUnitId: Constances.BANNER,
//      adSize: AdmobBannerSize.BANNER,
//      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
////            handleEvent(event, args, 'Banner');
//      },
//    );
//  }

  static AdmobInterstitial interstitialAd;

  static showInter(callBack) async {
    interstitialAd = AdmobInterstitial(
      adUnitId: Constances.INTER,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        if (event == AdmobAdEvent.closed ||
            event == AdmobAdEvent.failedToLoad) {
          callBack();
        }
      },
    );
    interstitialAd.load();
    interstitialAd.show();
  }

  static fbAdsBanner() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: FacebookBannerAd(
        placementId: "YOUR_PLACEMENT_ID",
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          switch (result) {
            case BannerAdResult.ERROR:
              print("Error: $value");
              break;
            case BannerAdResult.LOADED:
              print("Loaded: $value");
              break;
            case BannerAdResult.CLICKED:
              print("Clicked: $value");
              break;
            case BannerAdResult.LOGGING_IMPRESSION:
              print("Logging Impression: $value");
              break;
          }
        },
      ),
    );
  }

  static fbInterstitialAd(callBack) {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: Constances.INTER_FB,
      listener: (result, value) {
        print("Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED) {
          FacebookInterstitialAd.showInterstitialAd();
        }
        if (result == InterstitialAdResult.ERROR ||
            result == InterstitialAdResult.DISMISSED &&
                value["invalidated"] == true) {
          callBack("intent");
        } else {
          callBack("none");
        }
      },
    );
  }

  static fbRewardedVideoAd(data, callBack) {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) {
          FacebookRewardedVideoAd.showRewardedVideoAd();
          callBack("xu ly");
        }
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
          callBack("xu ly");
        }
        if (result == RewardedVideoAdResult.VIDEO_CLOSED && value == true) {
          Intents.startActivity(data["context"], data["data"],
              Constances.SLIDE_TRANSITION, Duration(milliseconds: 500));
          callBack("xu ly");
        }
      },
    );
  }
}
