import 'package:flutter/material.dart';
import 'package:rucja/extensions/extension_util/int_extensions.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';

import '../extensions/text_styles.dart';
import '../utils/app_colors.dart';

class UserDetailStep4Component extends StatefulWidget {
  final bool? isNewTask;

   UserDetailStep4Component({this.isNewTask = false});

  @override
  State<UserDetailStep4Component> createState() => _UserDetailStep4ComponentState();
}

class _UserDetailStep4ComponentState extends State<UserDetailStep4Component> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "When are you born?",
          style: boldTextStyle(size: 22),
        ),
        10.height,
        Text(
          "We will use this data to give you a better result and help to track your health",
          style: secondaryTextStyle(size: 12, color: lightColor),
        ),
      ],
    ).paddingAll(16),);
  }
}
