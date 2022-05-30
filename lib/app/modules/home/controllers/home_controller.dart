import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper_for_web/image_cropper_for_web.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxInt currentStep = 0.obs;
  late TextEditingController username;
  final FocusNode f1 = FocusNode();
  Rx<TextEditingController> selectState = TextEditingController().obs;
  Rx<TextEditingController> selectCountry = TextEditingController().obs;
  Rx<TextEditingController> selectStateController = TextEditingController().obs;
  Rx<TextEditingController> selectStoreCategories = TextEditingController().obs;
  Rx<TextEditingController> storeNameController = TextEditingController().obs;
  Rx<TextEditingController> coverageController = TextEditingController().obs;
  Rx<TextEditingController> storeHoursController = TextEditingController().obs;
  Rx<TextEditingController> openingTimeController = TextEditingController().obs;
  Rx<TextEditingController> deliverySpeedController =
      TextEditingController().obs;
  Rx<TextEditingController> deliverySpeedPopUpController =
      TextEditingController().obs;
  RxList<StoreCategoriesModel> storeCategoriesList =
      RxList<StoreCategoriesModel>([]);
  RxList stateList =
      ["Gujarat", "Kerala", "Rajasthan", "Punjab", "Chennai", "Goa"].obs;
  final count = 0.obs;
  RxBool isChecked = false.obs;
  ImagePicker imagePicker = ImagePicker();
  ImageCropperPlugin imageCropper = ImageCropperPlugin();
  RxList<File> imageData = RxList<File>([]);

  RxBool isStorePickUp = false.obs;
  RxBool isHomeDelivery = false.obs;
  @override
  void onInit() {
    super.onInit();
    username = TextEditingController();
    selectStoreCategories.value.text = "Select Store Category";
    selectStateController.value.text = stateList[0];
    deliverySpeedPopUpController.value.text = "Select";
    storeHoursController.value.text = "Mon - Sat";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}

class StoreCategoriesModel {
  String? category;
  int? id;
  StoreCategoriesModel({this.category, this.id});
}
