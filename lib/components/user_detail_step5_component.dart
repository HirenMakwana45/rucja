import 'package:flutter/material.dart';
import 'package:rucja/extensions/common.dart';
import 'package:rucja/extensions/extension_util/context_extensions.dart';
import 'package:rucja/extensions/extension_util/int_extensions.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';
import 'package:rucja/screens/dashboard_screen.dart';

import '../extensions/app_button.dart';
import '../extensions/app_text_field.dart';
import '../extensions/decorations.dart';
import '../extensions/text_styles.dart';
import '../main.dart';
import '../utils/app_colors.dart';
import '../utils/app_common.dart';
import '../utils/app_images.dart';

class UserDetailStep5Component extends StatefulWidget {
  final bool? isNewTask;

  UserDetailStep5Component({this.isNewTask = false});
  @override
  State<UserDetailStep5Component> createState() =>
      _UserDetailStep5ComponentState();
}

class _UserDetailStep5ComponentState extends State<UserDetailStep5Component> {
  String? mSearchValue = "";
  bool _showClearButton = false;
  TextEditingController mSearch = TextEditingController();
  FocusNode mSearchFocus = FocusNode();
  List<Map<String, dynamic>> _items = [
    {"title": "Diabetes", "isChecked": false},
    {"title": "Depression", "isChecked": false},
    {"title": "PCOD/PCOS", "isChecked": false},
    {"title": "High blood pressure", "isChecked": false},
    {"title": "Eating Disorder", "isChecked": false},
    {"title": "Heart Condition", "isChecked": false},
    {"title": "None", "isChecked": false},
    {"title": "Other", "isChecked": false},
  ];
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    mSearch.addListener(() {
      _showClearButton = mSearch.text.length > 0;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    mSearch.clear();
    mSearch.dispose();
    super.dispose();
  }

  Widget _getClearButton() {
    if (!_showClearButton) {
      return mSuffixTextFieldIconWidget(ic_search);
    }

    return IconButton(
      onPressed: () {
        mSearch.clear();
        mSearchValue = "";
        hideKeyboard(context);
        // getProductDataAPI();
      },
      icon: Icon(Icons.clear),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Facing any health issues?",
          style: boldTextStyle(size: 22),
        ),
        10.height,
        Text(
          "We will use this data to give you a better result and help to track your health",
          style: secondaryTextStyle(size: 12, color: lightColor),
        ),
        10.height,
        AppTextField(
          controller: mSearch,
          textFieldType: TextFieldType.OTHER,
          isValidationRequired: false,
          autoFocus: false,
          suffix: _getClearButton(),
          decoration: defaultInputDecoration(context,
              isFocusTExtField: true, label: 'Search...'),
          onChanged: (v) {
            mSearchValue = v;
            appStore.setLoading(true);
            setState(() {});
          },
        ),
        10.height,
        ListView.builder(
          itemCount: _items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 14.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                trailing: _customCheckbox(_items[index]["isChecked"], index),
                title: Text(_items[index]["title"]),
                onTap: () {
                  setState(() {
                    _items[index]["isChecked"] = !_items[index]["isChecked"];
                  });
                },
              ),

            );
          },
        ).expand(),
        // Spacer(),
        AppButton(
          // shapeBorder: ,
          text: "Get Started",
          width: context.width(),
          color: primaryColor,
          onTap: () {

            DashboardScreen().launch(context);
            // if (mFormKey.currentState!.validate()) {
            //   hideKeyboard(context);
            //   userStore.setFirstName(mFNameCont.text);
            //   userStore.setLastName(mLNameCont.text);
            //   if (getBoolAsync(IS_OTP) != true) {
            //     userStore.setPhoneNo(mMobileNumberCont.text);
            //     userStore.setUserPassword(mPassCont.text);
            //   }
            //   userStore.setUserEmail(mEmailCont.text);
            // appStore.signUpIndex = 3;
            setState(() {});
            // }
          },
        ),
        10.height,
      ],
    ).paddingAll(16);
  }
  Widget _customCheckbox(bool isChecked, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _items[index]["isChecked"] = !_items[index]["isChecked"];
        });
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: isChecked ? primaryColor : Colors.grey,
            width: 2.0,
          ),
        ),
        child: isChecked
            ? Icon(
          Icons.check,
          size: 16.0,
          color: primaryColor,
        )
            : null,
      ),
    );
  }

}
