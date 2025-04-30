import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:car_connect/core/resource/color_manager.dart';
import 'package:car_connect/core/resource/font_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/widget/text/app_text_widget.dart';
import 'app_form_field.dart';

class TitleAppFormFiled extends StatelessWidget {
  const TitleAppFormFiled(
      {super.key,
      required this.hint,
      required this.title,
      required this.onChanged,
      required this.validator,
      this.initValue,this.focusNode,
      this.style,
      this.suffixIcon,
      this.onIconTaped,
      this.maxLines,
      this.minLines,
      this.isRequired,
        this.paddingValue,
        this.inputType,
      this.readOnly,
        this.obscureText,

        this.controller,
      this.titleColor,
      this.multiLines});

  final String title, hint;
  final String? Function(String?) onChanged;
  final String? Function(String?) validator;
  final String? suffixIcon, initValue;
  final bool? readOnly;
  final bool? multiLines;
  final TextStyle? style;
  final Function()? onIconTaped;
  final bool? isRequired;
  final int? maxLines;
  final int? minLines;
  final double? paddingValue;
  final Color? titleColor;
  final FocusNode? focusNode;
  final TextInputType?  inputType;
  final TextEditingController? controller;
    final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          text: title,
          fontSize: FontSizeManager.fs16,
          fontWeight: FontWeight.w600,
          color: titleColor ?? AppColorManager.white,
        ),
        SizedBox(
          height: paddingValue?? AppHeightManager.h05,
        ),
        SizedBox(
          child: AppTextFormField(
            obscureText: obscureText ,
            controller: controller,
            focusNode: focusNode ,
            style: style,
            readOnly: readOnly,
            suffixIcon: suffixIcon != null && onIconTaped != null
                ? SizedBox(
                    height: AppWidthManager.w02,
                    width: AppWidthManager.w02,
                    child: InkWell(
                      onTap: onIconTaped ,
                      child: Padding(
                        padding: EdgeInsets.all(AppWidthManager.w3Point8),
                        child: SvgPicture.asset(
                          suffixIcon ?? "",
                          // colorFilter: ,
                        ),
                      ),
                    ),
                  )
                : null,
            initialValue: initValue,
            minLines:obscureText ==true?1 : multiLines == true ? minLines ?? 5 : 1,
            maxLines:obscureText ==true?1 :  maxLines,
            validator: validator,
            onChanged: onChanged,
            textInputAction: TextInputAction.next,
            hintText: hint,
            textInputType:inputType?? TextInputType.text,
          ),
        ),
      ],
    );
  }
}
