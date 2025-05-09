import 'dart:convert';

import 'package:car_connect/core/api/api_links.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/core/widget/app_bar/main_app_bar.dart';
import 'package:car_connect/core/widget/button/main_app_button.dart';
import 'package:car_connect/core/widget/image/main_image_widget.dart';
import 'package:car_connect/core/widget/loading/app_circular_progress_widget.dart';
import 'package:car_connect/feature/home/model/car_details_response_entity.dart';
import 'package:car_connect/feature/home/widget/expansion_card.dart';
import 'package:car_connect/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/widget/text/app_text_widget.dart';

class CarDetailsScreen extends StatefulWidget {
  CarDetailsArgs args;

  CarDetailsScreen({super.key, required this.args});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  int status = -1;
  CarDetailsResponseEntity? entity;
  int selectedType = 0;

  makeOrder({
    required String paymentType,
    required String carId,
    required String date,
    required String lat,
    required String long,
  }) async {
    http.Response response =
        await HttpMethods().postMethod(ApiPostUrl.addOrder, {
      "paymentType": paymentType,
      "carId": carId,
      "userId": AppSharedPreferences.getUserId(),
      "date": date,
      "lat": lat,
      "long": long
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteNamedScreens.main,
          (route) => false,
        );
        setState(() {});
      }
    } else {
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

  void getCar() async {
    setState(() {
      status = 0;
    });
    http.Response response = await HttpMethods()
        .postMethod(ApiPostUrl.getCarDetails, {"id": widget.args.id});
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        status = 1;
      });

      if ((response.body ?? "").isNotEmpty) {
        entity = carDetailsResponseEntityFromJson(response.body);
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
  void initState() {
    getCar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Car Details",
      ),
      body: SingleChildScrollView(
        child: Visibility(
          visible: status == 1,
          replacement: Padding(
            padding: EdgeInsets.only(top: AppHeightManager.h30),
            child: Center(child: AppCircularProgressWidget()),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppHeightManager.h30,
                  width: AppWidthManager.w100,
                  child: MainImageWidget(
                    height: AppHeightManager.h30,
                    imageUrl: (entity?.images ?? []).isEmpty
                        ? "s"
                        : imageUrl + (entity?.images?.first.imageUrl ?? "s"),
                  ),
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                AppTextWidget(
                  text: "${entity?.car?.desc}",
                  fontSize: FontSizeManager.fs16,
                  fontWeight: FontWeight.w400,
                  color: AppColorManager.textGrey,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MainAppButton(
                      color: AppColorManager.navy,
                      borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                      // outLinedBorde: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: AppWidthManager.w5,
                          vertical: AppHeightManager.h1),
                      child: AppTextWidget(
                        text: "${entity?.car?.killo} kilo",
                        fontSize: FontSizeManager.fs16,
                        fontWeight: FontWeight.w400,
                        color: AppColorManager.white,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextWidget(
                      text: entity?.car?.available == 1
                          ? "Availability :yes"
                          : "Availability :no",
                      fontSize: FontSizeManager.fs17,
                      fontWeight: FontWeight.w500,
                      color: AppColorManager.white,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    MainAppButton(
                      color: AppColorManager.background,
                      borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                      // outLinedBorde: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: AppWidthManager.w5,
                          vertical: AppHeightManager.h1),
                      child: AppTextWidget(
                        text: "${entity?.car?.price} \$",
                        fontSize: FontSizeManager.fs18,
                        fontWeight: FontWeight.w600,
                        color: AppColorManager.white,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                SizedBox(
                  width: AppWidthManager.w100,
                  child: ExpansionCard(
                    color: AppColorManager.dotGrey,
                    headerWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: "Gear of the car",
                          fontSize: FontSizeManager.fs17,
                          fontWeight: FontWeight.w600,
                          color: AppColorManager.background,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppTextWidget(
                          text: "${entity?.gear?.name}",
                          fontSize: FontSizeManager.fs16,
                          fontWeight: FontWeight.w400,
                          color: AppColorManager.textGrey,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        AppTextWidget(
                          text: "Brand of the car ",
                          fontSize: FontSizeManager.fs17,
                          fontWeight: FontWeight.w600,
                          color: AppColorManager.background,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppTextWidget(
                          text: "${entity?.brand?.name}",
                          fontSize: FontSizeManager.fs16,
                          fontWeight: FontWeight.w400,
                          color: AppColorManager.textGrey,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    expansionWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: "model of the car",
                          fontSize: FontSizeManager.fs17,
                          fontWeight: FontWeight.w600,
                          color: AppColorManager.background,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppTextWidget(
                          text: "${entity?.model?.name}",
                          fontSize: FontSizeManager.fs16,
                          fontWeight: FontWeight.w400,
                          color: AppColorManager.textGrey,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        AppTextWidget(
                          text: "Color of the car",
                          fontSize: FontSizeManager.fs17,
                          fontWeight: FontWeight.w600,
                          color: AppColorManager.background,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppTextWidget(
                          text: "${entity?.color?.name}",
                          fontSize: FontSizeManager.fs16,
                          fontWeight: FontWeight.w400,
                          color: AppColorManager.textGrey,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: AppHeightManager.h3,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MainAppButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppWidthManager.w10),
                        borderRadius:
                            BorderRadius.circular(AppRadiusManager.r10),
                        height: AppHeightManager.h7point5,
                        onTap: () {
                          setState(() {
                            selectedType = 0;
                          });
                        },
                        color: selectedType == 0
                            ? AppColorManager.navy
                            : AppColorManager.white,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppTextWidget(
                              text: "Pay Later",
                              fontSize: FontSizeManager.fs15,
                              color: selectedType == 1
                                  ? AppColorManager.navy
                                  : AppColorManager.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppWidthManager.w1Point2,
                    ),
                    Expanded(
                      child: MainAppButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppWidthManager.w10),
                        borderRadius:
                            BorderRadius.circular(AppRadiusManager.r10),
                        height: AppHeightManager.h7point5,
                        onTap: () {
                          setState(() {
                            selectedType = 1;
                          });
                        },
                        color: selectedType == 1
                            ? AppColorManager.navy
                            : AppColorManager.white,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppTextWidget(
                              text: "Using Card",
                              fontSize: FontSizeManager.fs15,
                              color: selectedType == 0
                                  ? AppColorManager.navy
                                  : AppColorManager.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppHeightManager.h3,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: AppHeightManager.h3),
                  width: AppWidthManager.w100,
                  height: AppHeightManager.h7,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColorManager.background,
                      borderRadius: BorderRadius.circular(AppRadiusManager.r15),
                      border: Border.all(color: AppColorManager.white)),
                  child: MainAppButton(
                    onTap: () {
                      makeOrder(
                          paymentType: selectedType.toString(),
                          carId: (entity?.car?.id).toString(),
                          date: "",
                          lat: "",
                          long: "");
                    },
                    color: AppColorManager.background,
                    child: AppTextWidget(
                      text: "Buy Now",
                      fontSize: FontSizeManager.fs16,
                      fontWeight: FontWeight.w500,
                      color: AppColorManager.white,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CarDetailsArgs {
  String id;

  CarDetailsArgs({required this.id});
}
