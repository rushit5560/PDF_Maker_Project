import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/controllers/filter_screen_controller/filter_screen_controller.dart';
import 'filter_screen_widgets.dart';


class FilterScreen extends StatelessWidget {
  File imageFile;
  FilterScreen({Key? key, required this.imageFile}) : super(key: key);

  final filterScreenController = Get.put(FilterScreenController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          const MainBackgroundWidget(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const CustomFilterAppBarModule(),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: RepaintBoundary(
                            key: filterScreenController.repaintKey,
                            child: ColorFiltered(
                                colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.saturation),
                                child: Image.file(imageFile),
                            ),
                          ),
                          // child: RepaintBoundary(
                          //   key: filterScreenController.repaintKey,
                          //   child: Container(
                          //     child: Image.file(imageFile),
                          //     foregroundDecoration: const BoxDecoration(
                          //       color: Colors.white,
                          //       backgroundBlendMode: BlendMode.saturation,
                          //     ),
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
