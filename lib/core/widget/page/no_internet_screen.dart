import 'package:flutter/material.dart';
import 'package:car_connect/core/resource/color_manager.dart';
import 'package:car_connect/core/resource/font_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/widget/button/main_app_button.dart';
import 'package:car_connect/core/widget/empty/empty_widget.dart';
import 'package:car_connect/core/widget/text/app_text_widget.dart';
import 'package:car_connect/router/router.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EmptyWidget(
          title: "oopsNoConnection",
          subTitle: "itSeemsYouAreCurrentlyOffline",
          actions: MainAppButton(
            alignment: Alignment.center,
            width: AppWidthManager.w60,
            height: AppHeightManager.h6,
            color: AppColorManager.navy,
            borderRadius: BorderRadius.circular(
              AppRadiusManager.r15,
            ),
            child: AppTextWidget(
              text: "refresh",
              color: AppColorManager.white,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            onTap: () {
              if (CurrentRoute.currentRouteName != null) {
                Navigator.of(context).pushReplacementNamed(CurrentRoute.currentRouteName!);
              }
            },
          ),
        ),
      ),
    );
  }
}

// class NoInternetArgument {
//   RouteNamedScreens? refreshRoute;
//
//   NoInternetArgument({this.refreshRoute});
// }
