import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // String singleImageListKey = 'SingleImageListKey';
  String mainImageListKey = 'MainImageListKey';
  String mainPdfListKey = 'MainPdfListKey';


  // Save Image List In Prefs
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

  // Save Pdf List In Prefs
  Future storePdfList(List<String> pdfList) async {
    if (kDebugMode) {print('subList : $pdfList');}
    String pdfListString = pdfList.toString();
    String subString2 = pdfListString.substring(1, pdfListString.length-1);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> oldPdfList = prefs.getStringList(mainPdfListKey) ?? [];
    oldPdfList.add(subString2);
    prefs.setStringList(mainPdfListKey, oldPdfList);
  }


  // Get Store Images List From Prefs
  Future<List<String>> getStorageImageList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storageList = prefs.getStringList(mainImageListKey) ?? [];
    if (kDebugMode) {print('storageList : $storageList');}
    return storageList;
  }

  // Get Store Pdf List From Prefs
  Future<List<String>> getStoragePdfList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storageList = prefs.getStringList(mainPdfListKey) ?? [];
    if (kDebugMode) {print('storageList : $storageList');}
    return storageList;
  }

  // Update Store Image List in Prefs
  Future updateStorageImageList(List<String> localList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove(singleImageListKey);
    prefs.setStringList(mainImageListKey, localList);
    if (kDebugMode) {print('singleImageListKey : ${prefs.getStringList(mainImageListKey)}');}
  }

  // Update Store Pfd List in Prefs
  Future updateStoragePdfList(List<String> localList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(mainPdfListKey, localList);
    if (kDebugMode) {print('singlePdfListKey : ${prefs.getStringList(mainPdfListKey)}');}
  }


}