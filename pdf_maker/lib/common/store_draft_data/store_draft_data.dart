import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  String singleImageListKey = 'SingleImageListKey';

  Future storeSingleImageList(List<String> subList) async {
    if (kDebugMode) {
      print('subList : $subList');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // List<String> tempList = prefs.getStringList(singleImageListKey) ?? [];
    // prefs.remove(singleImageListKey);
    List<String> tempList = [];
    for(int i =0; i< subList.length; i++){
      tempList.add(subList[i]);
    }
    prefs.setStringList(singleImageListKey, tempList);

    if (kDebugMode) {
      print('Sublist New : ${prefs.getStringList(singleImageListKey)}');
    }
  }

  Future<List<String>> getStorageImageList() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storageList = prefs.getStringList(singleImageListKey) ?? [];
    if (kDebugMode) {
      print('storageList : $storageList');
    }
    return storageList;
  }

  Future updateStorageImageList(List<String> localList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove(singleImageListKey);
    prefs.setStringList(singleImageListKey, localList);
    print('singleImageListKey : ${prefs.getStringList(singleImageListKey)}');
  }
}