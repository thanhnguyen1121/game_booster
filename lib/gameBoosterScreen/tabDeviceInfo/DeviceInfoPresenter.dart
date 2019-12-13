import 'dart:convert';

import 'package:android_device_info/android_device_info.dart';
import 'package:guide_gaming/base/BasePresenter.dart';
import 'package:guide_gaming/base/BaseView.dart';
import 'package:guide_gaming/constances/Constances.dart';
import 'package:guide_gaming/utils/CallNative.dart';

import 'DeviceInfoViewModel.dart';

class DeviceInfoPresenter implements BasePresenter {
  BaseView _view;
  DeviceInfoViewModel _viewModel;

  DeviceInfoPresenter() {
    CallNative.callFluterToNative("TRAKING", {"id": "Home"}, (result) {
      print("TRAKING" + result);
    });
  }

  @override
  void action(key, data) {
    // TODO: implement action
    switch (key) {
      case Constances.GET_SYSTEM_INFO:
        break;
    }
  }

  _getData() async {
    var batteryInfo = await AndroidDeviceInfo().getBatteryInfo();
    print("aaaaa:" + batteryInfo.toString());
    var memory = await AndroidDeviceInfo().getMemoryInfo();
    print("aaaaa:" + memory.toString());
    var displau = await AndroidDeviceInfo().getDisplayInfo();
    print("aaaa:" + displau.toString());
  }

  @override
  void init(view) {
    var dataDeviceSystem;
    var dataDeviceMemory = [];
    var dataDeviceBatterry = [];
    CallNative.callFluterToNative(
        Constances.GET_SYSTEM_INFO, {"ahihi": "ahiihihi"}, (callBack) {
      if (callBack != null) {
//        dataDeviceSystem = jsonDecode(callBack);
//        dataDeviceSystem = jsonDecode(callBack.toString());
//        print("daaaa:" + dataDeviceSystem["model"].toString());
        AndroidDeviceInfo().getBatteryInfo().then((BatteryInfo) {
          AndroidDeviceInfo().getMemoryInfo().then((MemoryInfo) {
            _view = view;
            _viewModel = new DeviceInfoViewModel(
                jsonDecode(callBack.toString()), BatteryInfo, MemoryInfo);
            _view.uiUpdate(_viewModel);
          });
        });
      }
    });
  }
}
