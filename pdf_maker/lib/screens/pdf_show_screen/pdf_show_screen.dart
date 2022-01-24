import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfShowScreen extends StatelessWidget {
  PdfShowScreen({Key? key}) : super(key: key);

  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pdf Maker'),
      ),

      body: PdfPreview(
        maxPageWidth: 1000,
        canChangeOrientation: true,
        canDebug: false,
        // canChangePageFormat: false,
        initialPageFormat: PdfPageFormat.a4,
        build: (format) => generateDocument(
          format,
          homeScreenController.captureImageList.length,
          homeScreenController.captureImageList,
        ),
      ),

    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format, imagelenght, image) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    for (var im in image) {
      final showImage = pw.MemoryImage(im.readAsBytesSync());

      doc.addPage(
        pw.Page(
          pageTheme: pw.PageTheme(
            pageFormat: format.copyWith(
              marginBottom: 20,
              marginLeft: 20,
              marginRight: 20,
              marginTop: 20,
            ),
            orientation: pw.PageOrientation.portrait,
            // buildBackground: (context) =>
            //     pw.Image(showImage, fit: pw.BoxFit.contain),
            theme: pw.ThemeData.withFont(
              base: font1,
              bold: font2,
            ),
          ),
          build: (context) {
            return pw.Center(
              child: pw.Image(showImage, fit: pw.BoxFit.contain),
            );
          },
        ),
      );
    }

    return await doc.save();
  }
}
