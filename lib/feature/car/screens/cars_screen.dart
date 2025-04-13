import 'dart:convert';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/image_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/loading/app_circular_progress_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';
import 'package:http/http.dart' as http;

import '../../home/widget/car_card.dart';
import '../model/car_response_entity.dart';
class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
int status=-1;

CarResponseEntity? cars;
  void getCars() async {
    setState(() {
      status = 0;
    });

    http.Response response = await HttpMethods().getMethod(
        ApiGetUrl.getCars, {});
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        status = 1;
      });

      if ((response.body ?? "").isNotEmpty) {
        print(jsonDecode(response.body));
        print('dddddddddddddddddddddddddd');
        cars = carResponseEntityFromJson(response.body);
        print(cars?.cars?.length);
        print('dddddddddddddddddd');
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
    getCars();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   SafeArea(
        child: RefreshIndicator(
          onRefresh: () async{
            getCars();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
        
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                            text: "Latest cars",
                            color: AppColorManager.white,
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
                  Visibility(
                    visible: status == 1,
                    replacement: Container(
                        height: AppHeightManager.h10,
                        alignment: Alignment.center,
                        child: AppCircularProgressWidget()),
                    child: Visibility(
                      visible: (cars?.cars??[]).isNotEmpty,
                      replacement: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: AppHeightManager.h5),
                          height: AppHeightManager.h7,
                          child: AppTextWidget(
                            text: "No Cars",
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
                              car: cars?.cars?[index],
                            );
                          },
                          itemCount: cars?.cars?.length ??0,
                          crossAxisCount: 2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
        ,
    );
  }
}
