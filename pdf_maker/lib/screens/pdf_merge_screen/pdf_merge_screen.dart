import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/common/store_draft_data/store_draft_data.dart';
import 'package:pdf_maker/controllers/pdf_merge_screen_controller/pdf_merge_screen_controller.dart';
import 'package:pdf_maker/screens/pdf_merge_screen/pdf_merge_screen_widgets.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PdfMergeScreen extends StatefulWidget {
  // List<File> files;
  // PdfMergeScreen({Key? key, required this.files}) : super(key: key);
  @override
  State<PdfMergeScreen> createState() => _PdfMergeScreenState();
}

class _PdfMergeScreenState extends State<PdfMergeScreen> {
  final pdfMergeScreenController = Get.find<PdfMergeScreenController>();
  // GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LocalStorage localStorage = LocalStorage();
  // TextEditingController fileNameController = TextEditingController();
  List<PlatformFile>? files;
  List<String> filesPath = [];
  String? singleFile;
  List<String> localList = [];

  // Future<bool> checkPermission() async {
  //   await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  //   PermissionStatus permission = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.storage);
  //   print(permission);
  //   if (permission == PermissionStatus.neverAskAgain) {
  //     print("Go to Settings and provide media access");
  //     return false;
  //   } else if (permission == PermissionStatus.granted) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kLightBlueColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomPdfMergeScreenAppBar(),
              const SizedBox(height: 15),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: ReorderableGridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    onReorder: (oldIndex, newIndex) {
                      File path = pdfMergeScreenController.files.removeAt(oldIndex);
                      pdfMergeScreenController.files.insert(newIndex, path);
                    },
                    children: [
                      for(int i = 0; i < pdfMergeScreenController.files.length; i++)
                        Container(
                          key: ValueKey(pdfMergeScreenController.files[i]),
                          child: SfPdfViewer.file(
                            File(pdfMergeScreenController.files[i].path),
                            pageLayoutMode: PdfPageLayoutMode.continuous,
                            interactionMode: PdfInteractionMode.pan,
                          ),
                        )

                    ],
                  ),
                ),
              ),


              CustomTextFieldModule(),
            ],
          ),
        ),
      ),
      /*body: Stack(
        children: [
          const MainBackgroundWidget(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  customAppBar(context),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: ReorderableGridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        onReorder: (oldIndex, newIndex) {
                          File path = pdfMergeScreenController.files.removeAt(oldIndex);
                          pdfMergeScreenController.files.insert(newIndex, path);
                        },
                        children: [
                          for(int i = 0; i < pdfMergeScreenController.files.length; i++)
                            Container(
                              key: ValueKey(pdfMergeScreenController.files[i]),
                              child: SfPdfViewer.file(
                                File(pdfMergeScreenController.files[i].path),
                                pageLayoutMode: PdfPageLayoutMode.continuous,
                                interactionMode: PdfInteractionMode.pan,
                              ),
                            )

                        ],
                      ),
                    ),
                  ),
                  customTextField(),
                ],
              ),
            ),
          ),
        ],
      ),*/

    );
  }

  // Widget customTextField() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Form(
  //             key: formKey,
  //             child: TextFormField(
  //               controller: fileNameController,
  //               maxLines: 1,
  //               keyboardType: TextInputType.text,
  //               validator: (value) => FieldValidator().validateFileName(fileNameController.text.trim()),
  //               cursorColor: AppColor.kBorderGradientColor3,
  //               decoration: fileNameFieldDecoration(),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(width: 10),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: GestureDetector(
  //             onTap: () async {
  //               if (formKey.currentState!.validate()){
  //                 await makePdfFunction(fileNameController);
  //                 if (kDebugMode) {
  //                   print('Name : ${fileNameController.text.trim()}');
  //                 }
  //               }
  //             },
  //             child: Container(
  //               decoration: borderGradientDecoration(),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(3),
  //                 child: Container(
  //                   decoration: containerBackgroundGradient(),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: const [
  //                       Padding(
  //                         padding: EdgeInsets.all(8.0),
  //                         child: Text(
  //                           "Save",
  //                           style: TextStyle(fontSize: 20),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /*addPDFFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
    if (result != null) {
      pdfMergeScreenController.files.value = result.paths.map((path) => File(path!)).toList();

    }
  }*/

  // showAlertDialog(BuildContext context) {
  //   Widget cancelButton = TextButton(
  //     child: const Text("No"),
  //     onPressed: () {
  //       Get.back();
  //     },
  //   );
  //
  //   Widget continueButton = TextButton(
  //     child: const Text("Yes"),
  //     onPressed: () async {
  //
  //       if(pdfMergeScreenController.files.isNotEmpty){
  //         localList.clear();
  //         for(int i = 0; i < pdfMergeScreenController.files.length; i++){
  //           localList.add(pdfMergeScreenController.files[i].path);
  //         }
  //         print('localList : $localList');
  //         if (kDebugMode) {print('localList : $localList');}
  //       }
  //
  //       localStorage.storePdfList(localList);
  //
  //
  //       pdfMergeScreenController.files.clear();
  //       Get.back();
  //       Get.back();
  //     },
  //   );
  //
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     //title: Text("AlertDialog"),
  //     content: const Text("Do you want to save in Draft?"),
  //     actions: [
  //       cancelButton,
  //       continueButton,
  //     ],
  //   );
  //
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  // makePdfFunction(TextEditingController fileNameController) async {
  //   if(pdfMergeScreenController.files.isNotEmpty) {
  //     for(int i = 0; i < pdfMergeScreenController.files.length; i++){
  //       filesPath.add(pdfMergeScreenController.files[i].path);
  //     }
  //     String directory = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS);
  //     String outPutPath = '$directory' '/${fileNameController.text.trim()}' '.pdf';
  //     print('outPutPath : $outPutPath');
  //
  //     MergeMultiplePDFResponse response  = await PdfMerger.mergeMultiplePDF(paths: filesPath, outputDirPath: outPutPath);
  //
  //     if(response.status == 'success') {
  //       Get.snackbar('Directory', 'Saved In Document');
  //       if (kDebugMode) {
  //         print('msgs : ${response.response}');
  //       }
  //     }
  //
  //     fileNameController.clear();
  //     Get.back();
  //   }
  // }

}
