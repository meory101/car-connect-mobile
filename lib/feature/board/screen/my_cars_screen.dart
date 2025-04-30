import 'dart:convert';

import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/core/widget/loading/app_circular_progress_widget.dart';
import 'package:car_connect/feature/car/model/car_response_entity.dart';
import 'package:car_connect/feature/home/widget/car_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/app_bar/main_app_bar.dart';
import 'package:http/http.dart' as http;

import '../../../core/widget/text/app_text_widget.dart';

class MyCarsScreen extends StatefulWidget {
  const MyCarsScreen({super.key});

  @override
  State<MyCarsScreen> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<MyCarsScreen> {
  CarResponseEntity? entity;

  void getMyCars() async {
    http.Response response = await HttpMethods().postMethod(
        ApiGetUrl.getCarsByBusinessUserId,
        {"userId": AppSharedPreferences.getUserId()});
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        entity = carResponseEntityFromJson(response.body);

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
    getMyCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(title: "My cars"),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppWidthManager.w3Point8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: entity != null,
                  replacement: Padding(
                    padding: EdgeInsets.only(top: AppHeightManager.h20),
                    child: const Center(child: AppCircularProgressWidget()),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: entity?.cars?.length ?? 0,
                    itemBuilder: (context, index) {
                      return CarCard(car: entity?.cars?[index]);
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
