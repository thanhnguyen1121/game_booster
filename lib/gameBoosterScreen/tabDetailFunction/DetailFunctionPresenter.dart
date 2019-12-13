import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guide_gaming/base/BasePresenter.dart';
import 'package:guide_gaming/base/BaseView.dart';
import 'package:guide_gaming/constances/Constances.dart';
import 'package:guide_gaming/utils/CallNative.dart';

import 'DetailFunctionViewModel.dart';

class DetailFunctionPresenter implements BasePresenter {
  BaseView _view;
  DetailFunctionViewModel _viewModel;

  DetailFunctionPresenter() {
    CallNative.callFluterToNative("TRAKING", {"id": "Home"}, (result) {
      print("TRAKING" + result);
    });
  }

  @override
  void action(key, data) {
    switch (key) {
      case Constances.CLICK_BOOSTER_RAM:
        CallNative.callFluterToNative(
            Constances.BOOSTER_RAM, {"data": "hihihi"}, (callBack) {
          var totalRam = double.parse(_viewModel.dataRam["totalMemory"]);
          var usedRam = int.parse(callBack.toString());
          _viewModel.freeRamAfterBooter = totalRam - usedRam;
          _viewModel.dataRam["freeMemory"] = callBack.toString();

          Fluttertoast.showToast(
              msg: "Ram boosted! Free Ram " +
                  _viewModel.freeRamAfterBooter.toString() +
                  " Mb",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          _view.uiUpdate(_viewModel);
        });
        break;
      case Constances.CLICK_NETWORK:
        print("netrwork");
//        CallNative.callFluterToNative("GET_NETWORK_SPEED", {"data": "aaa"},
//            (callBack) {
//          print("data:" + callBack.toString());
//        });
        Fluttertoast.showToast(
            msg: "Comming soon",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        break;
    }
  }

  @override
  void init(view) {
    CallNative.callFluterToNative(Constances.GET_RAM_ROM_INFO, {"data": "hihi"},
        (callBack) {
      if (callBack != null) {
        print("addd:" + callBack.toString());

        _view = view;
        _viewModel = new DetailFunctionViewModel(jsonDecode(callBack));
        _view.uiUpdate(_viewModel);
      } else {
        print("lỗi:");
      }

//      _view = view;
//      _viewModel = new DetailFunctionViewModel(MemoryInfo);
//      _view.uiUpdate(_viewModel);
    });
//    AndroidDeviceInfo().getMemoryInfo().then((MemoryInfo) {
//      print("aaaaaaaa: " + MemoryInfo.toString());
//      _view = view;
//      _viewModel = new DetailFunctionViewModel(MemoryInfo);
//      _view.uiUpdate(_viewModel);
//    });
  }
}
