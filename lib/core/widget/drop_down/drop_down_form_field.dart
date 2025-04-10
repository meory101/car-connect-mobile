import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:car_connect/core/resource/color_manager.dart';
import 'package:car_connect/core/resource/font_manager.dart';
import 'package:car_connect/core/resource/icon_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/widget/drop_down/NameAndId.dart';
import 'package:car_connect/core/widget/text/app_text_widget.dart';

class DropDownFormFieldWidget extends StatefulWidget {
  const DropDownFormFieldWidget({
    Key? key,
    required this.options,
    required this.hint,
    this.hintFontColor,
    this.hintFontSize,
    this.hintFontWeight,
    this.reset,
    this.validator,
    this.iconColor,
    this.width,
    this.iconSize,
    this.borderColor,
    this.value,
    this.onChanged,
  }) : super(key: key);

  final List<NameAndId> options;
  final String hint;
  final bool? reset;
  final Color? hintFontColor;
  final FontWeight? hintFontWeight;
  final double? hintFontSize;
  final NameAndId? value;
  final Color? borderColor;
  final double? width;
  final double? iconSize;
  final Color? iconColor;
  final String? Function(NameAndId?)? validator;
  final Function(NameAndId?)? onChanged;

  @override
  State<DropDownFormFieldWidget> createState() => _DropDownFormFieldWidgetState();
}

class _DropDownFormFieldWidgetState extends State<DropDownFormFieldWidget> {
  NameAndId? nameAndIdObject;

  @override
  void didUpdateWidget(covariant DropDownFormFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.options != widget.options) {
      setState(() {
        nameAndIdObject = null;
        nameAndIdObject = widget.value;
      });
    }
  }

  GlobalKey<FormFieldState> dropDownKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        DropdownButtonFormField<NameAndId>(
          validator: widget.validator,

          icon: const SizedBox(),
          decoration: InputDecoration(
            errorStyle: TextStyle(
                fontSize: FontSizeManager.fs14
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(19.0),
              child: SizedBox(
                height: AppHeightManager.h1,
                width: AppHeightManager.h1,
                child: SvgPicture.asset(AppIconManager.arrowMenuDown),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadiusManager.r10),
              borderSide: const BorderSide(color: AppColorManager.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadiusManager.r10),
              borderSide: const BorderSide(color: AppColorManager.grey),
            ),
          ),
          borderRadius: BorderRadius.circular(AppRadiusManager.r10),
          key: dropDownKey,
          isExpanded: true,
          style: TextStyle(
            fontWeight: widget.hintFontWeight ?? FontWeight.w400,
            fontFamily: FontFamilyManager.cairo,
            color: AppColorManager.textAppColor,
            fontSize: FontSizeManager.fs16,
          ),
          menuMaxHeight: AppHeightManager.h30,

          items: widget.options
              .map((option) => DropdownMenuItem<NameAndId>(
            value: option,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: AppTextWidget(
                color: AppColorManager.black,
                text: option.name,
                fontSize: FontSizeManager.fs15,
              ),
            ),
          ))
              .toList(),
          hint: AppTextWidget(
            text: widget.hint,
            fontSize: widget.hintFontSize ?? FontSizeManager.fs15,
            overflow: TextOverflow.ellipsis,

            color: widget.hintFontColor ?? AppColorManager.grey,
          ),
          onChanged: (value) {
            setState(() {
              nameAndIdObject = value;
            });
            widget.onChanged!(value);
          },
        ),
      ],
    );
  }
}