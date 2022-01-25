import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  String singleImageListKey = 'SingleImageListKey';

  Future storeSingleImageList(List<String> subList) async {
    if (kDebugMode) {
      print('subList : $subList');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempList = prefs.getStringList(singleImageListKey) ?? [];
    for(int i =0; i< subList.length; i++){
      tempList.add(subList[i]);
    }
    prefs.setStringList(singleImageListKey, tempList);

    if (kDebugMode) {
      print('Sublist New : ${prefs.getStringList(singleImageListKey)}');
    }
  }
}