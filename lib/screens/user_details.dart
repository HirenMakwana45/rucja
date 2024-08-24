import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:rucja/extensions/extension_util/context_extensions.dart';
import 'package:rucja/extensions/extension_util/int_extensions.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';

import '../components/user_detail_step1_component.dart';
import '../components/user_detail_step2_component.dart';
import '../components/user_detail_step3_component.dart';
import '../components/user_detail_step4_component.dart';
import '../components/user_detail_step5_component.dart';
import '../extensions/colors.dart';
import '../extensions/constants.dart';
import '../extensions/decorations.dart';
import '../extensions/system_utils.dart';
import '../extensions/widgets.dart';
import '../main.dart';
import '../utils/app_colors.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool? isNewTask = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("",
          backWidget: Icon(
            Octicons.chevron_left,
            color: primaryColor,
            size: 28,
          ).onTap(() {
            if (appStore.signUpIndex == 0) {
              finish(context);
            } else {
              isNewTask = false;
              appStore.signUpIndex--;
              setState(() {});
            }
          }),
          color: whiteColor,
          elevation: 0,
          textColor: textPrimaryColorGlobal,
          context: context),
      body: Column(
        children: [
          4.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              return Container(
                alignment: Alignment.center,
                height: 4,
                width: context.width() / 6,
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: appStore.signUpIndex >= index
                      ? primaryColor
                      : GreyLightColor,
                ),
              );
            }).toList(),
          ).paddingSymmetric(horizontal: 8),
          16.height,
          if (appStore.signUpIndex == 0)
            UserDetailStep1Component(isNewTask: isNewTask).expand(),
          if (appStore.signUpIndex == 1)
            UserDetailStep2Component(isNewTask: isNewTask).expand(),
          if (appStore.signUpIndex == 2)
            UserDetailStep3Component(isNewTask: isNewTask).expand(),
          if (appStore.signUpIndex == 3)
            UserDetailStep4Component().expand(),
          // if (appStore.signUpIndex == 4) UserDetailStep5Component().expand(),
        ],
      ),
    );
  }
}
