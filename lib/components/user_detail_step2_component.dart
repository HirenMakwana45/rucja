import 'package:flutter/material.dart';
import 'package:rucja/extensions/extension_util/int_extensions.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';

import '../extensions/text_styles.dart';
import '../utils/app_colors.dart';

class UserDetailStep2Component extends StatefulWidget {
  final bool? isNewTask;

  UserDetailStep2Component({this.isNewTask = false});

  @override
  State<UserDetailStep2Component> createState() =>
      _UserDetailStep2ComponentState();
}

class _UserDetailStep2ComponentState extends State<UserDetailStep2Component> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
        ],
      ).paddingAll(16),
    );
  }
}
