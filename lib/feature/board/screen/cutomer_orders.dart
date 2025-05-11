import 'dart:convert';
import 'dart:math';

import 'package:car_connect/core/api/api_links.dart';
import 'package:car_connect/core/widget/button/main_app_button.dart';
import 'package:car_connect/core/widget/button/main_app_dotted_button.dart';
import 'package:car_connect/core/widget/container/decorated_container.dart';
import 'package:car_connect/core/widget/form_field/title_app_form_filed.dart';
import 'package:car_connect/core/widget/image/main_image_widget.dart';
import 'package:car_connect/feature/board/model/order_response_entity.dart';
import 'package:car_connect/feature/car/model/car_response_entity.dart';
import 'package:car_connect/feature/home/screen/car_details_screen.dart';
import 'package:car_connect/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/storage/shared/shared_pref.dart';
import '../../../core/widget/app_bar/main_app_bar.dart';
import 'package:http/http.dart' as http;

import '../../../core/widget/loading/app_circular_progress_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../../home/model/car_details_response_entity.dart';

class CustomerOrdersScreen extends StatefulWidget {
  const CustomerOrdersScreen({super.key});

  @override
  State<CustomerOrdersScreen> createState() => _CarOrdersScreenState();
}

class _CarOrdersScreenState extends State<CustomerOrdersScreen> {
  OrderResponseEntity? entity;

  int status = -1;

  void getOrders() async {
    setState(() {
      status = 0;
    });
    print(AppSharedPreferences.getUserId());
    print('dddddddddddddd');
    http.Response response = await HttpMethods().postMethod(
        ApiPostUrl.getOrderByUserId,
        {"userId": AppSharedPreferences.getUserId()});
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        status = 1;

        entity = orderResponseEntityFromJson(response.body);
        loadCars();
        setState(() {});
      }
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

