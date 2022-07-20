import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/common/enums.dart';
import 'package:pdf_maker/common/store_draft_data/store_draft_data.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/controllers/image_list_screen_controller/image_list_screen_controller.dart';
import 'package:pdf_maker/controllers/saved_pdf_screen_controller/saved_pdf_screen_controller.dart';
import 'image_list_screen_widgets.dart';

class ImageListScreen extends StatelessWidget {
  final int? index;
  final ComingFrom comingFrom;
  final String listString;
  ImageListScreen(
      {Key? key,
      required this.comingFrom,
      this.index,
      required this.listString})
      : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();
  final savedPdfScreenController = Get.put(SavedPdfScreenController());
  final imageListScreenController = Get.put(ImageListScreenController());
  LocalStorage localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        String newListString = homeScreenController.captureImageList.toString();

        if (comingFrom == ComingFrom.newList) {
          if (homeScreenController.captureImageList.isEmpty) {
            Get.back();
            homeScreenController.captureImageList.clear();
            Get.back();
          } else {
            showAlertDialog(context);
          }
        } else if (comingFrom == ComingFrom.savedList) {
          if (listString == newListString) {
            homeScreenController.captureImageList.clear();
            Get.back();
          } else {
            showAlertDialog(context);
          }
        }
        return null!;
      },
      child: Scaffold(
        backgroundColor: AppColor.kLightBlueColor,
        body: Obx(
          () => homeScreenController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Column(
                      children: [
                        CustomImageListScreenAppBar(
                          comingFrom: comingFrom,
                          index: index,
                          listString: listString,
                        ),
                        const SizedBox(height: 15),
                        Expanded(child: SelectedImagesShowModule()),
                        Column(
                          children: [
                            FloatingActionButtonModule(),
                            SizedBox(height: 10),
                            Container(
                              height: 48,
                              child: imageListScreenController.adWidget,
                            ),
                          ],
                        ),
                        //SizedBox(height: 65)
                      ],
                    ),
                  ),
                ),
        ),
        //floatingActionButton: FloatingActionButtonModule(),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        homeScreenController.captureImageList.clear();
        print('No Button List : ${homeScreenController.captureImageList}');
        Get.back();
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () async {
        /*if(comingFrom == ComingFrom.newList) {
          if(homeScreenController.captureImageList.isNotEmpty) {
            homeScreenController.localList.clear();
            for(int i = 0; i < homeScreenController.captureImageList.length; i++){
              homeScreenController.localList.add(homeScreenController.captureImageList[i].path);
            }
            if (kDebugMode) {print('localList : ${homeScreenController.localList}');}

            if(homeScreenController.localList.isNotEmpty){
              await homeScreenController.localStorage.storeSingleImageList(homeScreenController.localList);
            }
            homeScreenController.captureImageList.clear();
          }
        } else if(comingFrom == ComingFrom.savedList) {
          if(homeScreenController.captureImageList.isNotEmpty) {
            homeScreenController.localList.clear();
            for(int i = 0; i < homeScreenController.captureImageList.length; i++){
              homeScreenController.localList.add(homeScreenController.captureImageList[i].path);
            }

          }
        }*/

        if (homeScreenController.captureImageList.isNotEmpty) {
          homeScreenController.localList.clear();
          for (int i = 0;
              i < homeScreenController.captureImageList.length;
              i++) {
            homeScreenController.localList
                .add(homeScreenController.captureImageList[i].path);
          }
          if (kDebugMode) {
            print('localList : ${homeScreenController.localList}');
          }

          if (homeScreenController.localList.isNotEmpty) {
            await homeScreenController.localStorage.storeSingleImageList(
              subList: homeScreenController.localList,
              comingFrom: comingFrom,
              index: index,
            );
          }
        } else if (homeScreenController.captureImageList.isEmpty) {
          print('storeImageList : ${savedPdfScreenController.storeImageList}');
          savedPdfScreenController.storeImageList.removeAt(index!);
          localStorage
              .updateStorageImageList(savedPdfScreenController.storeImageList);
          print('storeImageList : ${savedPdfScreenController.storeImageList}');
        }
        homeScreenController.captureImageList.clear();
        Get.back();
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("AlertDialog"),
      content: const Text("Do you want to save in Draft ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
