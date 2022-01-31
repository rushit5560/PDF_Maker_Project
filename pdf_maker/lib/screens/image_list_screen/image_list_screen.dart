import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'image_list_screen_widgets.dart';



class ImageListScreen extends StatelessWidget {
  ImageListScreen({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kLightBlueColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              CustomImageListScreenAppBar(),
              const SizedBox(height: 15),
              Expanded(child: SelectedImagesShowModule()),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButtonModule(),


    );
  }

}