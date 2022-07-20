import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/common/enums.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_maker/controllers/pdf_show_screen_controller/pdf_show_screen_controller.dart';
import 'package:pdf_maker/screens/pdf_show_screen/pdf_show_screen_widgets.dart';
import 'package:printing/printing.dart';



class PdfShowScreen extends StatelessWidget {
  int? index;
  ComingFrom comingFrom;
  String listString;
  PdfShowScreen({Key? key, required this.comingFrom, this.index, required this.listString}) : super(key: key);

  final homeScreenController = Get.find<HomeScreenController>();
  final pdfShowScreenController = Get.put(PdfShowScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        String newListString = homeScreenController.captureImageList.toString();

        if(comingFrom == ComingFrom.newList) {
          showAlertDialog(context);
        } else if(comingFrom == ComingFrom.savedList){
          if(listString == newListString) {
            homeScreenController.captureImageList.clear();
            Get.back();
          } else {
            showAlertDialog(context);
          }
        }
        return null!;
      },
      child: Scaffold(
        backgroundColor: AppColor.kLightBlueColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: CustomPdfShowScreenAppBar(
                    comingFrom: comingFrom,
                    index: index,
                    listString: listString,
                  ),
                ),
                const SizedBox(height: 15),

                Expanded(
                  child: PdfPreview(
                    maxPageWidth: 1000,
                    canChangeOrientation: true,
                    canDebug: false,
                    initialPageFormat: PdfPageFormat.a4,
                    build: (format) => generateDocument(
                      format,
                      homeScreenController.captureImageList.length,
                      homeScreenController.captureImageList,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 48,
                  child: pdfShowScreenController.adWidget,
                ),

              ],
            ),
          ),
        ),
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
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(fontFamily: ""),
      ),
      onPressed: () async {
        if(homeScreenController.captureImageList.isNotEmpty) {
          homeScreenController.localList.clear();
          for(int i = 0; i < homeScreenController.captureImageList.length; i++){
            homeScreenController.localList.add(homeScreenController.captureImageList[i].path);
          }
          if (kDebugMode) {print('localList : ${homeScreenController.localList}');}

          if(homeScreenController.localList.isNotEmpty){
            await homeScreenController.localStorage.storeSingleImageList(
              subList: homeScreenController.localList,
              comingFrom: comingFrom,
              index: index,
            );
          }
          homeScreenController.captureImageList.clear();
        }
        homeScreenController.interstitialAd.show();
        Get.back();
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("AlertDialog"),
      content: const Text(
        "Do you want to save in Draft ?",
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
