import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/screens/crop_screen/crop_screen.dart';
import 'package:pdf_maker/screens/image_list_screen/image_list_screen.dart';
import 'package:pdf_maker/screens/pdf_merge_screen/pdf_merge_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final homeScreenController = Get.put(HomeScreenController());

  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Maker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              //onPressed: ()=> getImageFromGallery(),
              onPressed: () {
                pickSingleImage(context);
              },
              child: const Text('Pick Single Image'),
            ),
          ),
          Center(
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => goToPdfScreen(context),
                  child: const Text('Select Multiple Images'),
                );
              },
            ),
          ),
          Center(
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                      allowMultiple: true,
                    );
                    if (result != null) {
                      List<File> files =
                          result.paths.map((path) => File(path!)).toList();
                      if (files.length > 1) {
                        Get.to(() => PdfMergeScreen(files: files));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Please Select 2 PDF"),
                        ));
                      }
                    }
                  },
                  child: const Text('Merge PDF'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  pickSingleImage(context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        // we set up a container inside which
        // we create center column and display text
        return SizedBox(
          height: 80,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Get.back();
                      getImageFromGallery();
                    },
                    child: const Icon(Icons.collections)),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      Get.back();
                      getImageFromCamera();
                    },
                    child: const Icon(Icons.camera)),
              ],
            ),
          ),
        );
      },
    );
  }

  getImageFromGallery() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Original File Store In Controller file
      homeScreenController.file = File(image.path);
      File imageFile = File(image.path);
      Get.to(() => CropScreen(imageFile: imageFile));
    }
  }

  getImageFromCamera() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // Original File Store In Controller file
      homeScreenController.file = File(image.path);
      File imageFile = File(image.path);
      Get.to(() => CropScreen(imageFile: imageFile));
    }
  }

  goToPdfScreen(BuildContext context) async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    try {
      if (selectedImages!.isEmpty) {
      } else if (selectedImages.length == 1) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please Select Minimum 2 images"),
        ));
      } else if (selectedImages.length >= 2) {
        homeScreenController.captureImageList.clear();
        for (int i = 0; i < selectedImages.length; i++) {
          File file = File(selectedImages[i].path);
          homeScreenController.captureImageList.add(file);
        }
        Get.to(() => ImageListScreen());
      }
    } catch (e) {
      print('goToPdfScreen : $e');
    }
  }
}
