import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:kriips_web/Utilities/color_constant.dart';
import 'package:kriips_web/Utilities/text_field.dart';

import '../../../../Utilities/sizeConstant.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Obx(() {
        return Container(
          height: MySize.screenHeight,
          width: MySize.screenWidth,
          padding: EdgeInsets.symmetric(horizontal: MySize.size20!),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MySize.size15!,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/logo.svg",
                      height: MySize.size47,
                      width: MySize.size147,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Having Trouble? ',
                        style: TextStyle(
                          color: appTheme.textGrayColor,
                        ),
                        // style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Get Help ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: appTheme.primaryTheme)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MySize.screenWidth,
                  child: Theme(
                    data: ThemeData(
                        accentColor: appTheme.primaryTheme,
                        // primarySwatch: Colors.orange,
                        colorScheme:
                            ColorScheme.light(primary: appTheme.primaryTheme)),
                    child: Stepper(
                      steps: [
                        Step(
                          title: Text('Account'),
                          content: Container(
                            //width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Wrap(
                                  runSpacing: MySize.getScaledSizeHeight(5),
                                  children: [
                                    Container(
                                      width: MySize.getScaledSizeWidth(498),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          getStoreCategoriesField(),
                                          Space.height(5),
                                          getCategoryChips(),
                                        ],
                                      ),
                                    ),
                                    Space.width(30),
                                    Container(
                                      width: MySize.getScaledSizeWidth(498),
                                      child: getTextFormField(
                                        textEditingController: controller
                                            .storeNameController.value,
                                        labelText: "Store Name",
                                        hintText: "Store Name",
                                      ),
                                    ),
                                  ],
                                ),
                                deliveryOption(),
                              ],
                            ),
                          ),
                          isActive: controller.currentStep >= 0,
                          state: controller.currentStep >= 0
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: new Text('Address'),
                          content: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Home Address'),
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Postcode'),
                              ),
                            ],
                          ),
                          isActive: controller.currentStep.value >= 0,
                          state: controller.currentStep.value >= 1
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: new Text('Mobile Number'),
                          content: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Mobile Number'),
                              ),
                            ],
                          ),
                          isActive: controller.currentStep.value >= 0,
                          state: controller.currentStep.value >= 2
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                      ],
                      physics: ScrollPhysics(),
                      type: StepperType.horizontal,
                      currentStep: controller.currentStep.value,
                      onStepTapped: (val) {
                        controller.currentStep.value = val;
                      },
                      elevation: 0,
                      onStepContinue: () {
                        controller.currentStep < 2
                            ? controller.currentStep.value += 1
                            : null;
                      },
                      onStepCancel: () {
                        controller.currentStep > 0
                            ? controller.currentStep.value -= 1
                            : null;
                      },
                      margin: EdgeInsets.symmetric(vertical: MySize.size10!),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Row getStoreCategoriesField() {
    return Row(
      children: [
        PopupMenuButton(
            offset: Offset(0, MySize.getScaledSizeHeight(50)),
            child: Container(
              width: MySize.getScaledSizeWidth(498),
              child: getTextFormField(
                  textEditingController: controller.selectStoreCategories.value,
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  labelText: "Store Categories",
                  isReadOnly: true,
                  enable: false,
                  ontap: () {
                    print("test");
                  }),
            ),
            itemBuilder: (context) {
              return List.generate(
                  10,
                  (index) => PopupMenuItem(
                        child: Text("Category ${index + 1}"),
                        onTap: () {
                          bool isAvailable = false;
                          controller.storeCategoriesList.forEach((element) {
                            if (element.id == ((index + 1))) {
                              isAvailable = true;
                            }
                          });
                          if (!isAvailable) {
                            controller.storeCategoriesList.add(
                                StoreCategoriesModel(
                                    category: "Category ${index + 1}",
                                    id: (index + 1)));
                          }
                        },
                      ));
            }),
      ],
    );
  }

  getCategoryChips() {
    return Wrap(
      children: List.generate(controller.storeCategoriesList.length, (index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(MySize.getScaledSizeHeight(20))),
          child: Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(MySize.getScaledSizeHeight(20))),
            height: MySize.getScaledSizeHeight(35),
            width: MySize.getScaledSizeWidth(78),
            alignment: Alignment.center,
            padding: Spacing.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Text(
                  controller.storeCategoriesList[index].category.toString(),
                  style: TextStyle(fontSize: MySize.getScaledSizeHeight(16)),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    controller.storeCategoriesList.removeAt(index);
                  },
                  child: Icon(
                    Icons.close,
                    color: appTheme.primaryTheme,
                    size: MySize.getScaledSizeHeight(15),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  deliveryOption() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivery Options",
          style: TextStyle(
              fontSize: MySize.getScaledSizeHeight(20),
              fontWeight: FontWeight.bold),
        ),
        Space.height(10),
        Row(
          children: [
            Checkbox(
                value: controller.isStorePickUp.value,
                // checkColor: Color(0xff585B71),
                // activeColor: Colors.white,
                // side: BorderSide(
                //   color: Color(0xff585B71),
                // ),
                // focusColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  // side: BorderSide(
                  //   color: Color(0xff585B71),
                  // ),
                  borderRadius:
                      BorderRadius.circular(MySize.getScaledSizeHeight(3)),
                ),
                onChanged: (val) {
                  controller.isStorePickUp.value = val!;
                }),
            Text(
              "Store Pick-up",
              style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: MySize.getScaledSizeHeight(16)),
            ),
            Checkbox(
                value: controller.isHomeDelivery.value,
                onChanged: (val) {
                  controller.isHomeDelivery.value = val!;
                }),
            Text(
              "Home Delivery",
              style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: MySize.getScaledSizeHeight(16)),
            ),
          ],
        ),
        Space.height(21),
        Row(
          children: [
            Container(
              width: MySize.getScaledSizeWidth(157),
              child: getTextFormField(
                  labelText: "Area Coverage",
                  textEditingController: controller.coverageController.value),
            ),
            Space.width(10),
            Container(
              width: MySize.getScaledSizeWidth(157),
              child: getTextFormField(
                  labelText: "Delivery Speed",
                  textEditingController:
                      controller.deliverySpeedController.value),
            ),
            Space.width(10),
            PopupMenuButton(
                offset: Offset(0, MySize.getScaledSizeHeight(50)),
                child: Container(
                  width: MySize.getScaledSizeWidth(157),
                  child: getTextFormField(
                      textEditingController:
                          controller.deliverySpeedPopUpController.value,
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      labelText: "Delivery Speed",
                      isReadOnly: true,
                      enable: false,
                      ontap: () {
                        print("test");
                      }),
                ),
                itemBuilder: (context) {
                  return List.generate(
                      10,
                      (index) => PopupMenuItem(
                            child: Text("Category ${index + 1}"),
                          ));
                }),
          ],
        ),
      ],
    );
  }
}
