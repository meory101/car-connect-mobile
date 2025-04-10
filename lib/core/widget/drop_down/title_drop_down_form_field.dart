import 'package:flutter/cupertino.dart';
import 'package:car_connect/core/resource/color_manager.dart';
import 'package:car_connect/core/resource/font_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/widget/drop_down/NameAndId.dart';
import 'package:car_connect/core/widget/drop_down/drop_down_form_field.dart';
import 'package:car_connect/core/widget/text/app_text_widget.dart';

class TitleDropDownFormFieldWidget extends StatelessWidget {
  final String title, hint;
  final List<NameAndId> options;
  final String? Function(NameAndId?)? validator;
  final String? Function(NameAndId?)? onChanged;
  final Color? hintColor;
  final NameAndId? value;

  const TitleDropDownFormFieldWidget(
      {super.key,
      this.hintColor,
      required this.hint,
        this.value,
      required this.title,
      required this.onChanged,
      this.validator,
      required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          text: title,
          fontSize: FontSizeManager.fs16,
          maxLines: 3,
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.w600,
          color: AppColorManager.textAppColor,
        ),
        SizedBox(
          height: AppHeightManager.h1,
        ),
        DropDownFormFieldWidget(
          value:value??null,
          hintFontColor: hintColor,
          options: options,
          hint: hint,
          validator: validator,
          onChanged: onChanged,
        )
      ],
    );
  }
}
