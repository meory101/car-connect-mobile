import 'package:flutter/cupertino.dart';
import 'package:car_connect/core/helper/date_time_helper.dart';
import 'package:car_connect/core/widget/form_field/title_app_form_filed.dart';
import '../../../core/widget/bottom_sheet/wheel_date_picker.dart';

///
/// created by eng nour othman ***
/// at 1/2/2024
///
///

class CalendarFormField extends StatefulWidget {
  final String? title;
  DateTime? initialDateTime;
  DateTime? minimumDate;
  DateTime? maximumDate;
  final String? Function(String?)? validator;
  final dynamic Function(DateTime)? onDateSelected;

  CalendarFormField(
      {super.key,
      this.title,
      required this.onDateSelected,
      this.icon,
      this.validator,
      this.maximumDate,
      this.minimumDate,
      this.initialDateTime});

  final String? icon;

  @override
  State<CalendarFormField> createState() => _CalendarFormFieldState();
}

class _CalendarFormFieldState extends State<CalendarFormField> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return TitleAppFormFiled(
      readOnly: true,
      onIconTaped: () {
        showWheelDatePicker(
            context: context,
            initialDateTime: widget.initialDateTime,
            minimumDate: widget.minimumDate,
            maximumDate: widget.maximumDate,
            onDateSelected: (date) {
              if (date != selectedDate) {
                setState(() {
                  selectedDate = date;
                });
                widget.onDateSelected?.call(date);
              }
            });
      },
      onTap: () {
        showWheelDatePicker(
            context: context,
            initialDateTime: widget.initialDateTime,
            minimumDate: widget.minimumDate,
            maximumDate: widget.maximumDate,
            onDateSelected: (date) {
              if (date != selectedDate) {
                setState(() {
                  selectedDate = date;
                });
                widget.onDateSelected?.call(date);
              }
            });
      },
      initValue: DateTimeHelper.formatDateWithDash(
          date: selectedDate ?? widget.initialDateTime),
      // suffixIcon: widget.icon ?? .calendar,
      hint: widget.title ?? "",
      title: widget.title ?? "",
      onChanged: (value) {
        return null;
      },
      validator: widget.validator ??
          (p0) {
            return null;
          },
    );
  }
}
