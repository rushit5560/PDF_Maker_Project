import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfShowScreen extends StatelessWidget {
  PdfShowScreen({Key? key}) : super(key: key);

  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MainBackgroundWidget(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: customAppBar(context),
                ),
                // const SizedBox(height: 15),
                Expanded(
                  child: PdfPreview(
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
                ),
              ],
            ),
          ),
        ],
      ),
      // appBar: AppBar(
      //   title: const Text('Pdf Maker'),
      // ),

      /*body: PdfPreview(
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
      ),*/

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
                  onTap: () => showAlertDialog(context),
                  child: Image.asset(ImgUrl.leftArrow, scale: 2.5),
                ),
                const Text(
                  "PDF",
                  style: TextStyle(
                      fontFamily: "",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Container(),
                // GestureDetector(
                //   onTap: () => Get.off(()=> PdfShowScreen()),
                //   child: const Icon(Icons.check_rounded),
                // ),
              ],
            )),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text(
        "No",
        style: TextStyle(fontFamily: ""),
      ),
      onPressed: () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(fontFamily: ""),
      ),
      onPressed: () async {
        // await _capturePng().then((value) {
          Get.back();
          Get.back();
        // });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("AlertDialog"),
      content: const Text(
        "Do you want to exit?",
        style: TextStyle(),
      ),
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
