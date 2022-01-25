import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'image_list_screen_widgets.dart';



class ImageListScreen extends StatelessWidget {
  ImageListScreen({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();

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
                  CustomAppBar(),
                  const SizedBox(height: 15),
                  Expanded(
                      child: GestureDetector(
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

      floatingActionButton: FloatingActionButtonModule(),


    );
  }


}
