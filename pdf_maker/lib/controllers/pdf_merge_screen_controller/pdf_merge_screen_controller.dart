import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PdfMergeScreenController extends GetxController {
  RxList<File> files = RxList();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fileNameController = TextEditingController();
}