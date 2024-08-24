import 'package:flutter/material.dart';
import 'package:rucja/extensions/extension_util/context_extensions.dart';
import 'package:rucja/extensions/extension_util/int_extensions.dart';
import 'package:rucja/extensions/extension_util/widget_extensions.dart';
import 'package:rucja/extensions/text_styles.dart';
import 'package:rucja/screens/sign_in_screen.dart';
import 'package:rucja/utils/app_colors.dart';

import '../models/walk_through_model.dart';
import '../utils/app_images.dart';

class ChooseAccountScreen extends StatefulWidget {
  const ChooseAccountScreen({super.key});

  @override
  State<ChooseAccountScreen> createState() => _ChooseAccountScreenState();
}

class _ChooseAccountScreenState extends State<ChooseAccountScreen> {
  List<WalkThroughModel> sList = [];
  int _selectedIndex = -1;


  void _toggleClick(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    sList.add(WalkThroughModel(image: ic_patient, title: 'Patient'));
    sList.add(WalkThroughModel(image: ic_doctor, title: 'Doctor'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(ic_logo, width: 130, height: 48, fit: BoxFit.cover)
              .center()
              .paddingTop(context.statusBarHeight + 6),
          10.height,
          Text(
            "Are you a",
            style: boldTextStyle(size: 22),
          ),
          10.height,
          Text(
            "Please Select your role to create account",
            style: secondaryTextStyle(size: 12, color: lightColor),
          ),
          10.height,
          ListView.builder(
            itemCount: sList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              bool isSelected = _selectedIndex == index;

              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color:isSelected ? primaryColor : lightColor),
                    borderRadius: BorderRadius.circular(28)),
                child: Row(
                  children: [
                    Image.asset(sList[index].image!,
                        width: 96, height: 96, fit: BoxFit.cover),
                    20.width,
                    ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                              colors: [isSelected ? gradientStartColor : lightColor,isSelected ? gradientEndColor :lightColor],
                              tileMode: TileMode.clamp,
                            ).createShader(bounds),
                        child: Text(
                          sList[index].title!,
                          style:
                              primaryTextStyle(color:isSelected ? Colors.white : Colors.black, size: 24),
                        )),
                  ],
                ).paddingAll(14),
              ).paddingBottom(16).onTap(() {
                _toggleClick(index);
                // logger.d("Logger is Working ==>"+ sList[index].title.toString());

              });
            },
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Already have an account?", style: primaryTextStyle()),
              GestureDetector(
                  child: Text('Login',
                          style: primaryTextStyle(color: primaryColor))
                      .paddingLeft(4),
                  onTap: () {
                    SignInScreen().launch(context);
                  })
            ],
          ),
        ],
      ).paddingAll(16),
    );
  }
}
