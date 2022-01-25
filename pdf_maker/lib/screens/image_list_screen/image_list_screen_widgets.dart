import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/common/store_draft_data/store_draft_data.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/screens/crop_screen/crop_screen.dart';
import 'package:pdf_maker/screens/pdf_show_screen/pdf_show_screen.dart';

class FloatingActionButtonModule extends StatelessWidget {
  FloatingActionButtonModule({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: borderGradientDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: containerBackgroundGradient(),
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => getImageFromCamera(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Icon(Icons.camera, color: Colors.black, size: 30),
                  ),
                ),
                const VerticalDivider(indent: 5, endIndent: 5, thickness: 2),
                GestureDetector(
                  onTap: () => getImageFromGallery(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Icon(Icons.collections, color: Colors.black, size: 30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImageFromGallery() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      // Original File Store In Controller file
      homeScreenController.file = File(image.path);
      File imageFile = File(image.path);
      Get.to(()=> CropScreen(imageFile: imageFile));
    }
  }

  getImageFromCamera() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if(image != null) {
      // Original File Store In Controller file
      homeScreenController.file = File(image.path);
      File imageFile = File(image.path);
      Get.to(()=> CropScreen(imageFile: imageFile));
    }
  }

}

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();
  List<String> localList = [];

  LocalStorage localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width,
      decoration: borderGradientDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: containerBackgroundGradient(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showAlertDialog(context);
                  },
                  child: Image.asset(ImgUrl.leftArrow, scale: 2.5),
                ),
                const Text(
                  "Image List",
                  style: TextStyle(
                      fontFamily: "",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Get.off(()=> PdfShowScreen()),
                  child: const Icon(Icons.check_rounded),
                ),
              ],
            )),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Get.back();
        Get.back();
        homeScreenController.captureImageList.clear();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () async {
        if(homeScreenController.captureImageList.isNotEmpty) {
          localList.clear();
          for(int i = 0; i < homeScreenController.captureImageList.length; i++){
            localList.add(homeScreenController.captureImageList[i].path);
          }
          if (kDebugMode) {
            print('localList : $localList');
          }

          if(localList.isNotEmpty){
            await localStorage.storeSingleImageList(localList);
          }
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

class ItemDeleteButton extends StatelessWidget {
  int i;
  ItemDeleteButton({Key? key, required this.i}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('index : $i');
        homeScreenController.captureImageList.removeAt(i);
      },
      child: const Icon(Icons.delete_rounded, color: Colors.red),
    );
  }
}

class ImageShowModule extends StatelessWidget {
  int i;
  ImageShowModule({Key? key, required this.i}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(File(homeScreenController.captureImageList[i].path)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
