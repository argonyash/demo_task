import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:image_cropper_for_web/image_cropper_for_web.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kriips_web/Utilities/color_constant.dart';
import 'package:kriips_web/Utilities/text_field.dart';
import 'package:photo_view/photo_view.dart';

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
          padding: EdgeInsets.symmetric(horizontal: MySize.size50!),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MySize.size15!,
                ),
                child: Container(
                  width: MySize.getScaledSizeWidth(990),
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
                              fontFamily: "Poppins"),
                          // style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Get Help ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins",
                                    color: appTheme.primaryTheme)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MySize.getScaledSizeWidth(1025),
                // height: MySize.getScaledSizeHeight(100),
                // height: MySize.getScaledSizeHeight(110),
                //color: Colors.red,

                margin: EdgeInsets.only(top: MySize.getScaledSizeHeight(80)),
                child: Center(
                  child: Image(
                    image: AssetImage("assets/stepper.png"),
                    width: MySize.getScaledSizeWidth(1000),
                    // height: MySize.getScaledSizeHeight(110),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //Space.height(15),
              Expanded(
                child: Container(
                  width: MySize.getScaledSizeWidth(1025),
                  //  margin: EdgeInsets.only(top: MySize.getScaledSizeHeight(30)),
                  alignment: Alignment.center,
                  child: Theme(
                    data: ThemeData(
                        accentColor: appTheme.primaryTheme,
                        // primarySwatch: Colors.orange,
                        colorScheme:
                            ColorScheme.light(primary: appTheme.primaryTheme)),
                    child: Center(
                      child: Container(
                        padding:
                            EdgeInsets.only(top: MySize.getScaledSizeHeight(0)),
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Space.height(30),
                              Wrap(
                                runSpacing: MySize.getScaledSizeHeight(5),
                                spacing: MySize.getScaledSizeWidth(28),
                                children: [
                                  Container(
                                    width: MySize.getScaledSizeWidth(480),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getStoreCategoriesField(),
                                        Space.height(10),
                                        getCategoryChips(),
                                      ],
                                    ),
                                  ),
                                  // Space.width(40),
                                  Container(
                                    width: MySize.getScaledSizeWidth(480),
                                    child: getTextFormField(
                                      textEditingController:
                                          controller.storeNameController.value,
                                      labelText: "Store Name",
                                      hintText: "Store Name",
                                    ),
                                  ),
                                ],
                              ),
                              basicDetails(),
                              // Space.height(30),
                              Wrap(
                                runSpacing: MySize.getScaledSizeHeight(5),
                                spacing: MySize.getScaledSizeWidth(28),
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  storeGallery(context),
                                  deliveryOption(),
                                ],
                              ),
                              gertStoreHours(),
                              Space.height(40),

                              Center(
                                child: Image(
                                  image: AssetImage("assets/login.png"),
                                  height: MySize.size50,
                                  width: MySize.size50,
                                ),
                              ),
                              Space.height(80),
                            ],
                          ),
                        ),
                      ),
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
              width: MySize.getScaledSizeWidth(480),
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
                        child: Text(
                          "Category ${index + 1}",
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
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

  Widget basicDetails() {
    return Padding(
      padding: EdgeInsets.only(top: MySize.size30!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Basic Store/Business information",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: MySize.size20,
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
                  fontSize: MySize.size18,
                ),
              ),
            ],
          ),
          Spacing.height(33),
          Wrap(
            spacing: MySize.getScaledSizeWidth(28),
            runSpacing: MySize.getScaledSizeHeight(10),
            children: [
              Container(
                width: MySize.getScaledSizeWidth(480),
                child: getTextFormField(
                    hintText: "Enter Registered Business Address",
                    labelText: "Registered Business Address"),
                margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
              ),

              Container(
                width: MySize.getScaledSizeWidth(480),
                child: getTextFormField(
                    hintText: "Enter Office No",
                    labelText: "Office No, Building, Lane etc (optional) "),
                margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
              ),
              //Spacing.width(28),
              Container(
                width: MySize.getScaledSizeWidth(480),
                child:
                    getTextFormField(hintText: "Enter City", labelText: "City"),
                margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
              ),

              Container(
                width: MySize.getScaledSizeWidth(480),
                child: getStateDropDown(),
                margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
              ),
              // Spacing.width(28),
              Container(
                width: MySize.getScaledSizeWidth(480),
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

              Container(
                width: MySize.getScaledSizeWidth(480),
                child: getTextFormField(
                    hintText: "Enter PIN code ",
                    labelText: "Store PIN code",
                    formator: [FilteringTextInputFormatter.digitsOnly]),
                margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
              ),
              //Spacing.width(28),
              Container(
                width: MySize.getScaledSizeWidth(480),
                child: getTextFormField(
                    hintText: "Enter Store License Number ",
                    labelText: "Store License Number "),
                margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
              ),

              Container(
                width: MySize.getScaledSizeWidth(480),
                child: getTextFormField(
                    hintText: "Enter GST Number", labelText: "GST Number"),
                margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
              ),
              //Spacing.width(28),
              Container(
                width: MySize.getScaledSizeWidth(480),
                child: getTextFormField(
                    hintText: "Enter Email", labelText: "Email"),
                margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
              ),

              Container(
                width: MySize.getScaledSizeWidth(480),
                child: getTextFormField(
                    hintText: "Enter Telephone Number",
                    labelText: "Telephone Number"),
                margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
              ),
              //  Spacing.width(28),
              Container(
                width: MySize.getScaledSizeWidth(480),
                child: getTextFormField(
                    hintText: "Enter Store Map Location",
                    labelText: "Store Map Location",
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(MySize.size15!),
                      child: SvgPicture.asset("assets/pin.svg"),
                    )),
                margin: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(10)),
              ),
            ],
          )
        ],
      ),
    );
  }

  getStateDropDown() {
    return PopupMenuButton(
        offset: Offset(0, MySize.getScaledSizeHeight(58)),
        child: Container(
          width: MySize.getScaledSizeWidth(480),
          child: getTextFormField(
            textEditingController: controller.selectStateController.value,
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelText: "State",
            isReadOnly: true,
            enable: false,
          ),
        ),
        itemBuilder: (context) {
          return List.generate(
              controller.stateList.length,
              (index) => PopupMenuItem(
                    child: Text(
                      controller.stateList[index],
                      style: TextStyle(fontFamily: "Poppins"),
                    ),
                    onTap: () {
                      controller.selectStateController.value.text =
                          controller.stateList[index];
                    },
                  ));
        });
  }

  Widget storeGallery(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MySize.getScaledSizeHeight(30)),
      child: Container(
        width: MySize.getScaledSizeWidth(480),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Store Gallery",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: MySize.size20,
                      ),
                    ),
                    Spacing.height(20),
                    Wrap(
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
                        Spacing.width(10),
                        if (!isNullEmptyOrFalse(controller.imageData))
                          for (int i = 0; i < controller.imageData.length; i++)
                            // for (int i = 0; i < 7; i++)
                            Padding(
                              padding: EdgeInsets.only(
                                  right: MySize.getScaledSizeWidth(10)),
                              child: Container(
                                height: MySize.getScaledSizeHeight(110),
                                width: MySize.getScaledSizeWidth(110),
                                child: Stack(
                                  children: [
                                    InkWell(
                                      child: Image(
                                        image: NetworkImage(
                                            controller.imageData[0].path),
                                        width: MySize.getScaledSizeWidth(100),
                                        height: MySize.getScaledSizeHeight(100),
                                        fit: BoxFit.cover,
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SimpleDialog(
                                              insetPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: MySize
                                                          .getScaledSizeWidth(
                                                              20)),
                                              children: [
                                                Container(
                                                  child: PhotoView(
                                                    imageProvider: NetworkImage(
                                                        controller
                                                            .imageData[0].path),
                                                    initialScale:
                                                        PhotoViewComputedScale
                                                                .contained *
                                                            1,
                                                    heroAttributes:
                                                        PhotoViewHeroAttributes(
                                                            tag: controller
                                                                .imageData[0]
                                                                .path),
                                                    enableRotation: true,
                                                  ),
                                                  height: MySize
                                                      .getScaledSizeHeight(600),
                                                  width: MySize
                                                      .getScaledSizeHeight(600),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    Positioned(
                                      child: InkWell(
                                        onTap: () {
                                          controller.imageData.removeAt(i);
                                        },
                                        child: Container(
                                          height:
                                              MySize.getScaledSizeHeight(110),
                                          width: MySize.getScaledSizeWidth(110),
                                          child: Image(
                                            image:
                                                AssetImage("assets/cancel.png"),
                                          ),
                                        ),
                                      ),
                                      width: MySize.getScaledSizeWidth(40),
                                      height: MySize.getScaledSizeHeight(40),
                                      right: -9,
                                      top: -9,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Spacing.height(13),
          ],
        ),
      ),
    );
  }

  Future<void> _cropImage(String filePath, BuildContext context) async {
    print(filePath);
    CroppedFile? file = await controller.imageCropper.cropImage(
      sourcePath: filePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        WebUiSettings(
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          boundary: Boundary(
            width: MySize.getScaledSizeWidth(480).toInt(),
            height: MySize.getScaledSizeHeight(480).toInt(),
          ),
          viewPort: ViewPort(
              width: MySize.getScaledSizeWidth(480).toInt(),
              height: MySize.getScaledSizeHeight(480).toInt(),
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

  deliveryOption() {
    return Container(
      width: MySize.getScaledSizeWidth(487),
      padding: EdgeInsets.only(
        top: MySize.getScaledSizeHeight(30),
      ),
      child: Column(
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
          Wrap(
            runSpacing: MySize.getScaledSizeHeight(10),
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
                    focusNode: controller.f1,
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
                        0,
                        (index) => PopupMenuItem(
                              child: Text("Category ${index + 1}"),
                            ));
                  }),
            ],
          ),
        ],
      ),
    );
  }

  gertStoreHours() {
    return Padding(
      padding: EdgeInsets.only(top: MySize.getScaledSizeHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Store Hours",
            style: TextStyle(
                fontSize: MySize.getScaledSizeHeight(20),
                fontWeight: FontWeight.bold),
          ),
          Space.height(30),
          Wrap(
            runSpacing: MySize.getScaledSizeHeight(10),
            children: [
              PopupMenuButton(
                  offset: Offset(0, MySize.getScaledSizeHeight(50)),
                  child: Container(
                    width: MySize.getScaledSizeWidth(240),
                    child: getTextFormField(
                        textEditingController:
                            controller.storeHoursController.value,
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        labelText: "Work Days",
                        isReadOnly: true,
                        enable: false,
                        ontap: () {
                          print("test");
                        }),
                  ),
                  itemBuilder: (context) {
                    return List.generate(
                        0,
                        (index) => PopupMenuItem(
                              child: Text("Category ${index + 1}"),
                            ));
                  }),
              Space.width(10),
              Container(
                width: MySize.getScaledSizeWidth(240),
                child: getTextFormField(
                    labelText: "Opening Time",
                    textEditingController:
                        controller.openingTimeController.value),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
