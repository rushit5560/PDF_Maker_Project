import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'image_list_screen_widgets.dart';



class ImageListScreen extends StatelessWidget {
  ImageListScreen({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => showAlertDialog(context),
      child: Scaffold(
        backgroundColor: AppColor.kLightBlueColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                CustomImageListScreenAppBar(),
                const SizedBox(height: 15),
                Expanded(child: SelectedImagesShowModule()),
              ],
            ),
          ),
        ),

        floatingActionButton: FloatingActionButtonModule(),


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