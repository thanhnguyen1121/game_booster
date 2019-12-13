import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guide_gaming/locales/i18n.dart';

class DataUtils {
  static getData(context) {
    var data = [];
    int vitri = 1;
    for (int i = 0; i < 9; i++) {
      data.add({
        "title$vitri": I18n.of(context).t("title$vitri"),
        "subContent$vitri": I18n.of(context).t("subContent$vitri"),
        "content$vitri": I18n.of(context).t("content$vitri"),
        "icon$vitri": I18n.of(context).t("icon$vitri")
      });
      vitri++;
    }
    return data;
  }

  static Future<Map<String, dynamic>> getDataWallpager(context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("lib/images/index.json");
    final jsonResult = json.decode(data);
    return jsonResult;
  }

  static Future<Map<String, dynamic>> getDataPubg(context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("lib/locales/dataWeapons.json");
    final jsonResult = json.decode(data);
    return jsonResult;
  }
}
