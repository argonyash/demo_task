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
                          title: new Text('Account'),
                          content: Container(
                            //width: double.infinity,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Container(
                                      width: MySize.getScaledSizeWidth(400),
                                      // child: getTextFormField(
                                      //     labelText: "Store Categories",
                                      //     hintText: "sdsd",
                                      //     textEditingController:
                                      //         controller.username,
                                      //     enable: true),
                                      child: TextField(
                                        controller: controller.username,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'City',
                                            hintText: 'Enter City Here'),
                                      ),
                                    ),
                                  ],
                                )
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
}
