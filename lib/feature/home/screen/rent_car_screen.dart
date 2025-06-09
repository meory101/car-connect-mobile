import 'package:car_connect/core/api/api_links.dart';
import 'package:car_connect/core/api/api_methods.dart';
import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/core/widget/bottom_sheet/wheel_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/image_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/app_bar/main_app_bar.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';
import 'cart_screen.dart';

class RentCarScreen extends StatefulWidget {
  final CartArgs args;

  const RentCarScreen({super.key, required this.args});

  @override
  State<RentCarScreen> createState() => _RentCarScreenState();
}

class _RentCarScreenState extends State<RentCarScreen> {
  DateTime? startDate;
  DateTime? endDate;
  bool isLoading = false;
  final DateFormat dateFormatter = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'Select date';
    return dateFormatter.format(date);
  }

  void makeReservation() async {
    if (startDate == null || endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColorManager.white,
          content: AppTextWidget(
            text: "Please select start and end dates",
            color: AppColorManager.navy,
            fontSize: FontSizeManager.fs16,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        ),
      );
      return;
    }

    if (startDate!.isAfter(endDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColorManager.white,
          content: AppTextWidget(
            text: "Start date cannot be after end date",
            color: AppColorManager.navy,
            fontSize: FontSizeManager.fs16,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final requestBody = {
        "userId": AppSharedPreferences.getUserId(),
        "carId": widget.args.carId?.id.toString(),
        "startDate": formatDate(startDate),
        "endDate": formatDate(endDate),
        "total": calculateTotalPrice().toString(),
      };

      print('Request body: $requestBody'); // Debug print

      http.Response response = await HttpMethods().postMethod(
        ApiPostUrl.addReservation,
        requestBody,
      );

      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200 || response.statusCode==201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: "Reservation successful",
              color: AppColorManager.navy,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
        );
        Navigator.of(context).pop();
      } else if (response.statusCode == 409) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: "This car is already reserved for these dates",
              color: AppColorManager.navy,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: "Failed to make reservation. Please try again.",
              color: AppColorManager.navy,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
        );
      }
    } catch (e) {
      print('Exception during API call: $e'); // Debug print
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColorManager.white,
          content: AppTextWidget(
            text: "An error occurred. Please try again.",
            color: AppColorManager.navy,
            fontSize: FontSizeManager.fs16,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        ),
      );
    }
  }

  int calculateTotalPrice() {
    if (startDate == null || endDate == null) return 0;
    final days = endDate!.difference(startDate!).inDays + 1;
    return days * (int.tryParse(widget.args.carId?.price ?? "0") ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppWidthManager.w3Point8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: AppHeightManager.h10,
                      width: AppHeightManager.h10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppRadiusManager.r15))),
                      child: MainImageWidget(
                        height: AppHeightManager.h10,
                        width: AppHeightManager.h10,
                        imagePath: AppImageManager.placeholder,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppWidthManager.w1Point8,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: widget.args.carId?.desc ?? "",
                          color: Colors.white,
                          fontSize: FontSizeManager.fs16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppTextWidget(
                              text: "${widget.args.carId?.price} \$ per day",
                              fontSize: FontSizeManager.fs18,
                              fontWeight: FontWeight.w600,
                              color: AppColorManager.white,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: AppHeightManager.h6,
              ),
              SizedBox(
                height: AppHeightManager.h3,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: "From date",
                          fontSize: FontSizeManager.fs16,
                          fontWeight: FontWeight.w500,
                          color: AppColorManager.white,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: AppHeightManager.h2,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: AppHeightManager.h3),
                          width: AppWidthManager.w100,
                          height: AppHeightManager.h7,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: AppColorManager.white,
                              borderRadius:
                                  BorderRadius.circular(AppRadiusManager.r15),
                              border: Border.all(color: AppColorManager.white)),
                          child: MainAppButton(
                            padding: const EdgeInsets.all(9),
                            onTap: () {
                              showWheelDatePicker(
                                context: context,
                                onDateSelected: (date) {
                                  print('sssssssssssssssss');
                                  setState(() {
                                    startDate = date;
                                  });
                                },
                              );
                            },
                            child: AppTextWidget(
                              text: formatDate(startDate),
                              fontSize: FontSizeManager.fs16,
                              fontWeight: FontWeight.w500,
                              color: AppColorManager.textGrey,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: AppWidthManager.w3Point8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: "To date",
                          fontSize: FontSizeManager.fs16,
                          fontWeight: FontWeight.w500,
                          color: AppColorManager.white,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: AppHeightManager.h2,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: AppHeightManager.h3),
                          width: AppWidthManager.w100,
                          height: AppHeightManager.h7,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: AppColorManager.white,
                              borderRadius:
                                  BorderRadius.circular(AppRadiusManager.r15),
                              border: Border.all(color: AppColorManager.white)),
                          child: MainAppButton(
                            padding: const EdgeInsets.all(9),
                            onTap: () {
                              showWheelDatePicker(
                                context: context,
                                onDateSelected: (date) {
                                  setState(() {
                                    endDate = date;
                                  });
                                },
                              );
                            },
                            child: AppTextWidget(
                              text: formatDate(endDate),
                              fontSize: FontSizeManager.fs16,
                              fontWeight: FontWeight.w500,
                              color: AppColorManager.textGrey,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppHeightManager.h3,
              ),
              if (startDate != null && endDate != null)
                Container(
                  margin: EdgeInsets.only(bottom: AppHeightManager.h3),
                  width: AppWidthManager.w100,
                  height: AppHeightManager.h7,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColorManager.navy,
                    borderRadius: BorderRadius.circular(AppRadiusManager.r15),
                  ),
                  child: AppTextWidget(
                    text: "Total: \$${calculateTotalPrice()}",
                    fontSize: FontSizeManager.fs18,
                    fontWeight: FontWeight.w600,
                    color: AppColorManager.white,
                  ),
                ),
              Container(
                margin: EdgeInsets.only(bottom: AppHeightManager.h3),
                width: AppWidthManager.w100,
                height: AppHeightManager.h7,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColorManager.background,
                    borderRadius: BorderRadius.circular(AppRadiusManager.r15),
                    border: Border.all(color: AppColorManager.white)),
                child: MainAppButton(
                  onTap: isLoading ? null : makeReservation,
                  color: AppColorManager.background,
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: AppColorManager.white,
                            strokeWidth: 2,
                          ),
                        )
                      : AppTextWidget(
                          text: "Rent Now",
                          fontSize: FontSizeManager.fs16,
                          fontWeight: FontWeight.w500,
                          color: AppColorManager.white,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
