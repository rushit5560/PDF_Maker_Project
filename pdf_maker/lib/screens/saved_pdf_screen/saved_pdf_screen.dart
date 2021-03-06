import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/controllers/pdf_merge_screen_controller/pdf_merge_screen_controller.dart';
import 'package:pdf_maker/controllers/saved_pdf_screen_controller/saved_pdf_screen_controller.dart';
import 'saved_pdf_screen_widgets.dart';

class SavedPdfScreen extends StatelessWidget {
  SavedPdfScreen({Key? key}) : super(key: key);
  final savedPdfScreenController = Get.put(SavedPdfScreenController());
  final pdfMergeScreenController = Get.put(PdfMergeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kLightBlueColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Obx(
            () => savedPdfScreenController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.kDarkBlueColor,
                    ),
                  )
                : Column(
                    children: [
                      const CustomSavedPdfScreenAppBar(),
                      const SizedBox(height: 10),
                      Expanded(
                        child: TabBarView(
                          controller: savedPdfScreenController.tabController,
                          children: [
                            SavedPrefsImagesModule(),
                            SavedPrefsPdfModule(),
                          ],
                        ),
                      ),
                      TabSelectView(),
                      SizedBox(height: 10),
                      Container(
                        height: 48,
                        child: savedPdfScreenController.adWidget,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
