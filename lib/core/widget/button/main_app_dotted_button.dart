import 'package:dotted_button/dotted_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:car_connect/core/resource/color_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';

class MainAppDottedButton extends StatelessWidget {
  final Function()? onTap;
  final Color? color;
  final double? height;
  final double? width;
  final Widget? child;
  final Color? dotColor;
  const MainAppDottedButton({super.key, this.onTap,this.color,this.height,this.width,this.child,this.dotColor});

  @override
  Widget build(BuildContext context) {
    return  DottedButton(
      dashColor:dotColor?? AppColorManager.teal,
      borderRadius: AppRadiusManager.r16,
      strokeWidth: 3,
      dashPattern: const [
        6,9
      ],
      onTap: onTap,
      height:height?? AppHeightManager.h6,
      width:width?? AppWidthManager.w100,
      borderType: BorderType.RRect,
      color: color?? AppColorManager.white,
      child: child ?? const SizedBox(),
    );
  }
}
