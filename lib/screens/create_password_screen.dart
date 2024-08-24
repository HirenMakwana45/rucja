import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rucja/components/change_password.dart';
import 'package:rucja/extensions/extension_util/context_extensions.dart';
import 'package:rucja/extensions/extension_util/int_extensions.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';

import '../extensions/app_button.dart';
import '../extensions/app_text_field.dart';
import '../extensions/constants.dart';
import '../extensions/decorations.dart';
import '../extensions/loader_widget.dart';
import '../extensions/text_styles.dart';
import '../extensions/widgets.dart';
import '../main.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {

  GlobalKey<FormState> mFormKey = GlobalKey<FormState>();


  TextEditingController mPassCont = TextEditingController();
  TextEditingController mConfirmPassCont = TextEditingController();

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
                    Text('Create new password', style: boldTextStyle(size: 22)),
                    12.height,
                    Text('Please, enter new password below', style: secondaryTextStyle(color: lightColor)),
                    24.height,
                    Text('Password', style: secondaryTextStyle(color: textPrimaryColorGlobal)),
                    4.height,
                    AppTextField(
                      controller: mPassCont,
                      textFieldType: TextFieldType.PASSWORD,
                      isValidationRequired: true,
                      onFieldSubmitted: (c) {
                        // resetPassword();
                      },
                      decoration: defaultInputDecoration(context, label: 'Enter Password'),
                    ),
                    24.height,
                    Text('Confirm Password', style: secondaryTextStyle(color: textPrimaryColorGlobal)),
                    4.height,
                    AppTextField(
                      controller: mConfirmPassCont,
                      textFieldType: TextFieldType.PASSWORD,
                      isValidationRequired: true,
                      onFieldSubmitted: (c) {
                        // resetPassword();
                      },
                      decoration: defaultInputDecoration(context, label: 'Enter Confirm Password'),
                    ),
                    30.height,
                    AppButton(
                      text: 'Reset Password',
                      width: context.width(),
                      color: primaryColor,
                      onTap: () {
                        ChangePassword().launch(context);
                        // toast('reset passsword link send successfully!');

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
