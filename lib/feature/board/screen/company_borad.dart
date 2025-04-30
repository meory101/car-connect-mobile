import 'package:car_connect/core/resource/size_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/resource/image_manager.dart';
import '../../../core/storage/shared/shared_pref.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../../../router/router.dart';
import '../widget/settings_item.dart';

class CompanyBorad extends StatefulWidget {
  const CompanyBorad({super.key});

  @override
  State<CompanyBorad> createState() => _CompanyBoradState();
}

class _CompanyBoradState extends State<CompanyBorad> {
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
              Row(
                children: [
                  Expanded(
                    child: SettingsItem(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RouteNamedScreens.addCar);
                        },
                        title: "Add Car",
                        icon: AppIconManager.car),
                  ),
                  SizedBox(
                    width: AppWidthManager.w2point5,
                  ),
                  Expanded(
                    child: SettingsItem(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RouteNamedScreens.myCars);
                        },                        title: "My Car",
                        icon: AppIconManager.car),
                  )
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
                              .pushNamed(RouteNamedScreens.carOrders);
                        },
                        title: "Order Requests(Accept Or Reject Purchase)",
                        icon: AppIconManager.car),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
