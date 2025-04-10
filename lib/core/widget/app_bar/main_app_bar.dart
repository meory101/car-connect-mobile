import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:car_connect/core/helper/language_helper.dart';
import 'package:car_connect/core/resource/icon_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../text/app_text_widget.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, required this.title,this.actions,this.customHeight});

  final String title;
  final List<Widget>? actions;
  final double? customHeight;

  @override
  Size get preferredSize => Size.fromHeight(customHeight??AppHeightManager.h9);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColorManager.white,
      automaticallyImplyLeading: false,
      title:
      Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              LanguageHelper.checkIfLTR(context: context)
                  ? AppIconManager.arrowLeft
                  : AppIconManager.arrowRight,
              colorFilter:
                  const ColorFilter.mode(AppColorManager.navy, BlendMode.srcIn),
            ),
          ),
          SizedBox(
            width: AppWidthManager.w2,
          ),
          AppTextWidget(
            text: title,
            fontSize: FontSizeManager.fs18,
            color: AppColorManager.navy,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: actions??[],
      elevation: 0,
    );
  }
}
