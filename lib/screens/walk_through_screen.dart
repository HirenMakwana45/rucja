import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rucja/screens/choose_account_screen.dart';
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
  int _currentStep = 0;
  final int _totalSteps = 3;

  void _nextStep() {
    setState(() {
      if (_currentStep < _totalSteps - 1) {
        setState(() {
          _currentStep++;
          mCurrentIndex++;
        });
        mPageController.animateToPage(
          mCurrentIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        ChooseAccountScreen().launch(context);
      }
    });
  }

  // void _previousStep() {
  //   setState(() {
  //     if (_currentStep > 0) {
  //       _currentStep--;
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    mWalkList.add(WalkThroughModel(
        image: ic_walk1, title: WALK1_TITLE, subTitle: SUBTITLE1));
    mWalkList.add(WalkThroughModel(
        image: ic_walk2, title: WALK2_TITLE, subTitle: SUBTITLE2));
    mWalkList.add(WalkThroughModel(
        image: ic_walk3, title: WALK3_TITLE, subTitle: SUBTITLE3));
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
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      setValue(IS_FIRST_TIME, true);
                      ChooseAccountScreen().launch(context);
                      // SignInScreen().launch(context);
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
                      Text(
                        mWalkList[mCurrentIndex].subTitle.toString(),
                        style: secondaryTextStyle(color: lightColor),
                        textAlign: TextAlign.center,
                      ),
                      16.height,
                      30.height,
                      GestureDetector(
                        onTap: _nextStep,
                        child: OnboardingStepIndicator(
                          progress: (_currentStep + 1) / _totalSteps,
                          size: 80,
                          spacing: 6.0,
                          borderGradient: LinearGradient(
                            colors: [Colors.purple, Colors.pink],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
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

class OnboardingStepIndicator extends StatelessWidget {
  final double progress;
  final double size;
  final double spacing;
  final Gradient borderGradient;

  const OnboardingStepIndicator({
    Key? key,
    required this.progress,
    required this.size,
    this.spacing = 10.0,
    required this.borderGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, color: lightColor),
          child: Center(
            child: Container(
              width: size - spacing,
              height: size - spacing,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Container(
                  width: size - spacing - 10,
                  height: size - spacing - 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: spacing + 5,
          left: spacing + 5,
          child: Container(
            width: size - spacing * 2 - 10,
            height: size - spacing * 2 - 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Icon(Icons.arrow_forward_ios_sharp, color: Colors.white, size: 30).paddingLeft(4),
            ),
          ),
        ),
        CustomPaint(
          size: Size(size, size),
          painter: ArcPainter(progress: progress),
        ),
      ],
    );
  }
}

class ArcPainter extends CustomPainter {
  final double progress;

  ArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    double lineWidth = 5;
    double radius = (size.width - lineWidth) / 2;

    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.purple, Colors.pink],
      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round;

    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
