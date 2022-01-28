import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/img_url.dart';

class BackGroundImageModule extends StatelessWidget {
  const BackGroundImageModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImgUrl.serviceBg),
          fit: BoxFit.cover
        ),
      ),
    );
  }
}
