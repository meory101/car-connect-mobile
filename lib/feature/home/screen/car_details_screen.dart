import 'dart:convert';

import 'package:car_connect/core/api/api_links.dart';
import 'package:car_connect/core/resource/image_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/core/widget/app_bar/main_app_bar.dart';
import 'package:car_connect/core/widget/button/main_app_button.dart';
import 'package:car_connect/core/widget/form_field/title_app_form_filed.dart';
import 'package:car_connect/core/widget/image/main_image_widget.dart';
import 'package:car_connect/core/widget/loading/app_circular_progress_widget.dart';
import 'package:car_connect/feature/home/model/car_details_response_entity.dart';
import 'package:car_connect/feature/home/screen/cart_screen.dart';
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

  void addLike(carId, action) async {
    http.Response response =
        await HttpMethods().postMethod(ApiPostUrl.addLike, {
      "userId": AppSharedPreferences.getUserId(),
      "carId": carId.toString(),
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        getCar();

        setState(() {});
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColorManager.white,
          content: AppTextWidget(
            text: jsonDecode(response.body).toString(),
            color: AppColorManager.navy,
            fontSize: FontSizeManager.fs16,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        ),
      );
    }
  }

  String? content;

  reportContent() async {
    http.Response response =
        await HttpMethods().postMethod(ApiPostUrl.addReport, {
      "userId": AppSharedPreferences.getUserId(),
      "carId": widget.args.id.toString(),
      "content": content ?? ""
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: "reported successfully",
              color: AppColorManager.green,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
        );

        setState(() {});
      }
    } else {
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColorManager.white,
          content: AppTextWidget(
            text: jsonDecode(response.body).toString(),
            color: AppColorManager.red,
            fontSize: FontSizeManager.fs16,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        ),
      );
    }
  }

  void addToFavorite(carId) async {
    http.Response response =
        await HttpMethods().postMethod(ApiPostUrl.addFavorite, {
      "userId": AppSharedPreferences.getUserId(),
      "carId": carId.toString(),
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: "added to favorites successfully",
              color: AppColorManager.green,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
        );

        setState(() {});
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColorManager.white,
          content: AppTextWidget(
            text: jsonDecode(response.body).toString(),
            color: AppColorManager.red,
            fontSize: FontSizeManager.fs16,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        ),
      );
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
        actions: [
          Visibility(
            visible: (int.tryParse(entity?.views ?? "0") ?? 0) > 20,
            child: MainAppButton(
              color: AppColorManager.gold,
              borderRadius: BorderRadius.circular(AppRadiusManager.r10),
              // outLinedBorde: true,
              padding: EdgeInsets.symmetric(
                  horizontal: AppWidthManager.w5,
                  vertical: AppHeightManager.h1),
              child: AppTextWidget(
                text: "Featured",
                fontSize: FontSizeManager.fs16,
                fontWeight: FontWeight.w400,
                color: AppColorManager.white,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
          SizedBox(
            width: AppWidthManager.w1Point8,
          ),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppRadiusManager.r20)),
                      ),
                      insetPadding: EdgeInsets.symmetric(
                        horizontal: AppWidthManager.w4,
                      ),
                      elevation: 0,
                      backgroundColor: AppColorManager.white,
                      child: StatefulBuilder(builder: (context, setState) {
                        return SizedBox(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(AppWidthManager.w3Point8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: AppHeightManager.h2point5,
                                  ),
                                  AppTextWidget(
                                    text: "report",
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSizeManager.fs18,
                                    overflow: TextOverflow.visible,
                                    color: AppColorManager.black,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: AppHeightManager.h1,
                                  ),
                                  AppTextWidget(
                                    text: "Report Content",
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSizeManager.fs15,
                                    color: AppColorManager.grey,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: AppHeightManager.h1point8,
                                  ),
                                  TitleAppFormFiled(
                                    hint: "report content",
                                    title: "report content",
                                    onChanged: (value) {
                                      content = value;

                                      return null;
                                    },
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: AppHeightManager.h1point8,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MainAppButton(
                                          color: AppColorManager.red,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: AppWidthManager.w10),
                                          borderRadius: BorderRadius.circular(
                                              AppRadiusManager.r15),
                                          height: AppHeightManager.h6,
                                          onTap: () {
                                            reportContent();
                                          },
                                          alignment: Alignment.center,
                                          child: AppTextWidget(
                                            text: "done",
                                            fontSize: FontSizeManager.fs16,
                                            color: AppColorManager.white,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: MainAppButton(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: AppWidthManager.w10),
                                          borderRadius: BorderRadius.circular(
                                              AppRadiusManager.r15),
                                          height: AppHeightManager.h6,
                                          onTap: () {},
                                          alignment: Alignment.center,
                                          child: AppTextWidget(
                                            text: "cancel",
                                            fontSize: FontSizeManager.fs16,
                                            color: AppColorManager.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: AppWidthManager.w1Point2,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: AppHeightManager.h1point8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                );
              },
              icon: Icon(Icons.report, color: AppColorManager.red)),
          SizedBox(
            width: AppWidthManager.w1Point8,
          ),
        ],
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.remove_red_eye,
                              color: AppColorManager.white,
                            ),
                            SizedBox(
                              width: AppWidthManager.w1Point8,
                            ),
                            AppTextWidget(
                              text: "${entity?.views}",
                              fontSize: FontSizeManager.fs16,
                              fontWeight: FontWeight.w400,
                              color: AppColorManager.textGrey,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                addLike(entity?.car?.id ?? "", "add");
                              },
                              icon: const Icon(
                                Icons.thumb_up_alt_rounded,
                                color: AppColorManager.white,
                              ),
                            ),
                            SizedBox(
                              width: AppWidthManager.w1Point2,
                            ),
                            AppTextWidget(
                              text: "${entity?.likes}",
                              fontSize: FontSizeManager.fs16,
                              fontWeight: FontWeight.w400,
                              color: AppColorManager.textGrey,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        addToFavorite(entity?.car?.id ?? "");
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: AppColorManager.white,
                          ),
                          SizedBox(
                            width: AppWidthManager.w1Point8,
                          ),
                          AppTextWidget(
                            text: "add to favorites",
                            fontSize: FontSizeManager.fs16,
                            fontWeight: FontWeight.w400,
                            color: AppColorManager.textGrey,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AppTextWidget(
                          text: "${entity?.rate ?? 0.0}",
                          color: Colors.white,
                          fontSize: FontSizeManager.fs16,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        )
                      ],
                    ),
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
                Column(
                  children: List.generate(
                    entity?.comments?.length ?? 0,
                    (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: AppHeightManager.h3,
                                width: AppHeightManager.h3,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColorManager.green),
                              ),
                              SizedBox(
                                width: AppWidthManager.w1Point8,
                              ),
                              AppTextWidget(
                                text: (entity?.comments?[index].user?.phone ??
                                        "") +
                                    ("  commented:"),
                                color: AppColorManager.white,
                                fontSize: FontSizeManager.fs16,
                              ),
                            ],
                          ),
                          AppTextWidget(
                            text: entity?.comments?[index].comment ?? "",
                            color: AppColorManager.white,
                          ),
                          SizedBox(
                            height: AppHeightManager.h1point8,
                          )
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppHeightManager.h3,
                ),
                MainAppButton(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteNamedScreens.cart,
                        arguments: CartArgs(
                            carId: (entity!.car)));
                  },
                  alignment: Alignment.center,
                  width: AppWidthManager.w100,
                  height: AppHeightManager.h6,
                  color: AppColorManager.navy,
                  child: AppTextWidget(
                    text: "Add To Cart",
                    color: Colors.white,
                    fontSize: FontSizeManager.fs16,
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
