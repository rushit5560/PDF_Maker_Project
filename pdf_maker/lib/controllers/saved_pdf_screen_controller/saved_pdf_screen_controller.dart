import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/store_draft_data/store_draft_data.dart';


class SavedPdfScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  LocalStorage localStorage = LocalStorage();
  RxList<String> storeImageList = RxList();
  RxList<String> storePdfList = RxList();
  // RxList<File> storeImageFileList = RxList();
  late TabController tabController;

  getStorageImages() async {
    isLoading(true);
    storeImageList.value = await localStorage.getStorageImageList();
    if(storeImageList.isEmpty) {
      storeImageList.value = [];
    }
    isLoading(false);
  }

  getStoragePdfs() async {
    isLoading(true);
    storePdfList.value = await localStorage.getStoragePdfList();
    isLoading(false);
  }

  updateStorageImages(int i) async {
    isLoading(true);
    storeImageList.removeAt(i);
    print('Remove at $i : $storeImageList');
    await localStorage.updateStorageImageList(storeImageList);
    getStorageImages();
    isLoading(false);
  }

  updateStoragePdfs(int i) async {
    isLoading(true);
    storePdfList.removeAt(i);
    print('Remove at $i : $storePdfList');
    localStorage.updateStoragePdfList(storePdfList);
    getStoragePdfs();
    isLoading(false);
  }

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    getStorageImages();
    getStoragePdfs();
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  loading() {
    isLoading(true);
    isLoading(false);
  }
}