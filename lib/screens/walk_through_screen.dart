import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../extensions/app_button.dart';
import '../../extensions/extension_util/context_extensions.dart';
import '../../extensions/extension_util/int_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../screens/sign_in_screen.dart';
import '../../utils/app_images.dart';
import '../extensions/colors.dart';
import '../extensions/common.dart';
import '../extensions/shared_pref.dart';
import '../extensions/text_styles.dart';
import '../main.dart';
import '../models/walk_through_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_config.dart';
import '../utils/app_constants.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  PageController mPageController = PageController();

  List<WalkThroughModel> mWalkList = [];
  int mCurrentIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    mWalkList.add(WalkThroughModel(image: ic_walk1, title: WALK1_TITLE));
    mWalkList.add(WalkThroughModel(image: ic_walk2, title: WALK2_TITLE));
    mWalkList.add(WalkThroughModel(image: ic_walk3, title: WALK3_TITLE));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    mPageController.dispose();
    super.dispose();
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
        body: Column(
          children: [
            Stack(
              // alignment: Alignment.center,
              children: [
                // Fixed Background
                Container(
                  color: const Color(0xff8E4E9F),
                  height: 350,
                ),
                Positioned(
                  top: 275,
                  left: -100,
                  right: -100,
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(500),
                      topRight: Radius.circular(500),
                    ),
                    child: Container(
                      height: 420,
                      color: Colors.white,
                    ),
                  ),
                ),

                // PageView for sliding content
                Positioned.fill(
                  child: PageView(
                    controller: mPageController,
                    children: mWalkList.map((e) {
                      return Column(
                        children: [
                          // Page content here
                        ],
                      );
                    }).toList(),
                    onPageChanged: (i) {
                      mCurrentIndex = i;
                      setState(() {});
                    },
                  ),
                ),

                // Skip Button
                Positioned(
                  top: context.statusBarHeight,
                  right: 4,
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      setValue(IS_FIRST_TIME, true);
                      SignInScreen().launch(context);
                    },
                    child: Text(
                      'Skip',
                      style: boldTextStyle(color: Colors.white),
                    ),
                  ),
                ).visible(mCurrentIndex != 2),

                // Bottom Content
                Positioned(
                  right: 24,
                  left: 24,
                  bottom: 50,
                  child: Column(
                    children: [
                      Text(
                        mWalkList[mCurrentIndex].title.toString(),
                        style: boldTextStyle(size: 22),
                        textAlign: TextAlign.center,
                      ),
                      16.height,
                      dotIndicator(mWalkList, mCurrentIndex),
                      30.height,
                      AppButton(
                        text: mCurrentIndex == 2 ? 'Get Started' : 'Next',
                        width: context.width(),
                        color: primaryColor,
                        onTap: () {
                          if (mCurrentIndex.toInt() >= 2) {
                            setValue(IS_FIRST_TIME, true);
                            SignInScreen().launch(context);
                          } else {
                            mPageController.nextPage(
                              duration: Duration(seconds: 1),
                              curve: Curves.linearToEaseOut,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),

                // Page Image
                Positioned(
                  top: 170,
                  left: 75,
                  // bottom: 180,
                  child: Image.asset(
                    mWalkList[mCurrentIndex].image!,
                    height: context.height() * 0.35,
                    width: 250,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ).expand(),
          ],
        ),
      ),
    );
  }
}
