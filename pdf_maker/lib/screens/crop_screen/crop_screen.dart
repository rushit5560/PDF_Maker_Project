import 'dart:io';
import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'crop_screen_widgets.dart';

class CropScreen extends StatefulWidget {
  int i;
  CropScreen({Key? key, required this.i}) : super(key: key);

  @override
  _CropScreenState createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final homeScreenController = Get.find<HomeScreenController>();
  final cropController = CropController();
  Uint8List? croppedImage;
  String tempCroppedFile = '';
  List<File> tempList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kLightBlueColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: CustomCropScreenAppBar(cropController: cropController),
              ),
              const SizedBox(height: 15),

              Obx(
                ()=> Container(
                  child: croppedImage == null
                      ? Expanded(
                    child: Column(
                      children: [
                        Flexible(
                          child: Crop(
                              maskColor: Colors.black38,
                              controller: cropController,
                              cornerDotBuilder: (size, edgeAlignment) => const DotControl(color: Colors.red),
                              image: homeScreenController.captureImageList[widget.i].readAsBytesSync(),
                              onCropped: (croppedData1) async {
                                croppedImage = croppedData1;
                                homeScreenController.captureImageList[widget.i].writeAsBytesSync(croppedImage!);
                                tempCroppedFile =homeScreenController.captureImageList[widget.i].path;
                                print('tempCroppedFile : $tempCroppedFile');
                                homeScreenController.isCropping.value = false;
                                homeScreenController.cropEnable.value = false;
                                homeScreenController.loading();

                                if(tempCroppedFile.isNotEmpty) {
                                  String frontPath = tempCroppedFile.split('cache')[0];
                                  List<String> ogPathList = tempCroppedFile.split('/');
                                  String ogExt = ogPathList[ogPathList.length - 1].split('.')[1];
                                  DateTime today = DateTime.now();
                                  String dateSlug = "${today.day}${today.month}${today.year}${today.hour}${today.minute}${today.second}";
                                  String newPath = "${frontPath}cache/image_$dateSlug.$ogExt";
                                  homeScreenController.captureImageList[widget.i].rename(newPath);

                                  tempList.clear();
                                  for(int i = 0; i < homeScreenController.captureImageList.length; i++) {
                                    tempList.add(homeScreenController.captureImageList[i]);
                                  }
                                  tempList.removeAt(widget.i);
                                  tempList.insert(widget.i, File(newPath));

                                  homeScreenController.captureImageList.clear();
                                  for(int i =0; i < tempList.length; i++){
                                    homeScreenController.captureImageList.add(tempList[i]);
                                  }

                                  Get.back();

                                }

                              }),
                        ),
                      ],
                    ),
                  )
                      : Center(child: Image.memory(croppedImage!)),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}


/*class CropScreen extends StatefulWidget {
  File imageFile;
  CropScreen({Key? key, required this.imageFile}) : super(key: key);

  @override
  _CropScreenState createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final homeScreenController = Get.find<HomeScreenController>();
  Uint8List? croppedImage;
  final cropController = CropController();
  File? tempCroppedFile;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kLightBlueColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: CustomCropScreenAppBar(cropController: cropController),
              ),
              const SizedBox(height: 15),
              Container(
                child: croppedImage == null
                    ? Expanded(
                  child: Column(
                    children: [
                      Flexible(
                        child: Crop(
                            maskColor: Colors.black38,
                            controller: cropController,
                            cornerDotBuilder: (size, edgeAlignment) => const DotControl(color: Colors.red),
                            image: widget.imageFile.readAsBytesSync(),
                            onCropped: (croppedData1) async {
                              croppedImage = croppedData1;
                              widget.imageFile.writeAsBytesSync(croppedImage!);
                              tempCroppedFile =widget.imageFile;
                              print('tempCroppedFile : $tempCroppedFile');
                              homeScreenController.isCropping.value = false;
                              homeScreenController.cropEnable.value = false;
                              homeScreenController.loading();
                              Get.off(()=> FilterScreen(imageFile: widget.imageFile));
                            }),
                      ),
                    ],
                  ),
                )
                    : Center(child: Image.memory(croppedImage!)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog() {
    Widget cancelButton = TextButton(
      child: const Text(
        "No",
        style: TextStyle(fontFamily: ""),
      ),
      onPressed: () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(fontFamily: ""),
      ),
      onPressed: () async {
        Get.back();
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("AlertDialog"),
      content: const Text(
        "Do you want to exit?",
        style: TextStyle(fontFamily: ""),
      ),
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

}*/
