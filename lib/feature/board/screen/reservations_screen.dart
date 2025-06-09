import 'dart:convert';

import 'package:car_connect/core/api/api_links.dart';
import 'package:car_connect/core/api/api_methods.dart';
import 'package:car_connect/core/resource/color_manager.dart';
import 'package:car_connect/core/resource/font_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/core/widget/app_bar/main_app_bar.dart';
import 'package:car_connect/core/widget/loading/app_circular_progress_widget.dart';
import 'package:car_connect/core/widget/text/app_text_widget.dart';
import 'package:flutter/material.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  List<dynamic> reservations = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    getReservations();
  }

  Future<void> getReservations() async {
    try {
      final userId = AppSharedPreferences.getUserId();
      final response = await HttpMethods().getMethod(
        ApiGetUrl.getMyReservationUrl(userId),
        {},
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          reservations = data;
        });
      } else {
        setState(() {
          error = 'Failed to load reservations';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        error = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'My Reservations'),
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
              : reservations.isEmpty
                  ? Center(
                      child: AppTextWidget(
                        text: 'No reservations found',
                        color: AppColorManager.white,
                        fontSize: FontSizeManager.fs16,
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(AppWidthManager.w3Point8),
                      itemCount: reservations.length,
                      itemBuilder: (context, index) {
                        final reservation = reservations[index];
                        return Card(
                          color: AppColorManager.navy.withOpacity(0.3),
                          margin: EdgeInsets.only(bottom: AppHeightManager.h2),
                          child: Padding(
                            padding: EdgeInsets.all(AppWidthManager.w3Point8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTextWidget(
                                      text:
                                          'Car: ${reservation['car']['desc'] ?? 'N/A'}',
                                      color: AppColorManager.white,
                                      fontSize: FontSizeManager.fs16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    AppTextWidget(
                                      text: '\$${reservation['total'] ?? '0'}',
                                      color: AppColorManager.white,
                                      fontSize: FontSizeManager.fs16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppHeightManager.h1),
                                AppTextWidget(
                                  text:
                                      'From: ${reservation['startDate'] ?? 'N/A'}',
                                  color: AppColorManager.white,
                                  fontSize: FontSizeManager.fs14,
                                ),
                                AppTextWidget(
                                  text:
                                      'To: ${reservation['endDate'] ?? 'N/A'}',
                                  color: AppColorManager.white,
                                  fontSize: FontSizeManager.fs14,
                                ),
                                if (reservation['status'] != null)
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: AppHeightManager.h1),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppWidthManager.w2,
                                      vertical: AppHeightManager.h1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: reservation['status'] == 'approved'
                                          ? AppColorManager.green
                                          : reservation['status'] == 'pending'
                                              ? AppColorManager.navy
                                              : AppColorManager.red,
                                      borderRadius: BorderRadius.circular(
                                          AppRadiusManager.r5),
                                    ),
                                    child: AppTextWidget(
                                      text: reservation['status']
                                          .toString()
                                          .toUpperCase(),
                                      color: AppColorManager.white,
                                      fontSize: FontSizeManager.fs12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
