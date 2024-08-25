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

class UserDetailStep3Component extends StatefulWidget {
  final bool? isNewTask;

  UserDetailStep3Component({this.isNewTask = false});

  @override
  State<UserDetailStep3Component> createState() =>
      _UserDetailStep3ComponentState();
}

class _UserDetailStep3ComponentState extends State<UserDetailStep3Component> {

  int? mWeight = 0;

  bool isKGClicked = false;
  bool isLBSClicked = false;
  FocusNode mWeightFocus = FocusNode();
  TextEditingController mWeightCont = TextEditingController();


  Widget mWeightOption(String? value, int? index) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
          borderRadius: radius(6),
          backgroundColor: mWeight == index
              ? primaryColor
              : appStore.isDarkMode
              ? context.cardColor
              : GreyLightColor),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Text(value!, style: secondaryTextStyle(color: mWeight == index ? Colors.white : textSecondaryColorGlobal)),
    ).onTap(() {
      mWeight = index;
      hideKeyboard(context);
      if (index == 0) {
        if (!isLBSClicked) {
          convertKgToLbs();
          isLBSClicked = true;
          isKGClicked = false;
        }
      } else {
        if (!isKGClicked) {
          convertLbsToKg();
          isKGClicked = true;
          isLBSClicked = false;
        }
      }
      setState(() {});
    });
  }

//Convert lbs to kg
  void convertLbsToKg() {
    double a = double.parse(mWeightCont.text.isEmptyOrNull ? "0.0" : mWeightCont.text.validate()) * 0.45359237;
    if (!mWeightCont.text.isEmptyOrNull) {
      mWeightCont.text = a.toStringAsFixed(2).toString();
    }
    mWeightCont.selection = TextSelection.fromPosition(TextPosition(offset: mWeightCont.text.length));
    print(a.toStringAsFixed(2).toString());
  }

  void convertKgToLbs() {
    double a = double.parse(mWeightCont.text.isEmptyOrNull ? "0.0" : mWeightCont.text.validate()) * 2.2046;
    if (!mWeightCont.text.isEmptyOrNull) {
      mWeightCont.text = a.toStringAsFixed(2).toString();
    }
    mWeightCont.selection = TextSelection.fromPosition(TextPosition(offset: mWeightCont.text.length));
    print(a.round().toString());
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "How much your weight?",
          style: boldTextStyle(size: 22),
        ),
        10.height,
        Text(
          "We will use this data to give you a better result and help to track your health",
          style: secondaryTextStyle(size: 12, color: lightColor),
        ),
        20.height,
        Text('Weight', style: secondaryTextStyle(color: textPrimaryColorGlobal)),
        4.height,
        AppTextField(
          onChanged: (_) {
            setState(() {
              isLBSClicked = false;
              isKGClicked = false;
            });
          },
          controller: mWeightCont,
          textFieldType: TextFieldType.NUMBER,
          isValidationRequired: true,
          focus: mWeightFocus,
          suffix: Container(
            decoration: boxDecorationWithRoundedCorners(backgroundColor: appStore.isDarkMode ? context.cardColor : GreyLightColor),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                mWeightOption("Lbs", 0),
                4.width,
                mWeightOption("Kg", 1),
              ],
            ),
          ),
          decoration: defaultInputDecoration(context, label: "Enter Weight"),
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
            appStore.signUpIndex = 3;
            setState(() {});
            // }
          },
        ),
        10.height,
      ],
    ).paddingAll(16);
  }
}
