import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rucja/utils/app_colors.dart';
import '../../screens/dashboard_screen.dart';
import '../../extensions/extension_util/duration_extensions.dart';
import '../../extensions/extension_util/int_extensions.dart';
import '../../extensions/extension_util/context_extensions.dart';
import '../extensions/shared_pref.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../extensions/colors.dart';
import '../../main.dart';
import '../../utils/app_config.dart';
import '../../utils/app_images.dart';
import '../extensions/text_styles.dart';
import '../utils/app_constants.dart';
import 'sign_in_screen.dart';
import 'walk_through_screen.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await 2.seconds.delay;
    WalkThroughScreen().launch(context, isNewTask: true);
    // if (!getBoolAsync(IS_FIRST_TIME)) {
    //   WalkThroughScreen().launch(context, isNewTask: true);
    // } else {
    //   // if (userStore.isLoggedIn) {
    //   //  const DashboardScreen().launch(context, isNewTask: true);
    //   // } else {
    //      SignInScreen().launch(context, isNewTask: true);
    //   // }
    // }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
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
        body: Stack(
          children: [
            Image.asset(ic_splash_logo,
                width: double.infinity, fit: BoxFit.cover),
            Image.asset(ic_logo, width: 210, height: 108, fit: BoxFit.fill)
                .center(),
          ],
        ),
      ),
    );
  }
}
