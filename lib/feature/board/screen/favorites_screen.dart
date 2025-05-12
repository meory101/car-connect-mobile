
import 'dart:convert';

import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/core/widget/app_bar/main_app_bar.dart';
import 'package:car_connect/feature/board/model/order_response_entity.dart';
import 'package:car_connect/feature/car/model/car_response_entity.dart';
import 'package:car_connect/feature/home/widget/car_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/widget/text/app_text_widget.dart';
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  @override
  void initState() {
    getMyFavorites();
    super.initState();
  }
  CarResponseEntity? entity;
  void getMyFavorites() async {
    print(AppSharedPreferences.getUserId());
    http.Response response = await HttpMethods()
        .postMethod(ApiPostUrl.getUserFavorites, {
          'userId'  :"${AppSharedPreferences.getUserId()}"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        print(response.body);

      if ((response.body ?? "").isNotEmpty) {

        entity = carResponseEntityFromJson(response.body);
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
      appBar: const MainAppBar(title: "my favorites"),
      body: ListView.builder(
        itemCount: entity?.cars?.length,
        itemBuilder: (context, index) {
          return CarCard(car: entity?.cars?[index]);
        },
      ),
    );
  }
}
