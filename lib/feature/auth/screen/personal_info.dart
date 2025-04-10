import 'package:car_connect/core/helper/image_helper.dart';
import 'package:car_connect/core/widget/button/main_app_dotted_button.dart';
import 'package:car_connect/core/widget/form_field/title_app_form_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/form_field/app_form_field.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../../../router/router.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppWidthManager.w3Point8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: AppHeightManager.h20),
              AppTextWidget(
                text: "Additional Info",
                color: AppColorManager.white,
                fontWeight: FontWeight.w600,
                fontSize: FontSizeManager.fs24,
              ),
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              AppTextWidget(
                text: "please add required into to continue to your account",
                color: AppColorManager.white,
                fontWeight: FontWeight.w600,
                fontSize: FontSizeManager.fs16,
                maxLines: 2,
              ),
              SizedBox(
                height: AppHeightManager.h4,
              ),
              Visibility(
                  visible: true,
                  child: Column(
                    children: [
                      TitleAppFormFiled(
                        title: "name",
                        hint: "name",
                        onChanged: (p0) {},
                        validator: (p0) {},
                      ),
                      TitleAppFormFiled(
                        title: "desc",
                        hint: "desc",
                        onChanged: (p0) {},
                        validator: (p0) {},
                      ),
                      TitleAppFormFiled(
                        title: "location",
                        hint: "location",
                        onChanged: (p0) {},
                        validator: (p0) {},
                      ),
                      SizedBox(
                        height: AppHeightManager.h1point8,
                      ),
                      MainAppDottedButton(
                        onTap: () {
                          ImageHelper.pickImageFrom(source: ImageSource.gallery);
                        },
                        color: AppColorManager.navy.withAlpha(50),
                        child: AppTextWidget(
                          text: "Commercial Register",
                          color: AppColorManager.white,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSizeManager.fs15,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(
                        height: AppHeightManager.h1point8,
                      ),
                    ],
                  )),
              MainAppDottedButton(
                color: AppColorManager.navy.withAlpha(50),
                child: AppTextWidget(
                  onTap: () {
                    ImageHelper.pickImageFrom(source: ImageSource.gallery);
                  },
                  text: "Id Image",
                  color: AppColorManager.white,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizeManager.fs15,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: AppHeightManager.h4,
              ),
              MainAppButton(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNamedScreens.home);
                },
                alignment: Alignment.center,
                width: AppWidthManager.w100,
                color: AppColorManager.navy,
                height: AppHeightManager.h6,
                child: AppTextWidget(
                  text: "Save",
                  color: AppColorManager.white,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizeManager.fs15,
                  maxLines: 2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
