import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/screens/crop_screen/crop_screen.dart';
import 'package:pdf_maker/screens/pdf_show_screen/pdf_show_screen.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class ImageListScreen extends StatelessWidget {
  ImageListScreen({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MainBackgroundWidget(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  customAppBar(context),
                  const SizedBox(height: 15),
                  Obx(
                    ()=> Expanded(
                      child: InteractiveViewer(
                        minScale: homeScreenController.minScale.value,
                        maxScale: homeScreenController.maxScale.value,
                        onInteractionUpdate: (scaleUpdateDetails) {
                          if(scaleUpdateDetails.scale > 1) {
                            homeScreenController.crossAxisCount.value = 1;
                          }
                        },
                        child: Obx(
                            () => homeScreenController.captureImageList.isEmpty
                                ? const Center(child: Text('Please Add Image'))
                                : ReorderableGridView.count(
                              crossAxisCount: homeScreenController.crossAxisCount.value,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              // childAspectRatio: 1.5,
                              onReorder: (oldIndex, newIndex) {
                                File path = homeScreenController.captureImageList.removeAt(oldIndex);
                                homeScreenController.captureImageList.insert(newIndex, path);
                              },
                              children: [
                                for(int i = 0; i < homeScreenController.captureImageList.length; i++)
                                  Container(
                                    key: ValueKey(homeScreenController.captureImageList[i]),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: FileImage(File(homeScreenController.captureImageList[i].path)),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        // Image.file(File(homeScreenController.captureImageList[i].path), fit: BoxFit.cover,),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: GestureDetector(
                                            onTap: () {
                                              print('index : $i');
                                              homeScreenController.captureImageList.removeAt(i);
                                            },
                                            child: const Icon(Icons.delete_rounded, color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      /*appBar: AppBar(
        title: const Text('Image List'),
        actions: [
          Obx(
            ()=> homeScreenController.captureImageList.isEmpty
                ? Container()
                : IconButton(
              onPressed: () {
                Get.off(()=> PdfShowScreen());
              },
              icon: const Icon(Icons.check_rounded),
            ),
          ),
        ],
      ),*/

      /*body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
              ()=> homeScreenController.captureImageList.isEmpty
          ? const Center(child: Text('Please Add Image'))
              : ReorderableGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            // childAspectRatio: 1.5,
            onReorder: (oldIndex, newIndex) {
              File path = homeScreenController.captureImageList.removeAt(oldIndex);
              homeScreenController.captureImageList.insert(newIndex, path);
            },
            children: [
              for(int i = 0; i < homeScreenController.captureImageList.length; i++)
                Container(
                  key: ValueKey(homeScreenController.captureImageList[i]),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(homeScreenController.captureImageList[i].path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Image.file(File(homeScreenController.captureImageList[i].path), fit: BoxFit.cover,),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            print('index : $i');
                            homeScreenController.captureImageList.removeAt(i);
                          },
                          child: const Icon(Icons.delete_rounded, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),*/

      floatingActionButton: Container(
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
                  const VerticalDivider(),
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
      ),


    );
  }

  Widget customAppBar(BuildContext context) {
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
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Yes"),
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

  pickSingleImage(context){
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
                    onTap:(){
                      Get.back();
                      getImageFromGallery();
                    },
                    child: const Icon(Icons.collections)),
                const SizedBox(height: 10,),
                GestureDetector(
                    onTap:(){
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
