import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxInt currentStep = 0.obs;
  late TextEditingController username;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    username = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
