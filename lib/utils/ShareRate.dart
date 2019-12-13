import 'package:android_intent/android_intent.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class ShareRate {
  static share(id) async {
    var response = await FlutterShareMe().shareToSystem(
        msg: 'https://play.google.com/store/apps/details?id=' + id);
    if (response == 'success') {
      print('navigate success');
    }
  }

  static rate(id) async {
    AndroidIntent intent = AndroidIntent(
      action: 'action_view',
      data: 'https://play.google.com/store/apps/details?id='
              '' +
          id,
    );
    await intent.launch();
  }
}
