import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rucja/extensions/extension_util/context_extensions.dart';
import 'package:rucja/extensions/extension_util/int_extensions.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';

import '../extensions/app_button.dart';
import '../extensions/app_text_field.dart';
import '../extensions/constants.dart';
import '../extensions/decorations.dart';
import '../extensions/text_styles.dart';
import '../main.dart';
import '../utils/app_colors.dart';

class UserDetailStep4Component extends StatefulWidget {
  final bool? isNewTask;

  UserDetailStep4Component({this.isNewTask = false});

  @override
  State<UserDetailStep4Component> createState() =>
      _UserDetailStep4ComponentState();
}

class _UserDetailStep4ComponentState extends State<UserDetailStep4Component> {


  TextEditingController countDownCont = TextEditingController();
  DateTime? pickedDate;
  String? formattedDate;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "When are you born?",
            style: boldTextStyle(size: 22),
          ),
          10.height,
          Text(
            "We will use this data to give you a better result and help to track your health",
            style: secondaryTextStyle(size: 12, color: lightColor)),


          20.height,
          AppTextField(
            controller: countDownCont,
            textFieldType: TextFieldType.NAME,
            onChanged: (s) {
              setState(() {});
            },
            onTap: () async {
              FocusScope.of(context).requestFocus(new FocusNode());
              pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime.now());
              if (pickedDate != null) {
                print(pickedDate);
                formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
                print(formattedDate);
                setState(() {
                  countDownCont.text = formattedDate!;
                });
              } else {}
            },
            readOnly: true,
            suffix: Icon(Icons.calendar_today),
            decoration: defaultInputDecoration(context, label:'Date'),
            validator: (s) {
              if (s!.trim().isEmpty) return errorThisFieldRequired;
              return null;
            },
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
              appStore.signUpIndex = 4;
              setState(() {});
              // }
            },
          ),
          10.height,
        ],
      ).paddingAll(16

    );
  }
}
