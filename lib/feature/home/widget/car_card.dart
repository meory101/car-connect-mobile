import 'package:car_connect/core/resource/image_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/image/main_image_widget.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/container/decorated_container.dart';
import '../../../core/widget/text/app_text_widget.dart';

class CarCard extends StatefulWidget {
  var car;
   CarCard({
    super.key,
    required this.car
  });

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  int selectedColorIndex = -1;

  @override
  Widget build(BuildContext context) {
    return widget.car==null ?SizedBox(): InkWell(
      overlayColor: WidgetStatePropertyAll(AppColorManager.transparent),
      onTap: () {},
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
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: AppHeightManager.h20,
              width: AppWidthManager.w45,
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
                imageUrl:

                widget.car['images'].isEmpty?"d": widget.car['images'][0]['imageUrl'],
                // imagePath: AppPixelManager,
              ),
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
                    text:widget.car['car']['available'] ==1 ? "Available": "Not Available",
                    fontSize: FontSizeManager.fs16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: AppHeightManager.h1,
                  ),
                  AppTextWidget(
                    text: "${widget.car['car']['desc']}",
                    fontSize: FontSizeManager.fs15,
                    fontWeight: FontWeight.w400,
                    color: AppColorManager.textGrey,
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
                        text: "${widget.car['car']['price']}\$",
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
