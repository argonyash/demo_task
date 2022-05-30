import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxInt currentStep = 0.obs;
  late TextEditingController username;
  Rx<TextEditingController> selectStoreCategories = TextEditingController().obs;
  Rx<TextEditingController> storeNameController = TextEditingController().obs;
  Rx<TextEditingController> coverageController = TextEditingController().obs;
  Rx<TextEditingController> deliverySpeedController =
      TextEditingController().obs;
  Rx<TextEditingController> deliverySpeedPopUpController =
      TextEditingController().obs;
  RxList<StoreCategoriesModel> storeCategoriesList =
      RxList<StoreCategoriesModel>([]);
  final count = 0.obs;
  RxBool isStorePickUp = false.obs;
  RxBool isHomeDelivery = false.obs;
  @override
  void onInit() {
    super.onInit();
    username = TextEditingController();
    selectStoreCategories.value.text = "Select Store Category";
    deliverySpeedPopUpController.value.text = "Select";
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
