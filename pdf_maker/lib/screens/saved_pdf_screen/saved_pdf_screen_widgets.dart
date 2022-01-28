import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/common/store_draft_data/store_draft_data.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/controllers/saved_pdf_screen_controller/saved_pdf_screen_controller.dart';
import 'package:pdf_maker/screens/image_list_screen/image_list_screen.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';


class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key}) : super(key: key);
  final savedPdfScreenController = Get.find<SavedPdfScreenController>();
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
                  onTap: () => Get.back(),
                  child: Image.asset(ImgUrl.leftArrow, scale: 2.5),
                ),
                const Text(
                  "Draft PDF",
                  style: TextStyle( fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Container(),
                // GestureDetector(
                //   onTap: () {
                //     goToImageListAndMergePdfScreen();
                //   },
                //   child: const Icon(Icons.check_rounded),
                // ),
              ],
            )),
      ),
    );
  }

  goToImageListAndMergePdfScreen() {
    if(savedPdfScreenController.tabController.index == 0){
      for(int i = 0; i < savedPdfScreenController.storeImageList.length; i++) {
        homeScreenController.captureImageList.add(File(savedPdfScreenController.storeImageList[i]));
      }
      Get.off(()=> ImageListScreen());
    } else if (savedPdfScreenController.tabController.index == 1) {
      print('index 1 : ${savedPdfScreenController.tabController.index}');
    }

  }


}

class TabSelectView extends StatelessWidget {
  TabSelectView({Key? key}) : super(key: key);
  final savedPdfScreenController = Get.find<SavedPdfScreenController>();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Colors.black,
      labelPadding: const EdgeInsets.only(top: 20.0),
      unselectedLabelColor: Colors.grey,
      controller:  savedPdfScreenController.tabController,
      labelStyle: const TextStyle(fontSize: 20),
      tabs: [
        Container(
          width: Get.width,
          margin: const EdgeInsets.only(right: 5),
          decoration: borderGradientDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: containerBackgroundGradient(),
                child: const Tab(text: "Draft")),
          ),
        ),
        Container(
          width: Get.width,
          margin: const EdgeInsets.only(left: 5),
          decoration: borderGradientDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: containerBackgroundGradient(),
                child: const Tab(text: "Collage Draft")),
          ),
        ),

      ],
    );
  }
}

class SavedPrefsImagesModule extends StatelessWidget {
  SavedPrefsImagesModule({Key? key}) : super(key: key);
  final savedPdfScreenController = Get.find<SavedPdfScreenController>();

  @override
  Widget build(BuildContext context) {
    return savedPdfScreenController.storeImageList.isEmpty
        ? const Center(child: Text('No Saved Images'))
        : ReorderableGridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            onReorder: (oldIndex, newIndex) {
              String path = savedPdfScreenController.storeImageList.removeAt(oldIndex);
              savedPdfScreenController.storeImageList.insert(newIndex, path);
              savedPdfScreenController.loading();
            },
            children: [
              for (int i = 0; i < savedPdfScreenController.storeImageList.length; i++)
                Container(
                  key: ValueKey(savedPdfScreenController.storeImageList[i]),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      ImageShowModule(i: i),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: ItemDeleteButton(i: i),
                      ),
                    ],
                  ),
                ),
            ],
          );
  }
}

class ImageShowModule extends StatelessWidget {
  int i;

  ImageShowModule({Key? key, required this.i}) : super(key: key);
  final savedPdfScreenController = Get.find<SavedPdfScreenController>();
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    String oneObject = savedPdfScreenController.storeImageList[i];
    List<String> tempList = oneObject.split(',');

    return GestureDetector(
      onTap: () {
        for(int i = 0; i < tempList.length; i++){
          if(i == 0){
            homeScreenController.captureImageList.add(File(tempList[i]));
          } else {
            String sub = tempList[i].substring(1);
            homeScreenController.captureImageList.add(File(sub));
          }
          
        }
        Get.off(()=> ImageListScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(tempList[0])),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ItemDeleteButton extends StatelessWidget {
  int i;
  ItemDeleteButton({Key? key, required this.i}) : super(key: key);
  final savedPdfScreenController =Get.find<SavedPdfScreenController>();
  LocalStorage localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print('index : $i');
        savedPdfScreenController.updateStorageImages(i);
      },
      child: const Icon(Icons.delete_rounded, color: Colors.red),
    );
  }
}


class SavedPrefsPdfModule extends StatelessWidget {
  SavedPrefsPdfModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No Saved Pdf'));
  }
}
