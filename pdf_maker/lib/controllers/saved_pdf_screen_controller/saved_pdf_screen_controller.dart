import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/store_draft_data/store_draft_data.dart';

class SavedPdfScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  LocalStorage localStorage = LocalStorage();
  List<String> storeImageList = [];
  late TabController tabController;

  getStorageImages() async {
    isLoading(true);
    storeImageList.clear();
    storeImageList = await localStorage.getStorageImageList();
    if(storeImageList.isEmpty) {
      storeImageList = [];
    }
    isLoading(false);
  }

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    getStorageImages();
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}