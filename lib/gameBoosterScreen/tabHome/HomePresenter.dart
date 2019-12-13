import 'dart:convert';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:guide_gaming/base/BasePresenter.dart';
import 'package:guide_gaming/base/BaseView.dart';
import 'package:guide_gaming/constances/Constances.dart';
import 'package:guide_gaming/utils/Ads.dart';
import 'package:guide_gaming/utils/CallNative.dart';
import 'package:guide_gaming/utils/Intents.dart';
import 'package:guide_gaming/utils/sharedPreferencesUtils.dart';

import 'AddAppBooster/AddAppBoosterComponent.dart';
import 'HomeViewModel.dart';

class HomePresenter implements BasePresenter {
  BaseView _view;
  HomeViewModel _viewModel;
  var data;

  AdmobInterstitial interstitialAd;

  HomePresenter() {
    CallNative.callFluterToNative("TRAKING", {"id": "Home"}, (result) {
      print("TRAKING" + result);
    });
    interstitialAd = AdmobInterstitial(
      adUnitId: Constances.INTER,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        if (event == AdmobAdEvent.closed ||
            event == AdmobAdEvent.failedToLoad) {
          CallNative.callFluterToNative(
              Constances.BOOSTER, {"id": data["launch_app"]}, (callBack) {});
          _viewModel.isLoadAds = false;
          _viewModel.showProcess = false;
          _view.uiUpdate(_viewModel);
        }
      },
    );

    interstitialAd.load();
  }

  @override
  Future action(key, data) async {
    this.data = data;
    var context = data["context"];
    switch (key) {
      case Constances.GET_ALL_APP_FROM_SYSTEM:
        CallNative.removeBroadcastStream();
        Intents.startActivityForResult(
            context,
            new AddAppBoosterComponent(),
            Constances.SCALE_FADE_TRANSITION,
            new Duration(milliseconds: 500), (dataBack) {
          if (dataBack["data"] != null) {
            SharedPreferencesUtils.setData(
                Constances.BOSSTER_APP_SELECTED, dataBack["data"]);
            _viewModel.listAppBoosterSelected = dataBack["data"];
            _view.uiUpdate(_viewModel);
          }
        });
        break;

      case Constances.LAUNCH_APP:
//        var x = Random().nextInt(2);

        _viewModel.showProcess = true;
        _view.uiUpdate(_viewModel);
        Future.delayed(new Duration(milliseconds: 2500), () async {
          var x = 2;
          if (x == 1) {
            _viewModel.isLoadAds = true;
            Ads.fbInterstitialAd((callBack) {
              print("callback:" + callBack.toString());
              if (callBack == "intent") {
                CallNative.callFluterToNative(Constances.BOOSTER,
                    {"id": data["launch_app"]}, (callBack) {});
                _viewModel.showProcess = false;
                _viewModel.isLoadAds = false;
                _view.uiUpdate(_viewModel);
              }
            });
          } else if (x == 2) {
            if (await interstitialAd.isLoaded) {
              _viewModel.isLoadAds = true;
              _view.uiUpdate(_viewModel);
              interstitialAd.show();
            } else {
              CallNative.callFluterToNative(Constances.BOOSTER,
                  {"id": data["launch_app"]}, (callBack) {});
              _viewModel.showProcess = false;
              _viewModel.isLoadAds = false;
              _view.uiUpdate(_viewModel);
            }
          } else {
            CallNative.callFluterToNative(
                Constances.BOOSTER, {"id": data["launch_app"]}, (callBack) {});
            _viewModel.showProcess = false;
            _viewModel.isLoadAds = false;
            _view.uiUpdate(_viewModel);
          }
        });
        break;
    }
  }

  @override
  void init(view) {
    var dataApp = [];
    SharedPreferencesUtils.getData(Constances.BOSSTER_APP_SELECTED, (callBack) {
      if (callBack != null) {
        print("data app save: " + callBack.toString());
        dataApp = callBack;
      }
      CallNative.receiveBroadcastStream((callBack) {
        if (callBack != null) {
          var data = jsonDecode(callBack);
          _viewModel = new HomeViewModel(data, dataApp);
          _view = view;
          _view.uiUpdate(_viewModel);
        }
      });
    });
  }
}
