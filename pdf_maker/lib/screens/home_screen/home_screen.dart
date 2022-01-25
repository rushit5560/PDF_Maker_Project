import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/controllers/pdf_merge_screen_controller/pdf_merge_screen_controller.dart';
import 'package:pdf_maker/screens/crop_screen/crop_screen.dart';
import 'package:pdf_maker/screens/image_list_screen/image_list_screen.dart';
import 'package:pdf_maker/screens/pdf_merge_screen/pdf_merge_screen.dart';
import 'package:pdf_maker/screens/saved_pdf_screen/saved_pdf_screen.dart';
import 'home_screen_widgets.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final homeScreenController = Get.put(HomeScreenController());
  final pdfMergeScreenController = Get.put(PdfMergeScreenController());
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MainBackgroundWidget(),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const HeaderTextModule(),
                Container(
                  height: Get.height * 0.32,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            // Single Image Module
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  pickSingleImage(context);
                                },
                                child: const PickSingleImageModule(),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    // Multi Image Module
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          goToPdfScreen(context);
                                        },
                                        child: const PickMultiImageModule(),
                                      ),
                                    ),
                                    // Merge PDF Module
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          mergePdf(context);
                                        },
                                        child: const MergePdfModule(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Saved PDF Module
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: ()=> Get.to(()=> SavedPdfScreen()),
                          child: const SavedPDfModule(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(),
              ],
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
                      getImageFromCamera();
                    },
                    child: const Icon(Icons.camera)),
                const SizedBox(height: 10),
                GestureDetector(
                    onTap: () {
                      Get.back();
                      getImageFromGallery();
                    },
                    child: const Icon(Icons.collections)),
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

  mergePdf(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
    if (result != null) {
      pdfMergeScreenController.files.value = result.paths.map((path) => File(path!)).toList();
      if (pdfMergeScreenController.files.length > 1) {
        Get.to(() => PdfMergeScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please Select 2 PDF")));
      }
    }
  }


}
