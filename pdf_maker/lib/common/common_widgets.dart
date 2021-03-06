import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/img_url.dart';

import 'custom_color.dart';

class MainBackgroundWidget extends StatelessWidget {
  const MainBackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Image.asset(
        ImgUrl.background2,
        fit: BoxFit.cover,
      ),
    );
  }
}

class HeaderTextModule extends StatelessWidget {
  const HeaderTextModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Scan4PDF",
      style: TextStyle(fontSize: 50),
    );
  }
}

BoxDecoration borderGradientDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    gradient: const LinearGradient(
      colors: [
        AppColor.kBorderGradientColor1,
        AppColor.kBorderGradientColor2,
        AppColor.kBorderGradientColor3,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}

BoxDecoration containerBackgroundGradient() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    image: const DecorationImage(
      image: AssetImage(ImgUrl.pickSingleImage),
      fit: BoxFit.cover,
    ),
  );
}

InputDecoration fileNameFieldDecoration() {
  return InputDecoration(
    hintText: 'File Name',
    hintStyle: const TextStyle(color: Colors.grey),
    isDense: true,
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
  );
}

Decoration shadowEffectDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 10
        ),
      ]
  );
}