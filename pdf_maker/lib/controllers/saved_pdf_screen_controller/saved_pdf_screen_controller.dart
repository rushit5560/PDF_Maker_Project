import 'package:get/get.dart';
import 'package:pdf_maker/common/store_draft_data/store_draft_data.dart';

class SavedPdfScreenController extends GetxController {
  RxBool isLoading = false.obs;
  LocalStorage localStorage = LocalStorage();
  List<String> storeImageList = [];

  getStorageImages() async {
    isLoading(true);
    storeImageList = await localStorage.getStorageImageList();
    if(storeImageList.isEmpty) {
      storeImageList = [];
    }
    isLoading(false);
  }
}