  Future<CarDetailsResponseEntity?> getCar(id) async {
    http.Response response = await HttpMethods()
        .postMethod(ApiPostUrl.getCarDetails, {"id": "${id}"});
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        CarDetailsResponseEntity car =
            carDetailsResponseEntityFromJson(response.body);
        return car;
      } else {}
    }
  }
  String? comment;

  List<CarDetailsResponseEntity?> cars = [];

  Future<void> loadCars() async {
    for (var order in entity?.orders ?? []) {
      cars.add(await getCar(order.car?.id ?? ""));
    }
    setState(() {});
  }

  changeOrderStatus(status, orderId) async {
    http.Response response = await HttpMethods().postMethod(
        ApiPostUrl.changeOrderStatus,
        {"orderId": "$orderId", "status": status});
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        getOrders();
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

  int rateCarStatus = -1;

  void rateCar(carId) async {
    setState(() {
      rateCarStatus = 0;
    });
    http.Response response =
        await HttpMethods().postMethod(ApiPostUrl.rateCar, {
      "userId": AppSharedPreferences.getUserId(),
      "carId": carId.toString(),
      "value": rate.toString()
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        rateCarStatus = 1;
        Navigator.of(context).pop();
        setState(() {});
      }
    } else {
      setState(() {
        rateCarStatus = 2;
      });
      Navigator.of(context).pop();

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

  void addComment(carId, comment) async {
    setState(() {
      rateCarStatus = 0;
    });
    http.Response response =
        await HttpMethods().postMethod(ApiPostUrl.addComment, {
      "userId": AppSharedPreferences.getUserId(),
      "carId": carId.toString(),
      "comment": comment.toString()
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        rateCarStatus = 1;
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: "comment added successfully",
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
      setState(() {
        rateCarStatus = 2;
      });
      Navigator.of(context).pop();

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

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  int rate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(title: "My Orders"),
        body: status == 0
            ? Padding(
                padding: EdgeInsets.only(top: AppHeightManager.h15),
                child: Center(child: AppCircularProgressWidget()),
              )
            : cars.isEmpty
                ? Center()
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(AppWidthManager.w3Point8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: entity != null,
                            replacement: Padding(
                              padding:
                                  EdgeInsets.only(top: AppHeightManager.h20),
                              child: const Center(
                                  child: AppCircularProgressWidget()),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: entity?.orders?.length ?? 0,
                              itemBuilder: (context, index) {
                                String status =
                                    entity?.orders?[index].order?.status ?? "0";

                                // String status =
                                //     entity?.orders?[index].order?.status ?? "0";
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        RouteNamedScreens.carDetails,
                                        arguments: CarDetailsArgs(
                                            id: (entity?.orders?[index].car?.id
                                                    .toString()) ??
                                                ""));
                                  },
                                  child: DecoratedContainer(
                                    padding: EdgeInsets.all(
                                        AppWidthManager.w3Point8),
                                    borderRadius: BorderRadius.circular(
                                        AppRadiusManager.r15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppTextWidget(
                                              text: (status) == "0"
                                                  ? "Pending"
                                                  : (status) == "1"
                                                      ? "Accepted"
                                                      : "Rejected",
                                              color: (status) == "0"
                                                  ? AppColorManager.yellow
                                                  : (status) == "1"
                                                      ? AppColorManager.green
                                                      : AppColorManager.red,
                                              fontSize: FontSizeManager.fs16,
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.visible,
                                            ),
                                            AppTextWidget(
                                              text:
                                                  "#${Random().nextInt(100000)}",
                                              color: AppColorManager.grey,
                                              fontSize: FontSizeManager.fs16,
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppHeightManager.h1point8,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: AppHeightManager.h6,
                                                  width: AppHeightManager.h6,
                                                  child: MainImageWidget(
                                                    height: AppHeightManager.h6,
                                                    fit: BoxFit.cover,
                                                    width: AppHeightManager.h6,
                                                    imageUrl:
                                                        (cars[index]?.images ??
                                                                    [])
                                                                .isEmpty
                                                            ? "cc"
                                                            : cars[index]
                                                                    ?.images
                                                                    ?.first
                                                                    .imageUrl ??
                                                                "cc",
                                                  ),
                                                )),
                                            SizedBox(
                                              width: AppWidthManager.w1Point8,
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: AppTextWidget(
                                                  text:
                                                      "${cars[index]?.car?.desc}",
                                                  maxLines: 2,
                                                  color: AppColorManager.black,
                                                  fontSize:
                                                      FontSizeManager.fs16,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppHeightManager.h1point8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                AppTextWidget(
                                                  text: "brand",
                                                  color: AppColorManager.grey,
                                                  fontSize:
                                                      FontSizeManager.fs16,
                                                  fontWeight: FontWeight.w400,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                                AppTextWidget(
                                                  text:
                                                      "${cars[index]?.brand?.name}",
                                                  color: AppColorManager.grey,
                                                  fontSize:
                                                      FontSizeManager.fs16,
                                                  fontWeight: FontWeight.w400,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                AppTextWidget(
                                                  text: "model",
                                                  color: AppColorManager.grey,
                                                  fontSize:
                                                      FontSizeManager.fs16,
                                                  fontWeight: FontWeight.w400,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                                AppTextWidget(
                                                  text:
                                                      "${cars[index]?.model?.name}",
                                                  color: AppColorManager.grey,
                                                  fontSize:
                                                      FontSizeManager.fs16,
                                                  fontWeight: FontWeight.w400,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                AppTextWidget(
                                                  text: "color",
                                                  color: AppColorManager.grey,
                                                  fontSize:
                                                      FontSizeManager.fs16,
                                                  fontWeight: FontWeight.w400,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                                AppTextWidget(
                                                  text:
                                                      "${cars[index]?.color?.name}",
                                                  color: AppColorManager.grey,
                                                  fontSize:
                                                      FontSizeManager.fs16,
                                                  fontWeight: FontWeight.w400,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                AppTextWidget(
                                                  text: "gear",
                                                  color: AppColorManager.grey,
                                                  fontSize:
                                                      FontSizeManager.fs16,
                                                  fontWeight: FontWeight.w400,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                                AppTextWidget(
                                                  text:
                                                      "${cars[index]?.gear?.name}",
                                                  color: AppColorManager.grey,
                                                  fontSize:
                                                      FontSizeManager.fs16,
                                                  fontWeight: FontWeight.w400,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppHeightManager.h3,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            MainAppButton(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.6,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppRadiusManager.r10),
                                              height: AppHeightManager.h5,
                                              onTap: () {
                                                rate = 0;
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .all(Radius.circular(
                                                                AppRadiusManager
                                                                    .r20)),
                                                      ),
                                                      insetPadding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            AppWidthManager.w4,
                                                      ),
                                                      elevation: 0,
                                                      backgroundColor:
                                                          AppColorManager.white,
                                                      child: StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                        return SizedBox(
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(
                                                                  AppWidthManager
                                                                      .w3Point8),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    height: AppHeightManager
                                                                        .h2point5,
                                                                  ),
                                                                  AppTextWidget(
                                                                    text:
                                                                        "rate",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        FontSizeManager
                                                                            .fs18,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .visible,
                                                                    color: AppColorManager
                                                                        .black,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        AppHeightManager
                                                                            .h1,
                                                                  ),
                                                                  AppTextWidget(
                                                                    text:
                                                                        "Rate this Car",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        FontSizeManager
                                                                            .fs15,
                                                                    color:
                                                                        AppColorManager
                                                                            .grey,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  SizedBox(
                                                                    height: AppHeightManager
                                                                        .h1point8,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            rate =
                                                                                1;
                                                                          });
                                                                        },
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .star,
                                                                          color: rate > 0
                                                                              ? AppColorManager.yellow
                                                                              : AppColorManager.grey,
                                                                        ),
                                                                      ),
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            rate =
                                                                                2;
                                                                          });
                                                                        },
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .star,
                                                                          color: rate > 1
                                                                              ? AppColorManager.yellow
                                                                              : AppColorManager.grey,
                                                                        ),
                                                                      ),
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            rate =
                                                                                3;
                                                                          });
                                                                        },
                                                                        icon: Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: rate > 2
                                                                                ? AppColorManager.yellow
                                                                                : AppColorManager.grey),
                                                                      ),
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            rate =
                                                                                4;
                                                                          });
                                                                        },
                                                                        icon: Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: rate > 3
                                                                                ? AppColorManager.yellow
                                                                                : AppColorManager.grey),
                                                                      ),
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            rate =
                                                                                5;
                                                                          });
                                                                        },
                                                                        icon: Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: rate > 4
                                                                                ? AppColorManager.yellow
                                                                                : AppColorManager.grey),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: AppHeightManager
                                                                        .h3point4,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            MainAppButton(
                                                                          color:
                                                                              AppColorManager.navy,
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: AppWidthManager.w10),
                                                                          borderRadius:
                                                                              BorderRadius.circular(AppRadiusManager.r15),
                                                                          height:
                                                                              AppHeightManager.h6,
                                                                          onTap:
                                                                              () {
                                                                            rateCar("${cars[index]?.car?.id}");
                                                                          },
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              AppTextWidget(
                                                                            text:
                                                                                "done",
                                                                            fontSize:
                                                                                FontSizeManager.fs16,
                                                                            color:
                                                                                AppColorManager.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            MainAppButton(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: AppWidthManager.w10),
                                                                          borderRadius:
                                                                              BorderRadius.circular(AppRadiusManager.r15),
                                                                          height:
                                                                              AppHeightManager.h6,
                                                                          onTap:
                                                                              () {},
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              AppTextWidget(
                                                                            text:
                                                                                "cancel",
                                                                            fontSize:
                                                                                FontSizeManager.fs16,
                                                                            color:
                                                                                AppColorManager.navy,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: AppWidthManager
                                                                            .w1Point2,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: AppHeightManager
                                                                        .h1point8,
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
                                              color: AppColorManager.navy,
                                              alignment: Alignment.center,
                                              child: AppTextWidget(
                                                text: "rate now",
                                                fontSize: FontSizeManager.fs16,
                                                color: AppColorManager.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: AppWidthManager.w2,
                                            ),
                                            MainAppDottedButton(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.6,
                                              // borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                                              height: AppHeightManager.h5,
                                              onTap: () {
                                                comment = '';
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .all(Radius.circular(
                                                                AppRadiusManager
                                                                    .r20)),
                                                      ),
                                                      insetPadding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            AppWidthManager.w4,
                                                      ),
                                                      elevation: 0,
                                                      backgroundColor:
                                                          AppColorManager.white,
                                                      child: StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                        return SizedBox(
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(
                                                                  AppWidthManager
                                                                      .w3Point8),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    height: AppHeightManager
                                                                        .h2point5,
                                                                  ),
                                                                  AppTextWidget(
                                                                    text:
                                                                        "comment",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        FontSizeManager
                                                                            .fs18,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .visible,
                                                                    color: AppColorManager
                                                                        .black,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        AppHeightManager
                                                                            .h1,
                                                                  ),
                                                                  AppTextWidget(
                                                                    text:
                                                                        "add comment for this car",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        FontSizeManager
                                                                            .fs15,
                                                                    color:
                                                                        AppColorManager
                                                                            .grey,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  SizedBox(
                                                                    height: AppHeightManager
                                                                        .h1point8,
                                                                  ),
                                                                  TitleAppFormFiled(
                                                                      hint:
                                                                          "comment",
                                                                      title:
                                                                          "comment",
                                                                      onChanged:
                                                                          (p0) {
                                                                        comment =
                                                                            p0;
                                                                      },
                                                                      validator:
                                                                          (p0) {

                                                                          },),
                                                                  SizedBox(
                                                                    height: AppHeightManager
                                                                        .h1point8,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            MainAppButton(
                                                                          color:
                                                                              AppColorManager.navy,
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: AppWidthManager.w10),
                                                                          borderRadius:
                                                                              BorderRadius.circular(AppRadiusManager.r15),
                                                                          height:
                                                                              AppHeightManager.h6,
                                                                          onTap:
                                                                              () {
                                                                            if((comment??"").isEmpty)return;
                                                                            addComment(
                                                                              "${cars[index]?.car?.id}",
                                                                                comment??""
                                                                            );
                                                                          },
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              AppTextWidget(
                                                                            text:
                                                                                "comment",
                                                                            fontSize:
                                                                                FontSizeManager.fs16,
                                                                            color:
                                                                                AppColorManager.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            MainAppButton(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: AppWidthManager.w10),
                                                                          borderRadius:
                                                                              BorderRadius.circular(AppRadiusManager.r15),
                                                                          height:
                                                                              AppHeightManager.h6,
                                                                          onTap:
                                                                              () {},
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              AppTextWidget(
                                                                            text:
                                                                                "cancel",
                                                                            fontSize:
                                                                                FontSizeManager.fs16,
                                                                            color:
                                                                                AppColorManager.navy,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: AppWidthManager
                                                                            .w1Point2,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: AppHeightManager
                                                                        .h1point8,
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
                                              color: AppColorManager.white,
                                              // alignment: Alignment.center,
                                              child: AppTextWidget(
                                                text: "add comment",
                                                color: AppColorManager.navy,
                                                fontSize: FontSizeManager.fs16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppHeightManager.h3,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
  }
}
