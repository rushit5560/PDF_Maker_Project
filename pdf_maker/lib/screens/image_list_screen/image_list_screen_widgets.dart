import 'dart:io';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/common/store_draft_data/store_draft_data.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/screens/crop_screen/crop_screen.dart';
import 'package:pdf_maker/screens/pdf_show_screen/pdf_show_screen.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';


class CustomImageListScreenAppBar extends StatelessWidget {
  CustomImageListScreenAppBar({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();
  List<String> localList = [];
  LocalStorage localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => showAlertDialog(context),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColor.kDarkBlueColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: Image.asset(ImgUrl.backOption),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              decoration: shadowEffectDecoration(),
              child: const Center(
                child: Text(
                  'IMAGES',
                  style: TextStyle(
                    color: AppColor.kDarkBlueColor,
                    fontWeight: FontWeight.bold,
                      fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () => Get.off(()=> PdfShowScreen()),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: AppColor.kDarkBlueColor,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  ImgUrl.click,
                  // height: 5, width: 5,
                ),
              ),
            ),
          ),
        ],
      ),
      // child: Row(
      //   children: [
      //     GestureDetector(
      //       onTap: () {
      //         showAlertDialog(context);
      //       },
      //       child: Container(
      //         decoration: BoxDecoration(
      //           color: AppColor.kDarkBlueColor,
      //           borderRadius: BorderRadius.circular(15),
      //         ),
      //         child: Padding(
      //           padding: const EdgeInsets.all(20),
      //           child: Center(
      //             child: Image.asset(ImgUrl.backOption),
      //           ),
      //         ),
      //       ),
      //     ),
      //     const SizedBox(width: 15),
      //     Expanded(
      //       child: Container(
      //         decoration: shadowEffectDecoration(),
      //         child: const Padding(
      //           padding: EdgeInsets.all(15),
      //           child: Center(
      //             child: Text(
      //               'IMAGES',
      //               style: TextStyle(
      //                   color: AppColor.kDarkBlueColor,
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 18
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     const SizedBox(width: 15),
      //     GestureDetector(
      //       onTap: () {},
      //       child: Container(
      //         decoration: BoxDecoration(
      //           color: AppColor.kDarkBlueColor,
      //           borderRadius: BorderRadius.circular(15),
      //         ),
      //         child: Padding(
      //           padding: const EdgeInsets.all(20),
      //           child: Center(
      //             child: Image.asset(ImgUrl.click),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
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
          localList.clear();
          for(int i = 0; i < homeScreenController.captureImageList.length; i++){
            localList.add(homeScreenController.captureImageList[i].path);
          }
          if (kDebugMode) {print('localList : $localList');}

          if(localList.isNotEmpty){
            await localStorage.storeSingleImageList(localList);
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

class SelectedImagesShowModule extends StatelessWidget {
  SelectedImagesShowModule({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails details) {
        print('scale : ${details.scale}');
        homeScreenController.changeLayoutOnGesture(details);
      },
      child: Obx(
        () => homeScreenController.captureImageList.isEmpty
            ? const Center(child: Text('Please Add Image'))
            : ReorderableGridView.count(
                crossAxisCount: homeScreenController.crossAxisCount.value,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
                onReorder: (oldIndex, newIndex) {
                  File path =
                      homeScreenController.captureImageList.removeAt(oldIndex);
                  homeScreenController.captureImageList.insert(newIndex, path);
                },
                children: [
                  for (int i = 0;
                      i < homeScreenController.captureImageList.length;
                      i++)
                    Container(
                      key: ValueKey(homeScreenController.captureImageList[i]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ImageShowModule(i: i),
                          Positioned(
                            bottom: 5,
                              child: ItemDeleteButton(i: i)),
                        ],
                      ),
                    ),
                ],
              ),
      ),
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
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
        ),
        child: const Icon(
          Icons.delete_rounded,
          color: AppColor.kDarkBlueColor,
          size: 20,
        ),
      ),
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

class FloatingActionButtonModule extends StatefulWidget {
  FloatingActionButtonModule({Key? key}) : super(key: key);

  @override
  State<FloatingActionButtonModule> createState() => _FloatingActionButtonModuleState();
}
class _FloatingActionButtonModuleState extends State<FloatingActionButtonModule> {
  final homeScreenController = Get.find<HomeScreenController>();

  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async => await getImage(),
          child: Container(
            height: 65,
            width: 65,
            decoration: shadowEffectDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(ImgUrl.camera),
            ),
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () => getImageFromGallery(),
          child: Container(
            height: 65,
            width: 65,
            decoration: shadowEffectDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(ImgUrl.multipleImage),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> getImage() async {
    String? imagePath;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      imagePath = (await EdgeDetection.detectEdge);
      print("$imagePath");

      if(imagePath != null) {
        homeScreenController.captureImageList.add(File(imagePath));
      }

    } on PlatformException catch (e) {
      imagePath = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _imagePath = imagePath;
    // });
  }

  getImageFromGallery() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      // Original File Store In Controller file
      homeScreenController.file = File(image.path);
      File imageFile = File(image.path);
      Get.off(()=> CropScreen(imageFile: imageFile));
    }
  }

}
