import 'package:car_connect/feature/home/screen/car_details_screen.dart';
import 'package:car_connect/router/router.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/image/main_image_widget.dart';
import '../../../core/api/api_links.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/container/decorated_container.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../../car/model/car_response_entity.dart';

class CarCard extends StatefulWidget {
  Cars? car;

  CarCard({super.key, required this.car});

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  int selectedColorIndex = -1;

  @override
  Widget build(BuildContext context) {
    return widget.car == null
        ? const SizedBox()
        : InkWell(
            overlayColor:
                const WidgetStatePropertyAll(AppColorManager.transparent),
            onTap: () {
              Navigator.of(context).pushNamed(RouteNamedScreens.carDetails,
                  arguments: CarDetailsArgs(
                      id: (widget.car?.car?.id ?? "").toString()));
            },
            child: DecoratedContainer(
              padding: EdgeInsets.only(
                bottom: AppHeightManager.h2,
              ),
              margin: EdgeInsets.only(bottom: AppHeightManager.h2),
              color: AppColorManager.dotGrey,
              borderRadius: BorderRadius.circular(AppRadiusManager.r15),
              width: AppWidthManager.w44,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: AppHeightManager.h20,
                        width: AppWidthManager.w100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              AppRadiusManager.r15,
                            ),
                            topRight: Radius.circular(
                              AppRadiusManager.r15,
                            ),
                          ),
                        ),
                        child: MainImageWidget(
                            width: AppWidthManager.w44,
                            height: AppHeightManager.h27,
                            fit: BoxFit.cover,
                            imageUrl: (widget.car?.images ?? []).isEmpty
                                ? "d"
                                : (imageUrl) +
                                    (widget.car?.images?.first.imageUrl ?? "")
                            // imagePath: AppPixelManager,
                            ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: widget.car?.car?.rent == 1
                                ? AppColorManager.navy
                                : AppColorManager.background,
                            borderRadius:
                                BorderRadius.circular(AppRadiusManager.r15),
                          ),
                          child: AppTextWidget(
                            text: widget.car?.car?.rent == 1
                                ? "For Rent"
                                : "For Sale",
                            fontSize: FontSizeManager.fs14,
                            fontWeight: FontWeight.w600,
                            color: AppColorManager.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppHeightManager.h06,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: "${widget.car?.car?.desc}",
                          fontSize: FontSizeManager.fs16,
                          fontWeight: FontWeight.w400,
                          color: AppColorManager.black,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: AppHeightManager.h1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppTextWidget(
                              text: "${widget.car?.car?.price}\$",
                              fontSize: FontSizeManager.fs16,
                              fontWeight: FontWeight.w700,
                              color: AppColorManager.navy,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
