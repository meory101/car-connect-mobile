import 'package:car_connect/core/resource/icon_manager.dart';
import 'package:car_connect/feature/board/widget/settings_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/image_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/storage/shared/shared_pref.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../../../router/router.dart';

class UserBoard extends StatefulWidget {
  const UserBoard({super.key});

  @override
  State<UserBoard> createState() => _UserBoardState();
}

class _UserBoardState extends State<UserBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppHeightManager.h2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                            text: "Car Connect",
                            color: AppColorManager.white,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSizeManager.fs20,
                            maxLines: 2,
                          ),
                          AppTextWidget(
                            text: AppSharedPreferences.getAuthType() == "0"
                                ? "Customer Account"
                                : AppSharedPreferences.getCommercialRegister()
                                .isEmpty
                                ? "Business Account"
                                : "Company Account",
                            color: Colors.teal,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSizeManager.fs16,
                            maxLines: 2,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: MainImageWidget(
                          imagePath: AppImageManager.main,
                          height: AppHeightManager.h8,
                          width: AppHeightManager.h8,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppHeightManager.h5,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: SettingsItem(
                  //           onTap: () {
                  //             Navigator.of(context)
                  //                 .pushNamed(RouteNamedScreens.addCar);
                  //           },
                  //           title: "Add Car",
                  //           icon: AppIconManager.car),
                  //     ),
                  //     SizedBox(
                  //       width: AppWidthManager.w2point5,
                  //     ),
                  //     Expanded(
                  //       child: SettingsItem(
                  //           onTap: () {
                  //             Navigator.of(context)
                  //                 .pushNamed(RouteNamedScreens.myCars);
                  //           },                        title: "My Car",
                  //           icon: AppIconManager.car),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: AppHeightManager.h2,
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: SettingsItem(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RouteNamedScreens.myOrders);
                            },
                            title: "My Orders",
                            icon: AppIconManager.car),
                      ),
                    ],
                  ),
              SizedBox(
                  height: AppHeightManager.h2,
                ),
                  Row(
                    children: [
                      Expanded(
                        child: SettingsItem(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RouteNamedScreens.myFavorites);
                            },
                            title: "addvorites",
                            icon: AppIconManager.car),
                      ),
                    ],
                  ),
                  SizedBox(height: AppHeightManager.h2),
                  SettingsItem(
                    icon: AppIconManager.car,
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteNamedScreens.reservations);
                    },
                    // alignment: Alignment.center,
                    // width: AppWidthManager.w100,
                    // height: AppHeightManager.h6,
                    // color: AppColorManager.navy,
                    title: "My Reservations",

                  ),
                ],
              ),
            ),
          )),
    );
  }
}
