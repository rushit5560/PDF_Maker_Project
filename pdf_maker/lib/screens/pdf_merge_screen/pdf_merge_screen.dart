import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_merger/pdf_merger.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfMergeScreen extends StatefulWidget {
  List<File> files;

  PdfMergeScreen({Key? key, required this.files}) : super(key: key);

  @override
  State<PdfMergeScreen> createState() => _PdfMergeScreenState();
}

class _PdfMergeScreenState extends State<PdfMergeScreen> {
  List<PlatformFile>? files;
  List<String> filesPath = [];
  String? singleFile;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('Files : ${widget.files}');
    }
    return Scaffold(
      body: Stack(
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
                      child: GridView.builder(
                        itemCount: widget.files.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, i) {
                          return SfPdfViewer.file(
                            File("${widget.files[i]}"),
                            pageLayoutMode: PdfPageLayoutMode.continuous,
                          );
                        },
                      ),
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

  Widget customAppBar(BuildContext context) {
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
                  onTap: () {
                    showAlertDialog(context);
                  },
                  child: Image.asset(ImgUrl.leftArrow, scale: 2.5),
                ),
                const Text(
                  "Merge PDF",
                  style: TextStyle(
                      fontFamily: "",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => makePdfFunction(),
                  child: const Icon(Icons.check_rounded),
                ),
              ],
            )),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () async {
        // await _capturePng().then((value) {
        //   Get.back();
        //   Get.back();
        // });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("AlertDialog"),
      content: const Text("Do you want to exit?"),
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

  makePdfFunction() async {
    if(widget.files.isNotEmpty) {
      for(int i = 0; i < widget.files.length; i++){
        filesPath.add(widget.files[i].path);
      }
      Directory tempDir = await getTemporaryDirectory();
      String outPutPath = '${tempDir.path}' '/newMergePdf1' '.pdf';

      MergeMultiplePDFResponse response  = await PdfMerger.mergeMultiplePDF(paths: filesPath, outputDirPath: outPutPath);

      if(response.status == 'success') {
        Get.snackbar('Directory Path', '${response.message}');
        if (kDebugMode) {
          print('msgs : ${response.response}');
        }
      }
    }
  }

}
