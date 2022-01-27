import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterScreenController extends GetxController {
  GlobalKey repaintKey = GlobalKey();
  RxBool isFilterSelected = false.obs;
}