import 'package:flutter/material.dart';
import 'package:rucja/components/change_password.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';
import 'package:rucja/extensions/text_styles.dart';
import 'package:rucja/utils/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome to Dashboard",style: boldTextStyle(color: primaryColor),).center()
        ],
      ),
    );
  }
}
