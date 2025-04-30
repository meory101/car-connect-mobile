import 'dart:convert';
import 'package:car_connect/core/resource/icon_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/core/widget/loading/app_circular_progress_widget.dart';
import 'package:car_connect/feature/car/model/car_response_entity.dart';
import 'package:car_connect/feature/home/model/pay_account.dart';
import 'package:car_connect/feature/home/widget/home_banners.dart';
import 'package:car_connect/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/image_manager.dart';
import '../../../core/widget/container/shimmer_container.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../widget/car_card.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int status = -1;
  int newCarsStatus = -1;
  var selectedBrand;
  List<Cars> cars = [];
  List<Cars> newCars = [];
  int selectedBrandIndex = 0;
  var brands = [];
  int carStatus = -1;

  @override
  void initState() {
    getBrands();
    if (AppSharedPreferences.getAuthType() == "0") {
      getUserAccount();
    }
    getNewCars();
    super.initState();
  }

  void getCarsByBrand() async {
    setState(() {
      carStatus = 0;
    });

    http.Response response = await HttpMethods().postMethod(
        ApiPostUrl.getCarsByBrandId, {
      "brandId": selectedBrand == null ? "1" : selectedBrand['id'].toString()
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        carStatus = 1;
      });

      if ((response.body ?? "").isNotEmpty) {
        print(jsonDecode(response.body));
        if (jsonDecode(response.body)['cars'].isEmpty) {
          cars = [];
        } else {
          cars = carResponseEntityFromJson(response.body).cars ?? [];
        }
      } else {
        setState(() {
          carStatus = 2;
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

  void getNewCars() async {
    setState(() {
      newCarsStatus = 0;
    });

    http.Response response =
        await HttpMethods().getMethod(ApiGetUrl.getNewestCars, {});
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        newCarsStatus = 1;
      });
      print(jsonDecode(response.body));
      print('dddddddddddddddddddddddddddd');
      if ((response.body ?? "").isNotEmpty) {
        if (jsonDecode(response.body)['cars'].isEmpty) {
          newCars = [];
        } else {
          newCars = carResponseEntityFromJson(response.body).cars ?? [];
        }
      } else {
        setState(() {
          newCarsStatus = 2;
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

  void getBrands() async {
    setState(() {
      status = 0;
    });

    http.Response response =
        await HttpMethods().getMethod(ApiGetUrl.getBrands, {});
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        status = 1;
      });

      getCarsByBrand();

      if ((response.body ?? "").isNotEmpty) {
        brands = jsonDecode(response.body);
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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteNamedScreens.main,
              (route) => false,
            );
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppWidthManager.w3Point8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        onTap: () {
                          if (AppSharedPreferences.getAuthType() == "0") return;
                          Navigator.of(context)
                              .pushNamed(RouteNamedScreens.profile);
                        },
                        child: MainImageWidget(
                          imagePath: AppImageManager.main,
                          height: AppHeightManager.h8,
                          width: AppHeightManager.h8,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: AppSharedPreferences.getAuthType() == "0",
                    child: SizedBox(
                      height: AppHeightManager.h4,
                    ),
                  ),
                  Visibility(
                    visible: AppSharedPreferences.getAuthType() == "0",
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
                    height: AppHeightManager.h4,
                  ),
                  const HomeBanners(),
                  SizedBox(
                    height: AppHeightManager.h5,
                  ),
                  SizedBox(
                    height: AppHeightManager.h7,
                    child: Visibility(
                      visible: status == 1,
                      replacement: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedBrandIndex = index;
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: AppWidthManager.w1),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: selectedBrandIndex == index
                                        ? AppColorManager.navy
                                        : AppColorManager.white,
                                    border:
                                        Border.all(color: AppColorManager.navy),
                                    borderRadius: BorderRadius.circular(
                                        AppRadiusManager.r10)),
                                height: AppHeightManager.h7,
                                width: AppHeightManager.h7,
                                child: ShimmerContainer(
                                  height: AppHeightManager.h7,
                                  width: AppHeightManager.h7,
                                )),
                          );
                        },
                      ),
                      child: ListView.builder(
                        itemCount: brands.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedBrandIndex = index;
                                selectedBrand = brands[index];
                                getCarsByBrand();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: AppWidthManager.w1),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: selectedBrandIndex == index
                                      ? AppColorManager.navy
                                      : AppColorManager.white,
                                  border:
                                      Border.all(color: AppColorManager.navy),
                                  borderRadius: BorderRadius.circular(
                                      AppRadiusManager.r10)),
                              height: AppHeightManager.h7,
                              width: AppHeightManager.h7,
                              child: AppTextWidget(
                                text: "${brands[index]['name']}",
                                color: selectedBrandIndex == index
                                    ? AppColorManager.white
                                    : AppColorManager.navy,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppHeightManager.h3,
                  ),
                  Visibility(
                    visible: carStatus == 1,
                    replacement: Container(
                        height: AppHeightManager.h10,
                        alignment: Alignment.center,
                        child: AppCircularProgressWidget()),
                    child: Visibility(
                      visible: cars.isNotEmpty,
                      replacement: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: AppHeightManager.h5),
                          height: AppHeightManager.h7,
                          child: AppTextWidget(
                            text: "no cars for this brand",
                            color: Colors.white,
                            fontSize: FontSizeManager.fs16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      child: DynamicHeightGridView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          builder: (context, index) {
                            return CarCard(
                              car: cars[index],
                            );
                          },
                          itemCount: cars.length,
                          crossAxisCount: 2),
                    ),
                  ),
                  SizedBox(
                    height: AppHeightManager.h4,
                  ),
                  const HomeBanners(),
                  SizedBox(
                    height: AppHeightManager.h5,
                  ),
                  AppTextWidget(
                    text: "New Cars",
                    color: AppColorManager.white,
                    fontSize: FontSizeManager.fs17,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: AppHeightManager.h1point8,
                  ),
                  Visibility(
                    visible: newCarsStatus == 1,
                    replacement: const SizedBox(),
                    child: SizedBox(
                      height: AppHeightManager.h39,
                      child: newCars.isEmpty
                          ? Text("")
                          : ListView.builder(
                              itemCount: newCars.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppWidthManager.w1),
                                  child: CarCard(
                                    car: newCars[index],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
