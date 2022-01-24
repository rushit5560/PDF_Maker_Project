import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
      appBar: AppBar(
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
      ),

      body: Padding(
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
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => pickSingleImage(context),
        child: const Icon(Icons.add_rounded),
      ),
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
