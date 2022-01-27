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
                  CustomFilterAppBarModule(imageFile: imageFile),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Obx(
                            () => filterScreenController.isFilterSelected.value
                                ? RepaintBoundary(
                                    key: filterScreenController.repaintKey,
                                    child: ColorFiltered(
                                      colorFilter: const ColorFilter.mode(
                                          Colors.white, BlendMode.saturation),
                                      child: Image.file(imageFile),
                                    ),
                                  )
                                : Image.file(imageFile),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    ()=> Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              filterScreenController.isFilterSelected.value = false;
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                    'Original',
                                    style: TextStyle(
                                        fontSize: 20,
                                      fontWeight: filterScreenController.isFilterSelected.value
                                      ? FontWeight.normal
                                      : FontWeight.bold
                                    ),
                                  ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              filterScreenController.isFilterSelected.value = true;
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                      'Black & White',
                                    style: TextStyle(
                                      fontSize: 20,
                                        fontWeight: filterScreenController.isFilterSelected.value
                                            ? FontWeight.bold
                                            : FontWeight.normal
                                    ),
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
