import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rucja/screens/create_password_screen.dart';
import '../../extensions/loader_widget.dart';
import '../../extensions/extension_util/context_extensions.dart';
import '../../extensions/extension_util/int_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../extensions/app_button.dart';
import '../extensions/app_text_field.dart';
import '../extensions/common.dart';
import '../extensions/constants.dart';
import '../extensions/decorations.dart';
import '../extensions/system_utils.dart';
import '../extensions/text_styles.dart';
import '../extensions/widgets.dart';
import '../main.dart';
import '../network/rest_api.dart';
import '../utils/app_colors.dart';
import '../utils/app_common.dart';
import '../utils/app_images.dart';

class ForgotPwdScreen extends StatefulWidget {
  @override
  _ForgotPwdScreenState createState() => _ForgotPwdScreenState();
}

class _ForgotPwdScreenState extends State<ForgotPwdScreen> {
  GlobalKey<FormState> mFormKey = GlobalKey<FormState>();

  TextEditingController mEmailCont = TextEditingController();
  //
  // Future<void> resetPassword() async {
  //   hideKeyboard(context);
  //   if (mFormKey.currentState!.validate()) {
  //     mFormKey.currentState!.save();
  //     appStore.setLoading(true);
  //     Map req = {'email': mEmailCont.text.trim()};
  //     await forgotPwdApi(req).then((value) {
  //       appStore.setLoading(false);
  //       toast(value.message);
  //       finish(context);
  //     }).catchError((error) {
  //       toast(error.toString());
  //       appStore.setLoading(false);
  //     });
  //   }
  // }

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
                    Text('Reset Password?', style: boldTextStyle(size: 22)),
                    12.height,
                    Text('Enter the email or phone number associated with your account to reset your password.', style: secondaryTextStyle(color: lightColor)),
                    24.height,
                    Text('Email', style: secondaryTextStyle(color: textPrimaryColorGlobal)),
                    4.height,
                    4.height,
                    AppTextField(
                      controller: mEmailCont,
                      textFieldType: TextFieldType.EMAIL,
                      isValidationRequired: true,
                      suffix: mSuffixTextFieldIconWidget(ic_mail),
                      onFieldSubmitted: (c) {
                        // resetPassword();
                      },
                      decoration: defaultInputDecoration(context, label: 'Enter Email'),
                    ),
                    30.height,
                    AppButton(
                      text: 'Continue',
                      width: context.width(),
                      color: primaryColor,
                      onTap: () {
                              toast('reset passsword link send successfully!');
                              CreatePasswordScreen().launch(context);

                        // resetPassword();
                      },
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16),
              ),
            ),
            Loader().visible(appStore.isLoading)
          ],
        );
      }),
    );
  }
}
