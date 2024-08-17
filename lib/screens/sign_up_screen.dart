import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:rucja/screens/sign_in_screen.dart';
import '../../extensions/constants.dart';
import '../../extensions/decorations.dart';
import '../../extensions/extension_util/context_extensions.dart';
import '../../extensions/extension_util/int_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../extensions/system_utils.dart';
import '../../extensions/widgets.dart';
import '../../main.dart';
import '../extensions/app_button.dart';
import '../extensions/app_text_field.dart';
import '../extensions/colors.dart';
import '../extensions/loader_widget.dart';
import '../extensions/shared_pref.dart';
import '../extensions/text_styles.dart';
import '../utils/app_colors.dart';
import '../components/sign_up_step1_component.dart';
import '../components/sign_up_step2_component.dart';
import '../components/sign_up_step3_component.dart';
import '../components/sign_up_step4_component.dart';
import '../utils/app_common.dart';
import '../utils/app_constants.dart';
import '../utils/app_images.dart';

class SignUpScreen extends StatefulWidget {
  final String? phoneNumber;

  SignUpScreen({this.phoneNumber});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isNewTask = true;
  GlobalKey<FormState> mFormKey = GlobalKey<FormState>();
  TextEditingController mNameCont = TextEditingController();
  TextEditingController mPhoneNumberCont = TextEditingController();
  TextEditingController mEmailCont = TextEditingController();
  TextEditingController mPassCont = TextEditingController();
  TextEditingController mConfirmPassCont = TextEditingController();

  FocusNode mNameFocus = FocusNode();
  FocusNode mPhoneNumberFocus = FocusNode();
  FocusNode mEmailFocus = FocusNode();
  FocusNode mPassFocus = FocusNode();
  FocusNode mConfirmPassFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    appStore.signUpIndex = 0;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (appStore.signUpIndex == 0) {
          appStore.setLoading(false);
          finish(context);
          return false;
        } else {
          isNewTask = false;
          appStore.signUpIndex--;
          setState(() {});
          return false;
        }
      },
      child: Observer(builder: (context) {
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
            body: Observer(builder: (context) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Form(
                      key: mFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(ic_logo,
                                  width: 130, height: 48, fit: BoxFit.cover)
                              .center(),
                          20.height,
                          Text('Sign Up', style: boldTextStyle(size: 18))
                              .paddingSymmetric(horizontal: 16),
                          Container(
                            width: 50,
                            height: 2,
                            decoration: boxDecorationWithRoundedCorners(
                                backgroundColor: primaryColor),
                            margin: EdgeInsets.only(top: 4),
                          ).paddingSymmetric(horizontal: 16),
                          16.height,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              16.height,
                              Text('Name',
                                  style: secondaryTextStyle(
                                      color: textPrimaryColorGlobal)),
                              4.height,
                              AppTextField(
                                controller: mNameCont,
                                textFieldType: TextFieldType.NAME,
                                isValidationRequired: true,
                                focus: mNameFocus,
                                nextFocus: mPhoneNumberFocus,
                                decoration: defaultInputDecoration(context,
                                    label: 'Enter Name'),
                              ),
                              16.height,
                              Text('Phone Number',
                                  style: secondaryTextStyle(
                                      color: textPrimaryColorGlobal)),
                              4.height,
                              AppTextField(
                                controller: mPhoneNumberCont,
                                textFieldType: TextFieldType.NUMBER,
                                isValidationRequired: true,
                                focus: mPhoneNumberFocus,
                                nextFocus: mEmailFocus,
                                suffix: mSuffixTextFieldIconWidget(ic_mobile),
                                decoration: defaultInputDecoration(context,
                                    label: 'Enter Phone Number'),
                              ),
                              16.height,
                              Text('Email',
                                  style: secondaryTextStyle(
                                      color: textPrimaryColorGlobal)),
                              4.height,
                              AppTextField(
                                controller: mEmailCont,
                                textFieldType: TextFieldType.EMAIL,
                                isValidationRequired: true,
                                focus: mEmailFocus,
                                nextFocus: mPassFocus,
                                suffix: mSuffixTextFieldIconWidget(ic_mail),
                                decoration: defaultInputDecoration(context,
                                    label: 'Enter Email'),
                              ),
                              16.height,
                              Text('Password',
                                  style: secondaryTextStyle(
                                      color: textPrimaryColorGlobal)),
                              4.height,
                              AppTextField(
                                controller: mPassCont,
                                focus: mPassFocus,
                                nextFocus: mConfirmPassFocus,
                                textFieldType: TextFieldType.PASSWORD,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: defaultInputDecoration(context,
                                    label: 'Enter Password'),
                                onFieldSubmitted: (c) {
                                  // save();
                                },
                              ),
                              16.height,
                              Text('Confirm Password',
                                  style: secondaryTextStyle(
                                      color: textPrimaryColorGlobal)),
                              4.height,
                              AppTextField(
                                controller: mConfirmPassCont,
                                textFieldType: TextFieldType.PASSWORD,
                                isValidationRequired: true,
                                focus: mConfirmPassFocus,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: defaultInputDecoration(context,
                                    label: 'Enter Confirm Password'),
                              ),
                              16.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Checkbox(
                                          fillColor: MaterialStatePropertyAll(
                                              getBoolAsync(IS_REMEMBER)
                                                  ? primaryColor
                                                  : Colors.transparent),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: radius(4)),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          focusColor: primaryColor,
                                          side: BorderSide(color: primaryColor),
                                          activeColor: primaryColor,
                                          value: getBoolAsync(IS_REMEMBER),
                                          onChanged: (bool? value) async {
                                            await setValue(IS_REMEMBER, value);
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      6.width,
                                      Text('Remember Me',
                                          style: secondaryTextStyle(
                                              color: primaryColor)),
                                    ],
                                  ).expand(),
                                ],
                              ),
                              60.height,
                              AppButton(
                                text: 'Sign Up',
                                width: context.width(),
                                color: primaryColor,
                                onTap: () {
                                  SignInScreen().launch(context);

                                  // save();
                                },
                              ),
                              24.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Already have an account?",
                                      style: primaryTextStyle()),
                                  GestureDetector(
                                      child: Text('Login',
                                              style: primaryTextStyle(
                                                  color: primaryColor))
                                          .paddingLeft(4),
                                      onTap: () {
                                        SignInScreen().launch(context);
                                      })
                                ],
                              ),
                              24.height,
                            ],
                          ).paddingSymmetric(horizontal: 16, vertical: 4),
                        ],
                      ),
                    ),
                  ),
                  Loader().center().visible(appStore.isLoading)
                ],
              );
            }));
      }),
    );
  }
}
