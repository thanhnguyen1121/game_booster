import 'package:admob_flutter/admob_flutter.dart';
import 'package:device_apps/device_apps.dart';
import 'package:guide_gaming/base/BasePresenter.dart';
import 'package:guide_gaming/base/BaseView.dart';
import 'package:guide_gaming/constances/Constances.dart';
import 'package:guide_gaming/utils/Ads.dart';
import 'package:guide_gaming/utils/CallNative.dart';
import 'package:guide_gaming/utils/Intents.dart';
import 'package:guide_gaming/utils/sharedPreferencesUtils.dart';

import 'AddAppBoosterViewModel.dart';

class AddAppBoosterPresenter implements BasePresenter {
  BaseView _view;
  AddAppBoosterViewModel _viewModel;
  AdmobInterstitial interstitialAd;

  AddAppBoosterPresenter() {
    CallNative.callFluterToNative("TRAKING", {"id": "Home"}, (result) {
      print("TRAKING" + result);
    });
    interstitialAd = AdmobInterstitial(
      adUnitId: Constances.INTER,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        if (event == AdmobAdEvent.closed ||
            event == AdmobAdEvent.failedToLoad) {
          Intents.goBack(guiVe);
          _viewModel.isLoadAds = false;
          _view.uiUpdate(_viewModel);
        }
      },
    );

    interstitialAd.load();
  }

  var guiVe;

  @override
  Future action(key, data) async {
    switch (key) {
      case Constances.INTENT_BACK:
        var dataSent = _viewModel.dataApp
            .where((element) => element["check"] == true)
            .toList();
        guiVe = {
          "context": data["context"],
          "data": {"data": dataSent}
        };

//        var x = Random().nextInt(2);
        var x = 0;
        if (x == 2) {
          _viewModel.isLoadAds = true;
          Ads.fbInterstitialAd((callBack) {
            print("callback:" + callBack.toString());
            if (callBack == "intent") {
              Intents.goBack(guiVe);
              _viewModel.isLoadAds = false;
              _view.uiUpdate(_viewModel);
            }
          });
        } else if (x == 0) {
          if (await interstitialAd.isLoaded) {
            _viewModel.isLoadAds = true;
            _view.uiUpdate(_viewModel);
            interstitialAd.show();
          } else {
            Intents.goBack(guiVe);
            _viewModel.isLoadAds = false;
            _view.uiUpdate(_viewModel);
          }
        } else {
          Intents.goBack(guiVe);
          _viewModel.isLoadAds = false;
          _view.uiUpdate(_viewModel);
        }

        break;
      case "CHANE_SATE_APP":
        this._viewModel.dataApp[data]['check'] =
            !this._viewModel.dataApp[data]['check'];

        break;
    }
    this._view.uiUpdate(_viewModel);
  }

  _checkSelected(data, listData) {
    for (int i = 0; i < listData.length; i++) {
      if (listData[i]["appName"] == data.appName) {
        return true;
      }
    }
    return false;
  }

  @override
  void init(view) {
    DeviceApps.getInstalledApplications(
            includeAppIcons: true,
            includeSystemApps: false,
            onlyAppsWithLaunchIntent: true)
        .then((data) {
      List<Application> apps = data;
      List<ApplicationWithIcon> listAppWithIcons = [];
      var dataApp = [];
      SharedPreferencesUtils.getData(Constances.BOSSTER_APP_SELECTED,
          (callBack) {
        if (callBack != null) {
          var listAppSelected = callBack;

          for (int i = 0; i < apps.length; i++) {
            ApplicationWithIcon applicationIcons =
                apps[i] as ApplicationWithIcon;
            var data = {
              "icon": applicationIcons.icon,
              "packageName": applicationIcons.packageName,
              "appName": applicationIcons.appName,
              "check": _checkSelected(applicationIcons, listAppSelected),
            };
            dataApp.add(data);
          }
        } else {
          for (int i = 0; i < apps.length; i++) {
            ApplicationWithIcon applicationIcons =
                apps[i] as ApplicationWithIcon;
            var data = {
              "icon": applicationIcons.icon,
              "packageName": applicationIcons.packageName,
              "appName": applicationIcons.appName,
              "check": false,
            };
            dataApp.add(data);
          }
        }
      });

      _viewModel = new AddAppBoosterViewModel(dataApp);
      _view = view;
      _view.uiUpdate(_viewModel);
    });
  }
}
