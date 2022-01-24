import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
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
      appBar: AppBar(title: const Text('Merge PDF')),
      body: Container(
        margin: const EdgeInsets.all(25),
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

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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

        },
        child: const Icon(Icons.check_rounded),
      ),
    );
  }

}
