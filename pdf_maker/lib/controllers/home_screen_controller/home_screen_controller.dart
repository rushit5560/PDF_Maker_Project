import 'dart:io';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool cropEnable = true.obs;
  RxBool isCropping = false.obs;
  RxList<File> captureImageList = RxList<File>();
  File? file;
  RxDouble rotation = 0.0.obs;


  loading() {
    isLoading(true);
    isLoading(false);
  }
}