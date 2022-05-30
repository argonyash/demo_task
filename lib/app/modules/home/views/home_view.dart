import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:image_cropper_for_web/image_cropper_for_web.dart';
import 'package:image_picker/image_picker.dart';
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
                          title: new Text('Account'),
                          content: Container(
                            //width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                basicDetails(),
                                storeGallery(context),
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
              )
            ],
          ),
        );
      }),
    );
  }

  Widget basicDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Basic Store/Business information",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: MySize.size18,
          ),
        ),
        Spacing.height(13),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: controller.isChecked.value,
              onChanged: (value) {
                controller.isChecked.toggle();
              },
            ),
            Spacing.width(5),
            Text(
              "Same as Business Address",
              style: TextStyle(
                color: appTheme.textGrayColor,
                fontWeight: FontWeight.normal,
                fontSize: MySize.size14,
              ),
            ),
          ],
        ),
        Spacing.height(33),
        Wrap(
          children: [
            Container(
              width: MySize.getScaledSizeWidth(498),
              child: getTextFormField(
                  hintText: "Enter Registered Business Address",
                  labelText: "Registered Business Address"),
              margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
            ),
            Spacing.width(28),
            Container(
              width: MySize.getScaledSizeWidth(498),
              child: getTextFormField(
                  hintText: "Enter Office No",
                  labelText: "Office No, Building, Lane etc (optional) "),
              margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
            ),
            Spacing.width(28),
            Container(
              width: MySize.getScaledSizeWidth(498),
              child:
                  getTextFormField(hintText: "Enter City", labelText: "City"),
              margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
            ),
            Spacing.width(28),
            Container(
              width: MySize.getScaledSizeWidth(498),
              child: getTextFormField(
                  textEditingController: controller.selectState.value,
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  labelText: "State",
                  isReadOnly: true,
                  enable: false,
                  ontap: () {
                    print("test");
                  }),
              margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
            ),
            Spacing.width(28),
            Container(
              width: MySize.getScaledSizeWidth(498),
              child: getTextFormField(
                  textEditingController: controller.selectCountry.value,
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  labelText: "Country",
                  isReadOnly: true,
                  enable: false,
                  ontap: () {
                    print("test");
                  }),
              margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
            ),
            Spacing.width(28),
            Container(
              width: MySize.getScaledSizeWidth(498),
              child: getTextFormField(
                  hintText: "Enter PIN code ", labelText: "Store PIN code"),
              margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
            ),
            Spacing.width(28),
            Container(
              width: MySize.getScaledSizeWidth(498),
              child: getTextFormField(
                  hintText: "Enter Store License Number ",
                  labelText: "Store License Number "),
              margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
            ),
            Spacing.width(28),
            Container(
              width: MySize.getScaledSizeWidth(498),
              child: getTextFormField(
                  hintText: "Enter GST Number", labelText: "GST Number"),
              margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
            ),
            Spacing.width(28),
            Container(
              width: MySize.getScaledSizeWidth(498),
              child:
                  getTextFormField(hintText: "Enter Email", labelText: "Email"),
              margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
            ),
            Spacing.width(28),
            Container(
              width: MySize.getScaledSizeWidth(498),
              child: getTextFormField(
                  hintText: "Enter Telephone Number",
                  labelText: "Telephone Number"),
              margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
            ),
            Spacing.width(28),
            Container(
              width: MySize.getScaledSizeWidth(498),
              child: getTextFormField(
                  hintText: "Enter Store Map Location",
                  labelText: "Store Map Location",
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(MySize.size8!),
                    child: SvgPicture.asset("assets/pin.svg"),
                  )),
              margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
            ),
          ],
        )
      ],
    );
  }

  Widget storeGallery(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MySize.getScaledSizeHeight(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Store Gallery",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: MySize.size18,
                    ),
                  ),
                  Spacing.height(20),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          final xFile = await controller.imagePicker
                              .pickImage(source: ImageSource.gallery);
                          if (xFile != null) {
                            Get.back();
                            await _cropImage(xFile.path, context);
                          }
                        },
                        child: SvgPicture.asset(
                          "assets/upload.svg",
                        ),
                      ),
                      if (!isNullEmptyOrFalse(controller.imageData))
                        for (int i = 0; i < controller.imageData.length; i++)
                          Image(
                            image: NetworkImage(controller.imageData[i].path),
                            width: MySize.getScaledSizeWidth(100),
                            height: MySize.getScaledSizeHeight(100),
                            fit: BoxFit.cover,
                          )
                    ],
                  )
                ],
              ),
            ],
          ),
          Spacing.height(13),
        ],
      ),
    );
  }

  Future<void> _cropImage(String filePath, BuildContext context) async {
    print(filePath);
    CroppedFile? file = await controller.imageCropper.cropImage(
      sourcePath: filePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        WebUiSettings(
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          boundary: Boundary(
            width: MySize.getScaledSizeWidth(480).toInt(),
            height: MySize.getScaledSizeWidth(480).toInt(),
          ),
          viewPort: ViewPort(
              width: MySize.getScaledSizeWidth(480).toInt(),
              height: MySize.getScaledSizeWidth(480).toInt(),
              type: 'square'),
          enableExif: true,
          enableZoom: true,
          showZoomer: true,
          enableResize: true,
        ),
      ],
    );
    if (file != null) {
      controller.imageData.add(File(file.path));
    }
  }
}
