import 'dart:io';
import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/screens/filter_screen/filter_screen.dart';
import 'package:pdf_maker/screens/image_list_screen/image_list_screen.dart';

class CropScreen extends StatefulWidget {
  File imageFile;

  CropScreen({Key? key, required this.imageFile}) : super(key: key);

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final homeScreenController = Get.find<HomeScreenController>();
  final cropController = CropController();
  Uint8List? croppedImage;
  File? tempCroppedFile;

  // var isCropping = false;
  // bool cropEnable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MainBackgroundWidget(),
          SafeArea(
            child: Obx(
              () => homeScreenController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          customAppBar(),
                          const SizedBox(height: 15),
                          croppedImage == null
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
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
            ),
          )
        ],
      ),
      /*appBar: AppBar(
            title: const Text('Crop'),
          actions: [
            IconButton(
              onPressed: () {
                cropController.crop();
                Fluttertoast.showToast(msg: 'Please Wait...', toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 1,);
                homeScreenController.isCropping.value = true;

              },
              icon: const Icon(Icons.check_rounded),
            ),
          ],
        ),*/

      /*body: Obx(
          ()=> homeScreenController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : croppedImage == null
          ? Crop(
            maskColor: Colors.white24,
            controller: cropController,
            image: widget.imageFile.readAsBytesSync(),
            onCropped: (croppedData1) async {
              // Future.delayed(Duration(seconds: 3));
              setState(() {
                print('croppedData1 : $croppedData1');
                croppedImage = croppedData1;
                widget.imageFile.writeAsBytesSync(croppedImage!);
                tempCroppedFile = widget.imageFile;
                print('tempCroppedFile : $tempCroppedFile');
                homeScreenController.isCropping.value = false;
                homeScreenController.cropEnable.value = false;
                homeScreenController.loading();
                homeScreenController.captureImageList.add(widget.imageFile);
                // Get.off(()=> RotateScreen(imageFile: widget.imageFile));
                Get.off(()=> ImageListScreen());
              });

            },
            initialSize: 0.5,
          )
          : Center(child: Image.memory(croppedImage!)),
        ),*/
    );
  }

  Widget customAppBar() {
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
                    //Get.back();
                    showAlertDialog();
                  },
                  child: Image.asset(ImgUrl.leftArrow, scale: 2.5),
                ),
                const Text(
                  "Crop",
                  style: TextStyle(
                      fontFamily: "",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    cropController.crop();
                    Fluttertoast.showToast(msg: 'Please wait...', toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 1,);
                    homeScreenController.isCropping.value = true;

                  },
                  child: const Icon(Icons.check_rounded),
                ),
              ],
            )),
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
        // await _capturePng().then((value) {
        //   Get.back();
        //   Get.back();
        // });
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
}
