import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool cropEnable = true.obs;
  RxBool isCropping = false.obs;
  RxList<File> captureImageList = RxList<File>();
  File? file;
  RxDouble rotation = 0.0.obs;
  RxInt crossAxisCount = 3.obs;
  RxDouble minScale = 1.0.obs;
  RxDouble maxScale = 5.0.obs;


  changeLayoutOnGesture(ScaleUpdateDetails details) {
    if(details.scale >= 1 && details.scale < 1.20) {
      crossAxisCount.value = 3;
    } else if(details.scale >= 1.20 && details.scale < 1.50) {
      crossAxisCount.value = 2;
    } else if(details.scale >= 1.50) {
      crossAxisCount.value = 1;
    } else if(details.scale < 1 && details.scale >= 0.70) {
      crossAxisCount.value = 4;
    } else if(details.scale < 0.70 && details.scale >= 0.40) {
      crossAxisCount.value = 5;
    } else if(details.scale < 0.40) {
      crossAxisCount.value = 6;
    }
  }

  loading() {
    isLoading(true);
    isLoading(false);
  }
}