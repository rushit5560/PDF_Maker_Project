import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/common/img_url.dart';

class CustomSettingScreenAppBar extends StatelessWidget {
  CustomSettingScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.kDarkBlueColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Image.asset(ImgUrl.backOption, height: 15, width: 15),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              decoration: shadowEffectDecoration(),
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    'SETTINGS',
                    style: TextStyle(
                        color: AppColor.kDarkBlueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}

class UserProfileDetailsModule extends StatelessWidget {
  UserProfileDetailsModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColor.kDarkBlueColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(
                    ImgUrl.profilePicture,
                  height: 42,
                  width: 42,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'John Doe',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 3),
            const Text(
              'johndoe@demo.com',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutAppModule extends StatelessWidget {
  AboutAppModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.kSettingModuleColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 22,
            width: 22,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImgUrl.aboutApp),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Text(
              'ABOUT APP',
              style: TextStyle(
                color: AppColor.kDarkBlueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HelpModule extends StatelessWidget {
  HelpModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.kSettingModuleColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 22,
            width: 22,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImgUrl.help),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Text(
              'HELP',
              style: TextStyle(
                color: AppColor.kDarkBlueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignOutModule extends StatelessWidget {
  SignOutModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.kSettingModuleColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 22,
            width: 22,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImgUrl.signOut),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Text(
              'SIGNOUT',
              style: TextStyle(
                color: AppColor.kDarkBlueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
