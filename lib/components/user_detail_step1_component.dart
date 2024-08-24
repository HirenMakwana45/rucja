import 'package:flutter/material.dart';
import 'package:rucja/extensions/extension_util/context_extensions.dart';
import 'package:rucja/extensions/extension_util/int_extensions.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';

import '../extensions/app_button.dart';
import '../extensions/text_styles.dart';
import '../main.dart';
import '../utils/app_colors.dart';

class UserDetailStep1Component extends StatefulWidget {
  final bool? isNewTask;

  UserDetailStep1Component({this.isNewTask = false});
  @override
  State<UserDetailStep1Component> createState() =>
      _UserDetailStep1ComponentState();
}

class _UserDetailStep1ComponentState extends State<UserDetailStep1Component> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Which one are you?",
            style: boldTextStyle(size: 22),
          ),
          10.height,
          Text(
            "We will use this data to give you a better result and help to track your health",
            style: secondaryTextStyle(size: 12, color: lightColor),
          ),
          AppButton(
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
                appStore.signUpIndex = 1;
                setState(() {});
              // }
            },
          ),
        ],

      ).paddingAll(16),
    );
  }
}
