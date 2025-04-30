import 'dart:convert';
import 'package:car_connect/core/api/api_links.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/core/widget/button/main_app_button.dart';
import 'package:car_connect/core/widget/image/main_image_widget.dart';
import 'package:car_connect/feature/profile/model/businsess_user_model.dart';
import 'package:car_connect/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/widget/text/app_text_widget.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int status = -1;
  BusinsessUserModel? user;

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  void getProfile() async {
    setState(() {
      status = 0;
    });

    http.Response response = await HttpMethods().postMethod(
        ApiPostUrl.getBusinessUser, {"id": AppSharedPreferences.getUserId()});
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        status = 1;
      });

      if ((response.body ?? "").isNotEmpty) {
        user = businsessUserModelFromJson(response.body);
        print(response.body);
        print(imageUrl + (user?.user?.idImageUrl ?? ""));
      } else {
        setState(() {
          status = 2;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: utf8.decode(response.bodyBytes),
              color: AppColorManager.navy,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: status != 1
          ? SizedBox()
          : SafeArea(
              child: Padding(
                padding: EdgeInsets.all(AppWidthManager.w3Point8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: "name : ${(user?.user?.name ?? "")}",
                        fontSize: FontSizeManager.fs18,
                        color: AppColorManager.white,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: AppHeightManager.h2,
                      ),
                      AppTextWidget(
                        text: "desc : ${(user?.user?.desc ?? "")}",
                        fontSize: FontSizeManager.fs18,
                        color: AppColorManager.white,
                        fontWeight: FontWeight.w600,
                        maxLines: 4,
                      ),
                      SizedBox(
                        height: AppHeightManager.h2,
                      ),
                      AppTextWidget(
                        text: "phoneNumber : ${(user?.user?.phone ?? "")}",
                        fontSize: FontSizeManager.fs18,
                        color: AppColorManager.white,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: AppHeightManager.h2,
                      ),
                      AppTextWidget(
                        text: "Id Image",
                        fontSize: FontSizeManager.fs17,
                        color: AppColorManager.white,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: AppHeightManager.h1point8,
                      ),
                      Container(
                        height: AppHeightManager.h20,
                        width: AppWidthManager.w100,
                        child: MainImageWidget(
                          height: AppHeightManager.h4,
                          width: AppWidthManager.w100,
                          imageUrl: imageUrl + (user?.user?.idImageUrl ?? ""),
                        ),
                      ),
                      SizedBox(
                        height: AppHeightManager.h2,
                      ),
                      Visibility(
                        visible: user?.user?.commercialRegisterImageUrl != null,
                        // replacement: MainAppButton(
                        //   alignment: Alignment.center,
                        //   color: AppColorManager.navy,
                        //   width: AppWidthManager.w100,
                        //   height: AppHeightManager.h6,
                        //   child:   AppTextWidget(
                        //     text: "Upload Commercial Register",
                        //     fontSize: FontSizeManager.fs15,
                        //     color: AppColorManager.white,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: "commercial register",
                              fontSize: FontSizeManager.fs17,
                              color: AppColorManager.white,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: AppHeightManager.h1point8,
                            ),
                            Container(
                              height: AppHeightManager.h20,
                              width: AppWidthManager.w100,
                              child: MainImageWidget(
                                height: AppHeightManager.h4,
                                width: AppWidthManager.w100,
                                imageUrl: imageUrl +
                                    (user?.user?.commercialRegisterImageUrl ??
                                        ""),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppHeightManager.h5,
                      ),
                      MainAppButton(
                        onTap: () {
                          AppSharedPreferences.clear();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            RouteNamedScreens.login,
                            (route) => false,
                          );
                        },
                        alignment: Alignment.center,
                        color: AppColorManager.navy,
                        width: AppWidthManager.w100,
                        height: AppHeightManager.h6,
                        child: AppTextWidget(
                          text: "Logout",
                          fontSize: FontSizeManager.fs15,
                          color: AppColorManager.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
