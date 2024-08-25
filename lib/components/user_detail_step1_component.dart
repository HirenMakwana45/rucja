import 'package:flutter/material.dart';
import 'package:rucja/extensions/extension_util/context_extensions.dart';
import 'package:rucja/extensions/extension_util/int_extensions.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';
import 'package:rucja/utils/app_images.dart';

import '../extensions/app_button.dart';
import '../extensions/text_styles.dart';
import '../main.dart';
import '../models/walk_through_model.dart';
import '../utils/app_colors.dart';

class UserDetailStep1Component extends StatefulWidget {
  final bool? isNewTask;

  UserDetailStep1Component({this.isNewTask = false});
  @override
  State<UserDetailStep1Component> createState() =>
      _UserDetailStep1ComponentState();
}

class _UserDetailStep1ComponentState extends State<UserDetailStep1Component> {
  List<WalkThroughModel> sList = [];
  int _selectedIndex = -1;

  void _toggleClick(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    sList.add(WalkThroughModel(image: ic_male, title: 'Male'));
    sList.add(WalkThroughModel(image: ic_female, title: 'Female'));
    sList.add(WalkThroughModel(image: ic_smiley, title: 'Not prefer to say'));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangeDependencies() {
    // if (widget.isNewTask != true) {
    //   mFNameCont.text = userStore.fName.validate();
    //   mLNameCont.text = userStore.lName.validate();
    //   mEmailCont.text = userStore.email.validate();
    //   mPassCont.text = userStore.password.validate();
    //   mMobileNumberCont.text = userStore.phoneNo.validate();
    // }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
            30.height,
            ListView.builder(
              itemCount: sList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                bool isSelected = _selectedIndex == index;

                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: isSelected ? primaryColor : lightColor),
                      borderRadius: BorderRadius.circular(28)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(sList[index].image!,
                          height: 40, fit: BoxFit.fill),
                      30.width,
                      ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  isSelected ? gradientStartColor : lightColor,
                                  isSelected ? gradientEndColor : lightColor
                                ],
                                tileMode: TileMode.clamp,
                              ).createShader(bounds),
                          child: Text(
                            textAlign: TextAlign.start,
                            sList[index].title!,
                            style: primaryTextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                size: 24,
                                weight: FontWeight.w400),
                          )),
                    ],
                  ).paddingAll(14),
                ).paddingBottom(16).onTap(() {
                  _toggleClick(index);
                  // logger.d("Logger is Working ==>"+ sList[index].title.toString());
                });
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
                appStore.signUpIndex = 1;
                setState(() {});
                // }
              },
            ),
            10.height,
            //
          ],
        ).paddingAll(16);
      }
    );
  }
}
