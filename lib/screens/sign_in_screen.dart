import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../extensions/extension_util/string_extensions.dart';
import '../../extensions/extension_util/context_extensions.dart';
import '../../extensions/extension_util/int_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../extensions/loader_widget.dart';
import '../../main.dart';
import '../../screens/dashboard_screen.dart';
import '../../screens/forgot_pwd_screen.dart';
import '../../screens/otp_screen.dart';
import '../../screens/sign_up_screen.dart';
import '../../utils/app_images.dart';
import '../extensions/app_button.dart';
import '../extensions/app_text_field.dart';
import '../extensions/common.dart';
import '../extensions/constants.dart';
import '../extensions/decorations.dart';
import '../extensions/extension_util/device_extensions.dart';
import '../extensions/shared_pref.dart';
import '../extensions/text_styles.dart';
import '../network/rest_api.dart';
import '../service/auth_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_common.dart';
import '../utils/app_config.dart';
import '../utils/app_constants.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> mFormKey = GlobalKey<FormState>();

  TextEditingController mEmailCont = TextEditingController();
  TextEditingController mPassCont = TextEditingController();

  FocusNode mEmailFocus = FocusNode();
  FocusNode mPassFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    if (getBoolAsync(IS_REMEMBER)) {
      mEmailCont.text = getStringAsync(EMAIL);
      mPassCont.text = getStringAsync(PASSWORD);
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> save() async {
    hideKeyboard(context);
    Map<String, dynamic> req = {
      'email': mEmailCont.text.trim(),
      'user_type': LoginUser,
      'password': mPassCont.text.trim(),
      'player_id': getStringAsync(PLAYER_ID).validate(),
    };

    // if (mFormKey.currentState!.validate()) {
    //   appStore.setLoading(true);
    //   await logInApi(req).then((value) async {
    //     updatePlayerId();
    //     if (value.data!.status == statusActive) {
    //       if (getBoolAsync(IS_REMEMBER)) {
    //         userStore.setUserPassword(mPassCont.text.trim());
    //       }
    //       getUSerDetail(context, value.data!.id).then((value) {
    //         DashboardScreen().launch(context, isNewTask: true);
    //       }).catchError((e) {
    //         print("error=>" + e.toString());
    //       });
    //     } else {
    //       toast(languages.lblContactAdmin);
    //     }
    //   }).catchError((e) {
    //     appStore.setLoading(false);
    //     toast(e.toString());
    //   });
    //   setState(() {});
    // }
    //
  }

  googleLogin() async {
    hideKeyboard(context);
    appStore.setLoading(true);
    // await signInWithGoogle().then((user) async {
    // //   print(user);
    // //   setValue(IS_SOCIAL, true);
    // //   await userStore.setUserEmail(user.email.validate());
    // //   await userStore.setUsername(user.email.validate());
    // //   await userStore.setUserImage(user.photoURL.validate());
    // //   await userStore.setDisplayName(user.displayName.validate());
    // //   await userStore.setPhoneNo(user.phoneNumber.validate());
    // //   updatePlayerId();
    // //   await getUSerDetail(context, userStore.userId).then((value) {
    // //     appStore.setLoading(false);
    // //     DashboardScreen().launch(context, isNewTask: true);
    // //   }).catchError((e) {
    // //     print("error=>" + e.toString());
    // //   });
    // }).catchError((e) {
    //   appStore.setLoading(false);
    //   toast(e.toString());
    // });
  }

  appleLogin() async {
    hideKeyboard(context);
    appStore.setLoading(true);
    await appleLogIn(context).then((value) {
      setValue(IS_SOCIAL, true);
      appStore.setLoading(false);
      // if(userStore.isLoggedIn==true){
      //   updatePlayerId();
      // }
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  Widget mSocialWidget(String icon, Function onCall) {
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(
            color: lightColor,
            width: 1), // Customize the border color and width
        borderRadius: BorderRadius.circular(20), // Make the container rounded
        boxShadow: [
          BoxShadow(
            color: Colors
                .transparent, // Optional: Add shadow for a better visual effect
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          icon,
          height: 24,
          width: 24,
          fit: BoxFit.contain,
        ),
      ),
    ).onTap(() {
      onCall.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
        appStore.isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
        appStore.isDarkMode ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        body: Observer(builder: (context) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(top: context.statusBarHeight + 16),
                child: Form(
                  key: mFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(ic_logo,
                              width: 130, height: 48, fit: BoxFit.cover)
                              .center(),
                          20.height,
                          Text('Login', style: boldTextStyle(size: 18))
                              .paddingSymmetric(horizontal: 16),
                          Container(
                            width: 40,
                            height: 2,
                            decoration: boxDecorationWithRoundedCorners(
                                backgroundColor: primaryColor),
                            margin: EdgeInsets.only(top: 4),
                          ).paddingSymmetric(horizontal: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hello there, sign in to continue!',
                                      style: secondaryTextStyle()),
                                ],
                              ),
                            ],
                          ).paddingOnly(left: 16),
                          16.height,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                textFieldType: TextFieldType.PASSWORD,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: defaultInputDecoration(context,
                                    label: 'Enter Password'),
                                onFieldSubmitted: (c) {
                                  save();
                                },
                              ),
                              16.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Text('Forgot Password?',
                                      style: secondaryTextStyle(
                                          color: primaryColor))
                                      .onTap(() {
                                    ForgotPwdScreen().launch(context);
                                  },
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent),
                                ],
                              ),
                              30.height,
                              AppButton(
                                text: 'Login',
                                width: context.width(),
                                color: primaryColor,
                                onTap: () {
                                  DashboardScreen().launch(context);
                                  // save();
                                },
                              ),
                              30.height,
                              Row(
                                children: [
                                  Container(
                                      width: context.width() * 0.4,
                                      height: 1,
                                      color: context.dividerColor),
                                  Text('OR', style: secondaryTextStyle())
                                      .paddingSymmetric(horizontal: 10),
                                  Container(
                                      width: context.width() * 0.4,
                                      height: 1,
                                      color: context.dividerColor),
                                ],
                              ),
                              24.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  mSocialWidget(ic_google, () {
                                    // googleLogin();
                                  }).visible(ENABLE_GOOGLE_SIGN_IN),
                                  16.width,
                                  mSocialWidget(ic_apple, () {
                                    // appleLogin();
                                  }),
                                ],
                              ).visible(ENABLE_SOCIAL_LOGIN),
                            ],
                          ).paddingSymmetric(horizontal: 16, vertical: 4),
                        ],
                      ),
                      24.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?",
                              style: primaryTextStyle()),
                          GestureDetector(
                              child: Text('Sign Up',
                                  style: primaryTextStyle(
                                      color: primaryColor))
                                  .paddingLeft(4),
                              onTap: () {
                                SignUpScreen().launch(context);
                              })
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Loader().center().visible(appStore.isLoading)
            ],
          );
        }),
      ),
    );
  }

}
