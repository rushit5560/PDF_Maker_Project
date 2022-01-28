import 'dart:io';

import 'package:edge_detection/edge_detection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/controllers/pdf_merge_screen_controller/pdf_merge_screen_controller.dart';
import 'package:pdf_maker/screens/crop_screen/crop_screen.dart';
import 'package:pdf_maker/screens/image_list_screen/image_list_screen.dart';
import 'package:pdf_maker/screens/pdf_merge_screen/pdf_merge_screen.dart';
import 'package:pdf_maker/screens/saved_pdf_screen/saved_pdf_screen.dart';


class PickSingleImageModule extends StatelessWidget {
  const PickSingleImageModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: borderGradientDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: containerBackgroundGradient(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImgUrl.camera,
                    scale: 2.5,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Single Image",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PickMultiImageModule extends StatelessWidget {
  const PickMultiImageModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: borderGradientDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: containerBackgroundGradient(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImgUrl.camera,
                    scale: 2.5,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "Multi Image",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class MergePdfModule extends StatelessWidget {
//   const MergePdfModule({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(5),
//       child: Container(
//         decoration: borderGradientDecoration(),
//         child: Padding(
//           padding: const EdgeInsets.all(3),
//           child: Container(
//             decoration: containerBackgroundGradient(),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     ImgUrl.camera,
//                     scale: 2.5,
//                   ),
//                   const SizedBox(width: 10),
//                   const Text(
//                     "Merge PDF",
//                     style: TextStyle(
//                       fontSize: 20,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class SavedPDfModule extends StatelessWidget {
  const SavedPDfModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: borderGradientDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: containerBackgroundGradient(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Saved PDF",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomHomeScreenAppBar extends StatelessWidget {
  const CustomHomeScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    style: TextStyle(
                      color: AppColor.kDarkBlueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Container(
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
              'Single Image',
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
    String? imagePath;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      imagePath = (await EdgeDetection.detectEdge);
      print("$imagePath");

      if(imagePath != null) {
        homeScreenController.captureImageList.add(File(imagePath));
        Get.to(() => ImageListScreen());
      }

    } on PlatformException catch (e) {
      // imagePath = e.toString();
      print('PlatformException : $e');
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
        Get.to(() => PdfMergeScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please Select 2 PDF")));
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
          pickSingleImage(context);
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
  }

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
        Get.to(() => ImageListScreen());
      }
    } catch (e) {
      print('goToPdfScreen : $e');
    }
  }

}

class SavedPdfModule extends StatelessWidget {
  SavedPdfModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => Get.to(()=> SavedPdfScreen()),
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
