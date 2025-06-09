import 'dart:convert';

import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/core/widget/app_bar/main_app_bar.dart';
import 'package:car_connect/core/widget/loading/app_circular_progress_widget.dart';
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
  CarResponseEntity? entity;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    getMyFavorites();
  }

  Future<void> getMyFavorites() async {
    try {
      final response = await HttpMethods().postMethod(
        ApiPostUrl.getUserFavorites,
        {'userId': "${AppSharedPreferences.getUserId()}"}
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if ((response.body).isNotEmpty) {
          setState(() {
            entity = carResponseEntityFromJson(response.body);
            isLoading = false;
          });
        }
      } else {
        setState(() {
          error = utf8.decode(response.bodyBytes);
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error loading favorites: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: "My Favorites"),
      body: isLoading 
        ? const Center(child: AppCircularProgressWidget())
        : error != null
          ? Center(
              child: AppTextWidget(
                text: error!,
                color: AppColorManager.red,
                fontSize: FontSizeManager.fs16,
              ),
            )
          : entity?.cars == null || entity!.cars!.isEmpty
            ? Center(
                child: AppTextWidget(
                  text: 'No favorites found',
                  color: AppColorManager.white,
                  fontSize: FontSizeManager.fs16,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: entity?.cars?.length ?? 0,
                itemBuilder: (context, index) {
                  return CarCard(car: entity?.cars?[index]);
                },
              ),
    );
  }
}
