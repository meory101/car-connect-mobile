import 'dart:convert';

import 'package:car_connect/core/resource/image_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/widget/app_bar/main_app_bar.dart';
import 'package:car_connect/core/widget/image/main_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/storage/shared/shared_pref.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/text/app_text_widget.dart';
import 'package:http/http.dart' as http;

import '../../../router/router.dart';
import '../model/car_details_response_entity.dart';
import '../model/pay_account.dart';

class CartScreen extends StatefulWidget {
  final CartArgs args;
  const CartScreen({super.key,required this.args});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

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
      "date": DateTime.now().toString(),
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
@override
  void initState() {
  getUserAccount();
    super.initState();
  }
  PayAccount? payAccount;

  void getUserAccount() async {
    print( AppSharedPreferences.getUserId());
    http.Response response = await HttpMethods().postMethod(
        ApiPostUrl.getUserPayCard, {"userId": AppSharedPreferences.getUserId()} );
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        print(response.body);
        payAccount = payAccountFromJson(response.body);
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: ""),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(AppWidthManager.w3Point8),
        child: Column(

          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: AppHeightManager.h10,
                    width: AppHeightManager.h10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(AppRadiusManager.r15))
                    ),
                    child: MainImageWidget(
                      height: AppHeightManager.h10,
                      width: AppHeightManager.h10,
                      imagePath: AppImageManager.placeholder,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: AppWidthManager.w1Point8,),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(text: widget.args.carId?.desc??"",color: Colors.white,
                      fontSize: FontSizeManager.fs16,

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppTextWidget(
                            text: "${widget.args.carId?.price} \$",
                            fontSize: FontSizeManager.fs18,
                            fontWeight: FontWeight.w600,
                            color: AppColorManager.white,
                            overflow: TextOverflow.ellipsis,

                            maxLines: 2,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: AppHeightManager.h6,
            ),

            Visibility(
              visible: selectedType==1,
              child: Container(
                padding: EdgeInsets.all(AppWidthManager.w3Point8),
                height: AppHeightManager.h13,
                width: AppWidthManager.w100,
                decoration: BoxDecoration(
                  color: AppColorManager.navy.withAlpha(80),
                  borderRadius:
                  BorderRadius.circular(AppRadiusManager.r12),
                  border: Border.all(color: AppColorManager.navy),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            AppTextWidget(
                              text: "Car Connect Pay Card",
                              fontSize: FontSizeManager.fs17,
                              color: AppColorManager.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),

                        AppTextWidget(
                          text: "${payAccount?.accountNumber??""}",
                          fontSize: FontSizeManager.fs17,
                          color: AppColorManager.white,
                          fontWeight: FontWeight.w700,
                        ),
                        Row(
                          children: [
                            AppTextWidget(
                              text: "${payAccount?.balance??"0.0"} \$",
                              fontSize: FontSizeManager.fs16,
                              color: AppColorManager.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          AppSharedPreferences.clear();

                          Navigator.of(context).pushNamedAndRemoveUntil(
                            RouteNamedScreens.login,
                                (route) => false,
                          );
                        },
                        icon: Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ))
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
                      carId: (widget.args.carId?.id).toString(),
                      date: "",
                      lat: "0",
                      long: "0");
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
    );
  }
}

class CartArgs{
  Car? carId;

  CartArgs({required this.carId});
}