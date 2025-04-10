import 'package:flutter/material.dart';
import 'package:car_connect/router/router.dart';
import '../../../../core/helper/app_info_helper.dart';
import '../../../../core/resource/color_manager.dart';
import '../../../../core/resource/constant_manager.dart';
import '../../../../core/resource/font_manager.dart';
import '../../../../core/resource/image_manager.dart';
import '../../../../core/resource/size_manager.dart';
import '../../../../core/widget/image/main_image_widget.dart';
import '../../../../core/widget/loading/app_circular_progress_widget.dart';
import '../../../../core/widget/text/app_text_widget.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToNextPage();
    super.initState();
  }

  navigateToNextPage() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(RouteNamedScreens.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColorManager.background,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              height: AppHeightManager.h100,
              width: AppWidthManager.w100,
            ),
            Positioned(
             left: 0,
              right: 0,
              top: AppHeightManager.h25,
              child: MainImageWidget(
                  imagePath: AppImageManager.main,
                height: AppHeightManager.h50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: AppHeightManager.h1point8,
            ),
            Positioned(

              bottom: 10,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextWidget(
                      text:
                      "Car Connect",
                      fontSize: FontSizeManager.fs15,
                      fontWeight: FontWeight.w600,
                      color: AppColorManager.white,
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
                    ),
                    SizedBox(
                        width: AppWidthManager.w5,
                        height: AppWidthManager.w5,
                        child: const AppCircularProgressWidget(
                          color: AppColorManager.white,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
