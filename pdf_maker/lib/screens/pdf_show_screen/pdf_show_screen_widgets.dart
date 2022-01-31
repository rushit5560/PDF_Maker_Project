import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';

class CustomPdfShowScreenAppBar extends StatelessWidget {
  CustomPdfShowScreenAppBar({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();

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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: Center(
                  child: Image.asset(ImgUrl.backOption),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              decoration: shadowEffectDecoration(),
              child: const Center(
                child: Text(
                  'PDF',
                  style: TextStyle(
                      color: AppColor.kDarkBlueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
              ),
            ),
          ),
          /*const SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              cropController.crop();
              Fluttertoast.showToast(msg: 'Please wait...', toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 1,);
              homeScreenController.isCropping.value = true;

            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.kDarkBlueColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Image.asset(ImgUrl.click),
                ),
              ),
            ),
          ),*/
        ],
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
        homeScreenController.captureImageList.clear();
        Get.back();
        Get.back();
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

}
