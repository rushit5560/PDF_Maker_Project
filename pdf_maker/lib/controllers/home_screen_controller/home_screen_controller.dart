import 'dart:io';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool cropEnable = true.obs;
  RxBool isCropping = false.obs;
  RxList<File> captureImageList = RxList<File>();
  File? file;
  RxDouble rotation = 0.0.obs;
  RxInt crossAxisCount = 2.obs;
  RxDouble minScale = 1.0.obs;
  RxDouble maxScale = 5.0.obs;


  loading() {
    isLoading(true);
    isLoading(false);
  }
}