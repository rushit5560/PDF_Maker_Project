import 'dart:io';

import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';

class RotateScreen extends StatelessWidget {
  File imageFile;
  RotateScreen({Key? key, required this.imageFile}) : super(key: key);

  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Rotate'),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     homeScreenController.captureImageList.add(imageFile);
          //   },
          //   icon: const Icon(Icons.check_rounded),
          // ),
        ],
      ),

      // body: Container(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: FileImage(File(imageFile.path)),
      //     ),
      //   ),
      // ),
      body: Obx(
        ()=> homeScreenController.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Transform.rotate(
                      angle: Math.pi / 180 * homeScreenController.rotation.value,
                      origin: Offset.zero,
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.of(context).size.height - 130,
                        alignment: Alignment.center,
                        child: Image.file(imageFile),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    homeScreenController.rotation.value += 90;
                    homeScreenController.loading();
                  },
                  child: const SizedBox(
                    height: 90,
                    width: 90,
                    child: Center(
                      child: Icon(
                          Icons.rotate_90_degrees_ccw_rounded,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
