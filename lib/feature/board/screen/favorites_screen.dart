import 'dart:convert';

import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/core/widget/app_bar/main_app_bar.dart';
import 'package:car_connect/core/widget/loading/app_circular_progress_widget.dart';
import 'package:car_connect/feature/car/model/car_response_entity.dart';
import 'package:car_connect/feature/home/widget/car_card.dart';
import 'package:flutter/material.dart';

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
    if (!mounted) return;

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final userId = AppSharedPreferences.getUserId();
      if (userId.isEmpty) {
        setState(() {
          error = 'User ID not found';
          isLoading = false;
        });
        return;
      }

      final response = await HttpMethods()
          .postMethod(ApiPostUrl.getUserFavorites, {'userId': userId});

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          if (response.body.isNotEmpty) {
            final decodedResponse = json.decode(response.body);
            if (decodedResponse != null) {
              setState(() {
                entity = carResponseEntityFromJson(response.body);
                isLoading = false;
              });
            } else {
              setState(() {
                error = 'Invalid response format';
                isLoading = false;
              });
            }
          } else {
            setState(() {
              entity = CarResponseEntity(cars: []);
              isLoading = false;
            });
          }
        } catch (e) {
          setState(() {
            error = 'Failed to parse response: $e';
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
      if (!mounted) return;
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppTextWidget(
                          text: error!,
                          color: AppColorManager.red,
                          fontSize: FontSizeManager.fs16,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: getMyFavorites,
                          child: AppTextWidget(
                            text: "Try Again",
                            color: AppColorManager.white,
                            fontSize: FontSizeManager.fs16,
                          ),
                        ),
                      ],
                    ),
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
                        final car = entity?.cars?[index];
                        if (car == null) return const SizedBox.shrink();
                        return CarCard(car: car);
                      },
                    ),
    );
  }
}
