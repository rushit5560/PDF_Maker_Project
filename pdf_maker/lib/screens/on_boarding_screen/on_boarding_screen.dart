import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/controllers/on_boarding_screen_controller/on_boarding_screen_controller.dart';

import 'on_boarding_screen_widgets.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  OnBoardingScreenController onBoardingScreenController = Get.put(OnBoardingScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundImageModule(),

          Center(
            child: PageView.builder(
              controller: onBoardingScreenController.pageController,
              onPageChanged: onBoardingScreenController.selectedPageIndex,
              itemCount: onBoardingScreenController.onBoardingPages.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(onBoardingScreenController.onBoardingPages[index].imageAsset,
                      height: Get.height * 0.35,),
                    const SizedBox(height: 35),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        onBoardingScreenController.onBoardingPages[index].title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        onBoardingScreenController.onBoardingPages[index].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
