import 'package:guide_gaming/base/BasePresenter.dart';
import 'package:guide_gaming/base/BaseView.dart';
import 'package:guide_gaming/utils/CallNative.dart';
import 'package:permission_handler/permission_handler.dart';

import 'SelectScreenViewModel.dart';

class SelectScreenPresenter implements BasePresenter {
  BaseView _view;
  SelectScreenViewModel _viewModel;

  SelectScreenPresenter() {
    CallNative.callFluterToNative("TRAKING", {"id": "Home"}, (result) {
      print("TRAKING" + result);
    });
    Future.delayed(new Duration(milliseconds: 1000), () {
      CallNative.callFluterToNative("RATE", {"id": "Home"}, (result) {
        print("RATE" + result);
      });
    });
    _requestPermisstion();
  }
  _requestPermisstion() async {
    print("vao trong xin quyen");
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([
      PermissionGroup.camera,
    ]);

    PermissionStatus permission =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);

    if (permission != PermissionStatus.granted) {
      this._requestPermisstion();
    }
  }

  @override
  void action(key, data) {
    // TODO: implement action
  }

  @override
  void init(view) {
    _view = view;
    var data = [
      {"aaaa": "bbbb"}
    ];
    _viewModel = new SelectScreenViewModel(data);
    _view.uiUpdate(_viewModel);
  }
}
