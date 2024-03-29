import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/common/enums.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/controllers/pdf_merge_screen_controller/pdf_merge_screen_controller.dart';
import 'package:pdf_maker/screens/image_list_screen/image_list_screen.dart';
import 'package:pdf_maker/screens/pdf_merge_screen/pdf_merge_screen.dart';
import 'package:pdf_maker/screens/saved_pdf_screen/saved_pdf_screen.dart';

class CustomHomeScreenAppBar extends StatelessWidget {
  const CustomHomeScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: shadowEffectDecoration(),
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    'SCAN4PDF',
                    style: TextStyle(color: AppColor.kDarkBlueColor, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(width: 10),
          /*GestureDetector(
            onTap: () => Get.to(
              () => SettingScreen(),
              transition: Transition.rightToLeft,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.kDarkBlueColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Image.asset(ImgUrl.setting),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}

class SingleImageModule extends StatelessWidget {
  SingleImageModule({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          await scanSingleImage();
        },
        child: Column(
          children: [
            Container(
              // height: 80,
              decoration: shadowEffectDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  ImgUrl.singleImage,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Scan',
              maxLines: 1,
              style: TextStyle(
                color: AppColor.kDarkBlueColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scanSingleImage() async {
    final ImagePicker imagePicker = ImagePicker();
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      // imagePath = (EdgeDetection.detectEdge).toString();
      // if (kDebugMode) {
      //   print("---------$imagePath");
      // }
      final image = await imagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        // Original File Store In Controller file
        homeScreenController.file = File(image.path);
        File imageFile = File(image.path);
        homeScreenController.captureImageList.add(imageFile);
        // Get.back();
        // Get.off(()=> CropScreen(imageFile: imageFile));
      }
      String listString = homeScreenController.captureImageList.toString();
      Get.to(() => ImageListScreen(
            comingFrom: ComingFrom.newList,
            listString: listString,
          ));
    } on PlatformException catch (e) {
      // imagePath = e.toString();
      if (kDebugMode) {
        print('PlatformException : $e');
      }
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    // if (!mounted) return;

    // setState(() {
    //   _imagePath = imagePath;
    // });
  }
}

class MergePdfModule extends StatelessWidget {
  MergePdfModule({Key? key}) : super(key: key);
  final pdfMergeScreenController = Get.find<PdfMergeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          mergePdf(context);
        },
        child: Column(
          children: [
            Container(
              // height: 80,
              decoration: shadowEffectDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  ImgUrl.mergePdf,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Merge PDF',
              maxLines: 1,
              style: TextStyle(
                color: AppColor.kDarkBlueColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
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
        String pdfListString = pdfMergeScreenController.files.toString();
        Get.to(() => PdfMergeScreen(
              pdfComingFrom: PdfComingFrom.newList,
              pdfListString: pdfListString,
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Select 2 PDF")));
      }
    }
  }
}

class MultipleImageModule extends StatelessWidget {
  MultipleImageModule({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          getMultipleImageFromGallery(context);
        },
        child: Column(
          children: [
            Container(
              // height: 80,
              decoration: shadowEffectDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  ImgUrl.multipleImage,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Multiple Image',
              maxLines: 1,
              style: TextStyle(
                color: AppColor.kDarkBlueColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*pickSingleImage(context) {
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
                      // homeScreenController.selectedGalleryModule.value = 1;
                      Get.back();
                      getSingleImageFromGallery();
                    },
                    // child: const Icon(Icons.camera)),
                    child: const Text('Single Image')),
                const SizedBox(height: 10),
                GestureDetector(
                    onTap: () {
                      // homeScreenController.selectedGalleryModule.value = 2;
                      Get.back();
                      getMultipleImageFromGallery(context);
                    },
                    // child: const Icon(Icons.collections)),
                    child: const Text('Multi Image')),
              ],
            ),
          ),
        );
      },
    );
  }

  getSingleImageFromGallery() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Original File Store In Controller file
      homeScreenController.file = File(image.path);
      File imageFile = File(image.path);
      Get.to(() => CropScreen(imageFile: imageFile));
    }
  }*/

  getMultipleImageFromGallery(BuildContext context) async {
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
        String listString = homeScreenController.captureImageList.toString();
        Get.to(() => ImageListScreen(
              comingFrom: ComingFrom.newList,
              listString: listString,
            ));
      }
    } catch (e) {
      if (kDebugMode) {
        print('goToImgListScreen : $e');
      }
    }
  }
}

class PdfViewer extends StatelessWidget {
  const PdfViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          // await scanSingleImage();
        },
        child: Column(
          children: [
            Container(
              // height: 80,
              decoration: shadowEffectDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  ImgUrl.singleImage,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Pdf viewer',
              maxLines: 1,
              style: TextStyle(
                color: AppColor.kDarkBlueColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScanPdfText extends StatelessWidget {
  const ScanPdfText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          // await scanSingleImage();
        },
        child: Column(
          children: [
            Container(
              // height: 80,
              decoration: shadowEffectDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  ImgUrl.singleImage,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Scan text\nfrom pdf',
              maxLines: 2,
              style: TextStyle(
                color: AppColor.kDarkBlueColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditPdf extends StatelessWidget {
  const EditPdf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          // await scanSingleImage();
        },
        child: Column(
          children: [
            Container(
              // height: 80,
              decoration: shadowEffectDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  ImgUrl.singleImage,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Edit pdf',
              maxLines: 1,
              style: TextStyle(
                color: AppColor.kDarkBlueColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SavedPdfModule extends StatelessWidget {
  const SavedPdfModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => Get.to(() => SavedPdfScreen()),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: shadowEffectDecoration(),
          child: Row(
            children: [
              Image.asset(
                ImgUrl.save,
                height: 35,
                width: 35,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Center(
                  child: Text(
                    'Saved PDF',
                    style: TextStyle(
                      color: AppColor.kDarkBlueColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
