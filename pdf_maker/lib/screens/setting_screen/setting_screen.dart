import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/controllers/setting_screen_controller/setting_screen_controller.dart';
import 'package:pdf_maker/screens/setting_screen/setting_screen_widgets.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  final settingScreenController = Get.put(SettingScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kLightBlueColor,
      body: Obx(
        ()=> settingScreenController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
         : SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                CustomSettingScreenAppBar(),
                const SizedBox(height: 15),
                UserProfileDetailsModule(),
                const SizedBox(height: 15),
                AboutAppModule(),
                const SizedBox(height: 15),
                HelpModule(),
                const SizedBox(height: 15),
                SignOutModule(),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
