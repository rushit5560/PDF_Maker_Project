import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/common/enums.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/common/store_draft_data/store_draft_data.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/controllers/pdf_merge_screen_controller/pdf_merge_screen_controller.dart';
import 'package:pdf_maker/controllers/saved_pdf_screen_controller/saved_pdf_screen_controller.dart';
import 'package:pdf_maker/screens/image_list_screen/image_list_screen.dart';
import 'package:pdf_maker/screens/pdf_merge_screen/pdf_merge_screen.dart';
// import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CustomSavedPdfScreenAppBar extends StatelessWidget {
  const CustomSavedPdfScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
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
                  'SAVED PDF',
                  style: TextStyle(
                    color: AppColor.kDarkBlueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
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
          decoration: BoxDecoration(
            color: AppColor.kDarkBlueColor,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(right: 5),
          child: const Center(
            child: Tab(
              child: Text(
                'Image Draft',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColor.kDarkBlueColor,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(right: 5),
          child: const Center(
            child: Tab(
              child: Text(
                'PDF Draft',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),

      ],
    );
  }
}

class SavedPrefsImagesModule extends StatelessWidget {
  SavedPrefsImagesModule({Key? key}) : super(key: key);
  final savedPdfScreenController = Get.find<SavedPdfScreenController>();
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return savedPdfScreenController.storeImageList.isEmpty
        ? const Center(child: Text('No Saved Images'))
        : Padding(
          padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        itemCount: savedPdfScreenController.storeImageList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, i){
          return Container(
            key: ValueKey(savedPdfScreenController.storeImageList[i]),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              // alignment: Alignment.bottomCenter,
              children: [
                ImageShowModule(i: i),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: ItemDeleteButton(i: i),
                ),

                Positioned(
                        bottom: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            String oneObject =
                                savedPdfScreenController.storeImageList[i];
                            List<String> tempList = oneObject.split(',');

                            Fluttertoast.showToast(msg: 'Please wait');
                            for (int i = 0; i < tempList.length; i++) {
                              if (i == 0) {
                                homeScreenController.captureImageList.add(File(tempList[i]));
                              } else {
                                String sub = tempList[i].substring(1);
                                homeScreenController.captureImageList.add(File(sub));
                              }
                            }
                            String listString = homeScreenController.captureImageList.toString();
                            Get.to(() => ImageListScreen(
                                  comingFrom: ComingFrom.savedList,
                                  index: i,
                                  listString: listString,
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColor.kDarkBlueColor),
                            child: const Icon(
                              Icons.arrow_right_alt_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
            ),
          );
        },
      ),
        );
  }
}
class ImageShowModule extends StatelessWidget {
  final int i;
  ImageShowModule({Key? key, required this.i}) : super(key: key);

  final savedPdfScreenController = Get.find<SavedPdfScreenController>();
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    String oneObject = savedPdfScreenController.storeImageList[i];
    List<String> tempList = oneObject.split(',');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: FileImage(File(tempList[0])),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
class ItemDeleteButton extends StatelessWidget {
  final int i;
  ItemDeleteButton({Key? key, required this.i}) : super(key: key);
  final savedPdfScreenController =Get.find<SavedPdfScreenController>();
  final LocalStorage localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print('index : $i');
        savedPdfScreenController.updateStorageImages(i);
        Fluttertoast.showToast(msg: 'Selected Draft Successfully Deleted');
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.kDarkBlueColor
        ),
        child: const Icon(
          Icons.delete_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

class SavedPrefsPdfModule extends StatelessWidget {
  SavedPrefsPdfModule({Key? key}) : super(key: key);
  final savedPdfScreenController = Get.find<SavedPdfScreenController>();
  final pdfMergeScreenController = Get.find<PdfMergeScreenController>();

  @override
  Widget build(BuildContext context) {
    return savedPdfScreenController.storePdfList.isEmpty
    ? const Center(child: Text("No Saved PDF"))
    : Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        itemCount: savedPdfScreenController.storePdfList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index){
          String oneObject = savedPdfScreenController.storePdfList[index];
          List<String> tempList = oneObject.split(',');
          print('index : $index');
          String path = '';
          if(index == 0){
            path = tempList[index];
          } else {
            path = tempList[0];
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              // alignment: Alignment.bottomCenter,
              children: [
                PdfShowModule(i: index, filePath: /*tempList[index]*/path),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: PdfDeleteButton(i: index),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(msg: 'Please wait');
                      for(int i = 0; i < tempList.length; i++){
                        if(i == 0){
                          pdfMergeScreenController.files.add(File(tempList[i]));
                        } else {
                          String sub = tempList[i].substring(1);
                          pdfMergeScreenController.files.add(File(sub));
                        }
                      }
                      Get.off(()=> PdfMergeScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.kDarkBlueColor
                      ),
                      child: const Icon(
                        Icons.arrow_right_alt_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
class PdfShowModule extends StatelessWidget {
  final int i;
  final  String filePath;

  PdfShowModule({Key? key, required this.i, required this.filePath}) : super(key: key);
  final savedPdfScreenController = Get.find<SavedPdfScreenController>();

  @override
  Widget build(BuildContext context) {
    // String oneObject = savedPdfScreenController.storePdfList[i];
    // List<String> tempList = oneObject.split(',');
    print('filePath :$filePath');

    return SfPdfViewer.file(
      File(filePath),
      canShowScrollHead: false,
      enableDoubleTapZooming: false,
      enableTextSelection: false,
      interactionMode: PdfInteractionMode.pan,
    );
  }
}
class PdfDeleteButton extends StatelessWidget {
  final int i;
  PdfDeleteButton({Key? key, required this.i}) : super(key: key);
  final savedPdfScreenController =Get.find<SavedPdfScreenController>();
  final LocalStorage localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        savedPdfScreenController.updateStoragePdfs(i);
        Fluttertoast.showToast(msg: 'Selected Draft Successfully Deleted');
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.kDarkBlueColor
        ),
        child: const Icon(
          Icons.delete_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

