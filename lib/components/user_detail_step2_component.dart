import 'package:flutter/material.dart';
import 'package:rucja/extensions/extension_util/context_extensions.dart';
import 'package:rucja/extensions/extension_util/int_extensions.dart';
import 'package:rucja/extensions/extension_util/string_extensions.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';

import '../extensions/app_button.dart';
import '../extensions/app_text_field.dart';
import '../extensions/common.dart';
import '../extensions/constants.dart';
import '../extensions/decorations.dart';
import '../extensions/text_styles.dart';
import '../main.dart';
import '../utils/app_colors.dart';

class UserDetailStep2Component extends StatefulWidget {
  final bool? isNewTask;

  UserDetailStep2Component({this.isNewTask = false});

  @override
  State<UserDetailStep2Component> createState() =>
      _UserDetailStep2ComponentState();
}

class _UserDetailStep2ComponentState extends State<UserDetailStep2Component> {

  TextEditingController mHeightCont = TextEditingController();
  int? mHeight = 0;
  double? mFeetValue = 0.0328084;
  double? mCMValue = 30.48;

  bool isFeetClicked = false;
  bool isCMClicked = false;


  @override
  void initState() {
    super.initState();
    init();
  }  init() async {
    //
    // mWeightCont.text = userStore.weight.validate();
    // mHeightCont.text = userStore.height.validate();
    //
    // mWeight = userStore.weightUnit == LBS ? 0 : 1;
    // mHeight = userStore.heightUnit == FEET ? 0 : 1;

    appStore.setLoading(false);
  }


  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }


  Widget mHeightOption(String? value, int? index) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
          borderRadius: radius(6),
          backgroundColor: mHeight == index
              ? primaryColor
              : appStore.isDarkMode
              ? context.cardColor
              : GreyLightColor),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Text(value!, style: secondaryTextStyle(color: mHeight == index ? Colors.white : textSecondaryColorGlobal)),
    ).onTap(() {
      hideKeyboard(context);
      mHeight = index;
      if (index == 1) {
        if (!isFeetClicked) {
          convertFeetToCm();
          isFeetClicked = true;
          isCMClicked = false;
        }
      } else {
        if (!isCMClicked) {
          convertCMToFeet();
          isCMClicked = true;
          isFeetClicked = false;
        }
      }
      setState(() {});
    });
  }
  //Convert Feet to Cm
  void convertFeetToCm() {
    double a = double.parse(mHeightCont.text.isEmptyOrNull ? "0.0" : mHeightCont.text.validate()) * 30.48;
    if (!mHeightCont.text.isEmptyOrNull) {
      mHeightCont.text = a.toStringAsFixed(2).toString();
    }
    mHeightCont.selection = TextSelection.fromPosition(TextPosition(offset: mHeightCont.text.length));
    print(a.toStringAsFixed(2).toString());
  }

  //Convert CM to Feet
  void convertCMToFeet() {
    double a = double.parse(mHeightCont.text.isEmptyOrNull ? "0.0" : mHeightCont.text.validate()) * 0.0328;
    if (!mHeightCont.text.isEmptyOrNull) {
      mHeightCont.text = a.toStringAsFixed(2).toString();
    }
    mHeightCont.selection = TextSelection.fromPosition(TextPosition(offset: mHeightCont.text.length));
    print(a.toStringAsFixed(2).toString());
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How tall are you?",
            style: boldTextStyle(size: 22),
          ),
          10.height,
          Text(
            "We will use this data to give you a better result and help to track your health",
            style: secondaryTextStyle(size: 12, color: lightColor),
          ),
          20.height,
          Text("Height", style: secondaryTextStyle(color: textPrimaryColorGlobal)),
          4.height,
          AppTextField(
            onChanged: (_) {
              setState(() {
                isFeetClicked = false;
                isCMClicked = false;
              });
            },
            controller: mHeightCont,
            textFieldType: TextFieldType.NUMBER,
            isValidationRequired: true,
            // focus: mHeightFocus,
            suffix: Container(
              decoration: boxDecorationWithRoundedCorners(backgroundColor: appStore.isDarkMode ? context.cardColor : GreyLightColor),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  mHeightOption("Feet", 0),
                  4.width,
                  mHeightOption("Cm", 1),
                ],
              ),
            ),
            decoration: defaultInputDecoration(context, label: "Enter Height"),
          ),
          Spacer(),
          AppButton(
            // shapeBorder: ,
            text: "Next",
            width: context.width(),
            color: primaryColor,
            onTap: () {
              // if (mFormKey.currentState!.validate()) {
              //   hideKeyboard(context);
              //   userStore.setFirstName(mFNameCont.text);
              //   userStore.setLastName(mLNameCont.text);
              //   if (getBoolAsync(IS_OTP) != true) {
              //     userStore.setPhoneNo(mMobileNumberCont.text);
              //     userStore.setUserPassword(mPassCont.text);
              //   }
              //   userStore.setUserEmail(mEmailCont.text);

              setState(() {
                appStore.signUpIndex = 2;
              });
              // }
            },
          ),
          10.height,
        ],
      ).paddingAll(16);

  }
}
