import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rucja/extensions/extension_util/context_extensions.dart';
import 'package:rucja/extensions/extension_util/int_extensions.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';
import 'package:rucja/screens/otp_screen.dart';
import 'package:rucja/screens/sign_in_screen.dart';

import '../components/change_password.dart';
import '../extensions/app_button.dart';
import '../extensions/app_text_field.dart';
import '../extensions/constants.dart';
import '../extensions/decorations.dart';
import '../extensions/loader_widget.dart';
import '../extensions/text_styles.dart';
import '../extensions/widgets.dart';
import '../main.dart';
import '../utils/app_colors.dart';

class ReferalScreen extends StatefulWidget {
  const ReferalScreen({super.key});

  @override
  State<ReferalScreen> createState() => _ReferalScreenState();
}

class _ReferalScreenState extends State<ReferalScreen> {
  GlobalKey<FormState> mFormKey = GlobalKey<FormState>();


  TextEditingController mReferByCont = TextEditingController();
  TextEditingController mReferenceCodeCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("", context: context),
      body: Observer(builder: (context) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: mFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image.asset(ic_logo,
                    //     width: 130, height: 48, fit: BoxFit.cover)
                    //     .center(),
                    Text('Refer By ', style: boldTextStyle(size: 22)),

                    24.height,
                    Text('Reference by', style: secondaryTextStyle(color: textPrimaryColorGlobal)),
                    4.height,
                    AppTextField(
                      controller: mReferByCont,
                      textFieldType: TextFieldType.OTHER,
                      isValidationRequired: true,
                      onFieldSubmitted: (c) {
                        // resetPassword();
                      },
                      decoration: defaultInputDecoration(context, label: 'Enter Name'),
                    ),
                    24.height,
                    Text('Reference Code', style: secondaryTextStyle(color: textPrimaryColorGlobal)),
                    4.height,
                    AppTextField(
                      controller: mReferenceCodeCont,
                      textFieldType: TextFieldType.OTHER,
                      isValidationRequired: true,
                      onFieldSubmitted: (c) {
                        // resetPassword();
                      },
                      decoration: defaultInputDecoration(context, label: 'Enter Reference Code'),
                    ),
                    30.height,
                    AppButton(
                      text: 'Verify',
                      width: context.width(),
                      color: primaryColor,
                      onTap: () {
                        OTPScreen().launch(context);

                        // toast('reset passsword link send successfully!');

                        // resetPassword();
                      },
                    ),
                    TextButton(onPressed: (){
                      SignInScreen().launch(context);

                    }, child: Text("Skip",style: primaryTextStyle(size: 14),)).center()
                  ],
                ).paddingSymmetric(horizontal: 16),
              ),
            ),
            Loader().visible(appStore.isLoading)
          ],
        );
      }),
    );
  }}