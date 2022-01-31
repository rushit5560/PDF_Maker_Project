import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/common/img_url.dart';
import 'package:pdf_maker/controllers/on_boarding_screen_controller/on_boarding_screen_controller.dart';

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

class DotIndicatorModule extends StatelessWidget {
  DotIndicatorModule({Key? key}) : super(key: key);
  final onBoardingScreenController = Get.find<OnBoardingScreenController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(onBoardingScreenController.onBoardingPages.length,
            (index) => Obx(() => Container(
          margin: const EdgeInsets.all(4),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: onBoardingScreenController.selectedPageIndex.value == index
                  ? AppColor.kDotColor
                  : AppColor.kLightBlueColor,
              shape: BoxShape.circle
          ),
        ),
        ),
      ),
    );
  }
}

class NextButtonModule extends StatelessWidget {
  NextButtonModule({Key? key}) : super(key: key);
  final onBoardingScreenController = Get.find<OnBoardingScreenController>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: AppColor.kLightBlueColor,
      onPressed: onBoardingScreenController.forwardAction,
      child: Obx(()=> Text(
          onBoardingScreenController.isLastPage ? 'Start' : 'Next',
        style: const TextStyle(color: AppColor.kDarkBlueColor),
      ),
      ),
    );
  }
}
