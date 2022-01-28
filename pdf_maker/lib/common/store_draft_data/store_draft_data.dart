import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  String singleImageListKey = 'SingleImageListKey';
  String mainImageListKey = 'MainImageListKey';

  Future storeSingleImageList(List<String> subList) async {
    if (kDebugMode) {print('subList : $subList');}

    String subListString = subList.toString();
    String subString2 = subListString.substring(1, subListString.length-1);
    if (kDebugMode) {print('subListString : $subString2');}

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> oldList = prefs.getStringList(mainImageListKey) ?? [];
    oldList.add(subString2);
    prefs.setStringList(mainImageListKey, oldList);

    if (kDebugMode) {print('Sublist New : ${prefs.getStringList(mainImageListKey)}');}

  }

  Future<List<String>> getStorageImageList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storageList = prefs.getStringList(mainImageListKey) ?? [];
    if (kDebugMode) {print('storageList : $storageList');}
    return storageList;
  }

  Future updateStorageImageList(List<String> localList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove(singleImageListKey);
    prefs.setStringList(mainImageListKey, localList);
    if (kDebugMode) {print('singleImageListKey : ${prefs.getStringList(mainImageListKey)}');}
  }
}