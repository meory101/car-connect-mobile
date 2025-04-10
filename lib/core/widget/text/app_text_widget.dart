import 'package:flutter/material.dart';
import 'package:car_connect/core/resource/key_manger.dart';
import 'package:car_connect/core/storage/shared/shared_pref.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';

class AppTextWidget extends StatefulWidget {
  final String text;
  final double? fontSize;
  final double? height;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? color;
  final Color? decorationColor;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;

  const AppTextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.height,
    this.fontWeight,
    this.fontStyle,
    this.color = AppColorManager.textAppColor,
    this.decorationColor,
    this.textDecoration,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.padding,
    this.onTap,
  });

  @override
  State<AppTextWidget> createState() => _AppTextWidgetState();
}

class _AppTextWidgetState extends State<AppTextWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: Text(
          widget.text,
          maxLines: widget.maxLines,
          overflow: widget.overflow ?? TextOverflow.ellipsis,
          softWrap: widget.softWrap,
          textAlign: widget.textAlign,
          textDirection: widget.textDirection,
          style: TextStyle(
            fontFamily: AppSharedPreferences.getLanguage() ==
                    AppKeyManager.kuLocalizationCode
                ? FontFamilyManager.cascadiaMono
                : FontFamilyManager.cairo,
            letterSpacing: -0.4,
            fontSize: AppSharedPreferences.getLanguage() ==
                        AppKeyManager.kuLocalizationCode &&
                    widget.fontSize == FontSizeManager.fs16
                ? FontSizeManager.fs15
                : widget.fontSize ?? FontSizeManager.fs14,
            fontWeight: widget.fontWeight,
            color: widget.color,
            decoration: widget.textDecoration,
            decorationColor: widget.decorationColor,
            height: widget.height,
          ),
        ),
      ),
    );
  }
}
