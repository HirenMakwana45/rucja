import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rucja/extensions/app_text_field.dart';
import 'package:rucja/extensions/confirmation_dialog.dart';
import 'package:rucja/extensions/extension_util/duration_extensions.dart';
import 'package:rucja/extensions/extension_util/int_extensions.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';
import 'package:rucja/extensions/text_styles.dart';
import 'package:rucja/screens/dashboard_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await 3.seconds.delay;
    DashboardScreen().launch(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/change_password.json', // Path to your Lottie file
                width: 200,
                height: 200,
                // fit: BoxFit.fill,
              ),
              // Text("Password Change Successfully",style: primaryTextStyle(size: 24),)
            ],
          )),
    );
  }
}
