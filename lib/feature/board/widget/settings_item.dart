import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/resource/font_manager.dart';
import '../../../../core/resource/size_manager.dart';
import '../../../../core/widget/container/decorated_container.dart';
import '../../../../core/widget/text/app_text_widget.dart';
import '../../../core/resource/color_manager.dart';



class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      required this.onTap,
      required this.title,
      required this.icon,
        this.fontSize,
      this.isDeleteItem = false});
  final String title;
  final String icon;
  final Function() onTap;
  final bool isDeleteItem;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(AppColorManager.transparent),

      onTap: onTap,
      child:
      DecoratedContainer(
        borderRadius: BorderRadius.circular(AppRadiusManager.r15),
        padding: EdgeInsets.all(AppWidthManager.w5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                   AppColorManager.navy,
                  BlendMode.srcIn),
            ),
            SizedBox(
              width: AppWidthManager.w2,
            ),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: AppTextWidget(
                      text: title,
                      fontSize:fontSize?? FontSizeManager.fs16,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                      color:
                           AppColorManager.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
