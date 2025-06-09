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
import 'package:url_launcher/url_launcher.dart';

class BusinessReservationsScreen extends StatefulWidget {
  const BusinessReservationsScreen({super.key});

  @override
  State<BusinessReservationsScreen> createState() =>
      _BusinessReservationsScreenState();
}

class _BusinessReservationsScreenState
    extends State<BusinessReservationsScreen> {
  List<dynamic> reservations = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    getBusinessReservations();
  }

  Future<void> getBusinessReservations() async {
    try {
      final userId = AppSharedPreferences.getUserId();
      final response = await HttpMethods().postMethod(
        ApiPostUrl.getBusinessUserReservations,
        {"id": userId},
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          reservations = data['reservations'] ?? [];
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

  Future<void> _launchPhoneDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'Business Reservations'),
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
                        final phoneNumber =
                            reservation['user']['phone'] ?? 'N/A';
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
                                Row(
                                  children: [
                                    AppTextWidget(
                                      text: 'Customer Phone: $phoneNumber',
                                      color: AppColorManager.white,
                                      fontSize: FontSizeManager.fs14,
                                    ),
                                    if (phoneNumber != 'N/A')
                                      IconButton(
                                        icon: const Icon(
                                          Icons.call,
                                          color: Colors.green,
                                        ),
                                        onPressed: () =>
                                            _launchPhoneDialer(phoneNumber),
                                      ),
                                  ],
                                ),
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
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
