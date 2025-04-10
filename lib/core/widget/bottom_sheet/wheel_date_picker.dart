import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_connect/core/resource/color_manager.dart';
import 'package:car_connect/core/resource/font_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/widget/button/main_app_button.dart';
import 'package:car_connect/core/widget/text/app_text_widget.dart';

void showWheelDatePicker(
    {required BuildContext context,
        DateTime? initialDateTime,
        DateTime? minimumDate,
        DateTime? maximumDate,
      required Function(DateTime) onDateSelected}) {
  DateTime selectedDate = DateTime.now();
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColorManager.white,
    builder: (BuildContext builder) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadiusManager.r10),
          color: AppColorManager.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              height: AppHeightManager.h30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                color: AppColorManager.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w5),
                child: CupertinoDatePicker(

                  initialDateTime:maximumDate?? DateTime.now(),
                  onDateTimeChanged: (DateTime? pickedDate) {
                    if (pickedDate != null) {
                      selectedDate = pickedDate;
                    }
                  },
                  itemExtent: AppHeightManager.h5,
                  mode: CupertinoDatePickerMode.date,
                  minimumDate:minimumDate,
                  maximumDate: maximumDate,
                  use24hFormat: true,
                ),
              ),
            ),
            SizedBox(
              height: AppHeightManager.h2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainAppButton(
                  width: MediaQuery.of(context).size.width / 2.6,
                  borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                  height: AppHeightManager.h5,
                  onTap: () {
                    // String formattedDate = DateFormat('yyyy-MM-dd', 'en_US')
                    //     .format(selectedDate);
                    // DateTime finalDate =
                    // DateTime.parse(formattedDate);
                    // onDateSelected(finalDate);
                    Navigator.of(context).pop();

                  },
                  color: AppColorManager.navy,
                  alignment: Alignment.center,
                  child: AppTextWidget(
                    text: "save",
                    fontSize: FontSizeManager.fs16,
                    color: AppColorManager.white,
                  ),
                ),
                SizedBox(
                  width: AppWidthManager.w2,
                ),
                MainAppButton(
                  width: MediaQuery.of(context).size.width / 2.6,
                  borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                  height: AppHeightManager.h5,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  color: AppColorManager.white,
                  alignment: Alignment.center,
                  child: AppTextWidget(
                    text: "cancel",
                    fontSize: FontSizeManager.fs16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppHeightManager.h2,
            ),
          ],
        ),
      );
    },
  );
}






