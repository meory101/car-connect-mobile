import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/feature/home/widget/home_banners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/image_manager.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../widget/car_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBrandIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                          text: "welcome",
                          color: AppColorManager.navy,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSizeManager.fs16,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    MainImageWidget(
                      imagePath: AppImageManager.main,
                      height: AppHeightManager.h8,
                      width: AppHeightManager.h8,
                      fit: BoxFit.cover,
                    ),
                  ],
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
                  child: ListView.builder(
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
                              border: Border.all(color: AppColorManager.navy),
                              borderRadius:
                                  BorderRadius.circular(AppRadiusManager.r10)),
                          height: AppHeightManager.h7,
                          width: AppHeightManager.h7,
                          child: AppTextWidget(
                            text: "BMW",
                            color: selectedBrandIndex == index
                                ? AppColorManager.white
                                : AppColorManager.navy,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppHeightManager.h3,
                ),
                DynamicHeightGridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    builder: (context, index) {
                      return const CarCard();
                    },
                    itemCount: 4,
                    crossAxisCount: 2),
                SizedBox(
                  height: AppHeightManager.h4,
                ),
                const HomeBanners(),
                SizedBox(
                  height: AppHeightManager.h5,
                ),

                AppTextWidget(text: "New Cars",
                color: AppColorManager.white,
                  fontSize: FontSizeManager.fs17,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: AppHeightManager.h1point8,),
                SizedBox(
                  height: AppHeightManager.h40,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppWidthManager.w1),
                        child: CarCard(),
                      );
                    },
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
