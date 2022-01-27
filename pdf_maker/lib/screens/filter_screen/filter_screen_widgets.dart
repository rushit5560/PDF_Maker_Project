import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/controllers/filter_screen_controller/filter_screen_controller.dart';
import 'dart:ui' as ui;

import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/screens/image_list_screen/image_list_screen.dart';

class CustomFilterAppBarModule extends StatelessWidget {
  File imageFile;
  CustomFilterAppBarModule({Key? key, required this.imageFile}) : super(key: key);
  final filterScreenController = Get.find<FilterScreenController>();
  final homeScreenController = Get.find<HomeScreenController>();

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
                  onTap: () => showAlertDialog(context),
                  child: Image.asset(ImgUrl.leftArrow, scale: 2.5),
                ),
                const Text(
                  "Filter",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () async {
                    filterScreenController.isFilterSelected.value
                        ? await convertBlackAndWhiteImage()
                        : gotoOriginalImage(imageFile);

                  },
                    child: const Icon(Icons.check_rounded, size: 30),
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
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () async {
        Get.back();
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("AlertDialog"),
      content: const Text("Do you want to exit?"),
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

  gotoOriginalImage(File imageFile) {
    print('gotoOriginalImage');
    homeScreenController.captureImageList.add(imageFile);
    Get.off(()=> ImageListScreen());
  }

  Future convertBlackAndWhiteImage() async{
    print('convertBlackAndWhiteImage');
    try {
      DateTime time = DateTime.now();
      String imgName = "${time.hour}-${time.minute}-${time.second}";
      print('inside');
      RenderRepaintBoundary boundary =
      filterScreenController.repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      print(boundary);
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      print("image:===$image");
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      print("byte data:===$byteData");
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = File('$directory/$imgName.jpg');
      await imgFile.writeAsBytes(pngBytes);
      homeScreenController.captureImageList.add(imgFile);
      Get.off(()=> ImageListScreen());
      // await saveImage();
    } catch (e) {
      print(e);
    }
  }

}
