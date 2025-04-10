import 'package:car_connect/core/resource/icon_manager.dart';
import 'package:car_connect/core/widget/image/main_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../../core/resource/image_manager.dart';

class HomeBanners extends StatefulWidget {
  const HomeBanners({
    super.key,
  });

  @override
  State<HomeBanners> createState() => _HomeBannersState();
}

class _HomeBannersState extends State<HomeBanners> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  selectedIndex = index;
                });
              },
              aspectRatio: AppWidthManager.w92 / AppHeightManager.h20,
              enableInfiniteScroll: true,
              autoPlay: true,
              viewportFraction: 0.8,
              enlargeCenterPage: true,

            ),
            items: List.generate(
              2,
              (index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                      width: AppWidthManager.w92,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r10)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: MainImageWidget(
                        fit: BoxFit.cover,
                        imagePath: index == 0
                            ? AppImageManager.car2
                            : AppImageManager.car1,
                      )),
                );
              },
            ),
          ),
          SizedBox(
            height: AppHeightManager.h1point8,
          ),
          DotsIndicator(
            dotsCount: 2,
            position: selectedIndex,
            decorator: DotsDecorator(
              spacing: EdgeInsets.only(
                  left: AppWidthManager.w1Point8,
                  right: AppWidthManager.w1Point8),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppRadiusManager.r10,
                ),
              ),
              activeSize: Size(
                AppWidthManager.w6,
                AppHeightManager.h08,
              ),
              size: Size(
                AppWidthManager.w1Point5,
                AppWidthManager.w1Point5,
              ),
              activeColor: AppColorManager.navy,
              color: AppColorManager.greyWithOpacity6,
            ),
          ),
        ],
      ),
    );
  }
}
