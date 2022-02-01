import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PdfMergeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<File> files = RxList();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fileNameController = TextEditingController();


  /*@override
  void onInit() {
    Timer(const Duration(seconds: 2), loading());
    super.onInit();
  }*/

  loading() {
    isLoading(true);
    isLoading(false);
  }
}