import 'package:flutter/material.dart';
import 'package:rucja/extensions/extension_util/int_extensions.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';

import '../extensions/text_styles.dart';
import '../utils/app_colors.dart';

class UserDetailStep3Component extends StatefulWidget {
  final bool? isNewTask;

  UserDetailStep3Component({this.isNewTask = false});

  @override
  State<UserDetailStep3Component> createState() =>
      _UserDetailStep3ComponentState();
}

class _UserDetailStep3ComponentState extends State<UserDetailStep3Component> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
        ],
      ).paddingAll(16),
    );
  }
}
