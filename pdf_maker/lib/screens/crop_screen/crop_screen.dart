import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/screens/image_list_screen/image_list_screen.dart';
import 'package:pdf_maker/screens/rotate_screen/rotate_screen.dart';

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
        appBar: AppBar(
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
        ),

        body: Obx(
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
        ),
      );
  }
}
