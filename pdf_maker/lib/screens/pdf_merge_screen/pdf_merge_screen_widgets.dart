import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/common/field_validation.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/common/store_draft_data/store_draft_data.dart';
import 'package:pdf_maker/controllers/pdf_merge_screen_controller/pdf_merge_screen_controller.dart';
import 'package:pdf_merger/pdf_merger.dart';

class CustomPdfMergeScreenAppBar extends StatelessWidget {
  CustomPdfMergeScreenAppBar({Key? key}) : super(key: key);
  final pdfMergeScreenController = Get.find<PdfMergeScreenController>();
  List<String> localList = [];
  LocalStorage localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => showAlertDialog(context),
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
                  'IMAGES',
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

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        pdfMergeScreenController.files.clear();
        Get.back();
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () async {
        //todo
        if(pdfMergeScreenController.files.isNotEmpty){
          localList.clear();
          for(int i = 0; i < pdfMergeScreenController.files.length; i++){
            localList.add(pdfMergeScreenController.files[i].path);
          }
          print('localList : $localList');
          if (kDebugMode) {print('localList : $localList');}
        }

        localStorage.storePdfList(localList);


        pdfMergeScreenController.files.clear();
        Get.back();
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("AlertDialog"),
      content: const Text("Do you want to save in Draft?"),
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


}

class CustomTextFieldModule extends StatelessWidget {
  CustomTextFieldModule({Key? key}) : super(key: key);
  final controller = Get.find<PdfMergeScreenController>();
  List<String> filesPath = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 45,
        child: Row(
          children: [
            Expanded(
              child: Form(
                key: controller.formKey,
                child: TextFormField(
                  controller: controller.fileNameController,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  validator: (value) => FieldValidator().validateFileName(controller.fileNameController.text.trim()),
                  cursorColor: AppColor.kBorderGradientColor3,
                  decoration: fileNameFieldDecoration(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () async {
                if (controller.formKey.currentState!.validate()){
                  await makePdfFunction(controller.fileNameController);
                  if (kDebugMode) {
                    print('Name : ${controller.fileNameController.text.trim()}');
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.kDarkBlueColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                  child: Center(
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 12,
                          color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  makePdfFunction(TextEditingController fileNameController) async {
    if(controller.files.isNotEmpty) {
      for(int i = 0; i < controller.files.length; i++){
        filesPath.add(controller.files[i].path);
      }
      String directory = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS);
      String outPutPath = '$directory' '/${fileNameController.text.trim()}' '.pdf';
      print('outPutPath : $outPutPath');

      MergeMultiplePDFResponse response  = await PdfMerger.mergeMultiplePDF(paths: filesPath, outputDirPath: outPutPath);

      if(response.status == 'success') {
        Get.snackbar('Directory', 'Saved In Document');
        if (kDebugMode) {
          print('msgs : ${response.response}');
        }
      }

      fileNameController.clear();
      Get.back();
    }
  }


}