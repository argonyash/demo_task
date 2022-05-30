import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper_for_web/image_cropper_for_web.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxInt currentStep = 0.obs;
  late TextEditingController username;
  Rx<TextEditingController> selectState = TextEditingController().obs;
  Rx<TextEditingController> selectCountry = TextEditingController().obs;
  final count = 0.obs;
  RxBool isChecked = false.obs;
  ImagePicker imagePicker = ImagePicker();
  ImageCropperPlugin imageCropper = ImageCropperPlugin();
  RxList<File> imageData = RxList<File>([]);

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
