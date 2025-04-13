import 'dart:convert';
import 'dart:io';

import 'package:car_connect/core/helper/image_helper.dart';
import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/core/widget/button/main_app_dotted_button.dart';
import 'package:car_connect/core/widget/form_field/title_app_form_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/helper/location_helper.dart';
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
  File? imageId;
  File? commercialRegister;
  GlobalKey<FormState> formKey = GlobalKey();
  String? name;
  String? lat;
  String? long;
  String? desc;
  TextEditingController locationController = TextEditingController();

  void onSave() async {
    List<File> files = [];
    List<String> names = [];
    if (UserAuthType.type == "0") {
      if (imageId == null) {
        SnackBar(
          backgroundColor: AppColorManager.white,
          content: AppTextWidget(
            text: "enter all fields",
            color: AppColorManager.navy,
            fontSize: FontSizeManager.fs16,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        );
        return;
      } else {
        files.add(imageId!);
        names.add("idImageUrl");
      }
    } else {
      if (!formKey.currentState!.validate() ||
          imageId == null ||
          lat == null ||
          long == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: "enter all fields",
              color: AppColorManager.navy,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
        );
        return;
      }
    }
    Map requestEntity = {"id": UserAuthType.id};

    if (UserAuthType.type == "1") {
      requestEntity['name'] = name;
      requestEntity['desc'] = desc;
      requestEntity['lat'] = lat;
      requestEntity['long'] = long;
      files.add(imageId!);
      names.add("idImageUrl");
      if(commercialRegister!=null){
        files.add(commercialRegister!);
        names.add("commercialRegisterImageUrl");
      }

    }

    http.Response response = await HttpMethods().postWithMultiFile(
        UserAuthType.type == "1"
            ? ApiPostUrl.addBusinessUserProfileInfo
            : ApiPostUrl.uploadUserIdImage,
        requestEntity,
        files,
        names);
    if (response.statusCode == 200 || response.statusCode == 201) {
      AppSharedPreferences.cashUserId(userId: UserAuthType.id ?? "");
      AppSharedPreferences.cashAuthType(authType: UserAuthType.type ?? "");
      AppSharedPreferences.cashUserNameEn(userName: name ?? "");

      Navigator.of(context).pushNamed(RouteNamedScreens.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColorManager.white,
          content: AppTextWidget(
            text: "something went wrong",
            color: AppColorManager.navy,
            fontSize: FontSizeManager.fs16,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppWidthManager.w3Point8),
          child: Form(
            key: formKey,
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
                    visible: UserAuthType.type == "1",
                    child: Column(
                      children: [
                        TitleAppFormFiled(
                          title: "name",
                          hint: "name",
                          onChanged: (p0) {
                            setState(() {
                              name = p0;
                            });
                          },
                          validator: (p0) {
                            if ((p0 ?? "").isEmpty) {
                              return "required";
                            }
                            return null;
                          },
                        ),
                        TitleAppFormFiled(
                          title: "desc",
                          hint: "desc",
                          onChanged: (p0) {
                            setState(() {
                              desc = p0;
                            });
                          },
                          validator: (p0) {
                            if ((p0 ?? "").isEmpty) {
                              return "required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: AppHeightManager.h1point8,
                        ),
                        SizedBox(
                          width: AppWidthManager.w100,
                          child: AppTextFormField(
                            readOnly: true,
                            controller: locationController,
                            // fillColor: AppColorManager.lightGreyOpacity6,
                            maxLines: 1,
                            hintText: "location",
                            onChanged: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "required";
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.my_location,
                                color: AppColorManager.navy,
                              ),
                              onPressed: () async {
                                Position? position =
                                    await LocationHelper.getCurrentLocation(
                                        context);
                                if (position != null) {
                                  locationController.text =
                                      'Lat: ${position.latitude}, Long: ${position.longitude}';
                                  lat = position.latitude.toString();
                                  long = position.longitude.toString();
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppHeightManager.h1point8,
                        ),
                        AppTextWidget(
                          maxLines: 3,
                            color: AppColorManager.red,
                            fontSize: FontSizeManager.fs15,
                            text:
                                "commercial register image is optional if you are not a company and want to add car for sell you have to provide ownership image"),

                        SizedBox(
                          height: AppHeightManager.h1point8,
                        ),
                        MainAppDottedButton(
                          onTap: () async {
                            commercialRegister =
                                await ImageHelper.pickImageFrom(
                                    source: ImageSource.gallery);
                          },
                          color: AppColorManager.navy.withAlpha(50),
                          child: AppTextWidget(
                            text: "Commercial Register(optional)",
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
                    onTap: () async {
                      print('ddddddddd');
                      imageId = await ImageHelper.pickImageFrom(
                          source: ImageSource.gallery);
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
                    onSave();
                    // Navigator.of(context).pushNamed(RouteNamedScreens.home);
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
      ),
    );
  }
}

abstract class UserAuthType {
  static String? type;
  static String? id;
}
