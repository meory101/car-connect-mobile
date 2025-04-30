import 'dart:convert';
import 'dart:io';

import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/core/widget/app_bar/main_app_bar.dart';
import 'package:car_connect/core/widget/drop_down/NameAndId.dart';
import 'package:car_connect/core/widget/drop_down/title_drop_down_form_field.dart';
import 'package:car_connect/core/widget/form_field/title_app_form_filed.dart';
import 'package:car_connect/core/widget/image/main_image_widget.dart';
import 'package:car_connect/feature/auth/screen/personal_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/helper/image_helper.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/button/main_app_dotted_button.dart';
import '../../../core/widget/text/app_text_widget.dart';
import 'package:http/http.dart' as http;

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  var brands = [];
  List<NameAndId> brandsOptions = [];
  var gears = [];
  List<NameAndId> gearsOptions = [];

  var color = [];
  List<NameAndId> colorOptions = [];

  var model = [];
  List<NameAndId> modelOptions = [];

  String? brandId;
  String? colorId;
  String? modelId;
  String? gearId;
  String? desc;

  String? kilo;

  String? price;

  File? image;
  File? owner;

  addCar() async {
    if (brandId == null ||
        gearId == null ||
        modelId == null ||
        colorId == null ||
        desc == null ||
        price == null ||
        kilo == null ||
        image == null ||
        (AppSharedPreferences.getCommercialRegister().isEmpty &&
            owner == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColorManager.white,
          content: AppTextWidget(
            text: "Enter All Required Fields",
            color: AppColorManager.red,
            fontSize: FontSizeManager.fs16,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        ),
      );
      return;
    }

    List<File> files = [
      image!,
    ];
    List<String> names = [
      "image0",
    ];
    if (owner != null) {
      files.add(owner!);
      names.add("ownerShipImageUrl");
    }
    Map<String, dynamic> requestEntity = {
      "id": AppSharedPreferences.getUserId(),
      "brandId": brandId.toString(),
      "modelId": modelId.toString(),
      "gearId": gearId.toString(),
      "colorId": colorId.toString(),
      "killo": kilo.toString(),
      "price": price.toString(),
      "desc": desc.toString(),
    };

    http.Response response = await HttpMethods()
        .postWithMultiFile(ApiPostUrl.addCar, requestEntity, files, names);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: "success",
              color: AppColorManager.green,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: utf8.decode(response.bodyBytes),
              color: AppColorManager.navy,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
        );
      }
    }
  }

  void getBrands() async {
    http.Response response =
        await HttpMethods().getMethod(ApiGetUrl.getBrands, {});
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        brands = jsonDecode(response.body);
        if (brands.isNotEmpty) {
          brands.forEach(
            (element) {
              brandsOptions.add(NameAndId(
                  name: element['name'], id: element['id'].toString()));
            },
          );
          setState(() {});
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: utf8.decode(response.bodyBytes),
              color: AppColorManager.navy,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
        );
      }
    }
  }

  void getGears() async {
    http.Response response =
        await HttpMethods().getMethod(ApiGetUrl.getGears, {});
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        gears = jsonDecode(response.body);
        if (gears.isNotEmpty) {
          gears.forEach(
            (element) {
              gearsOptions.add(NameAndId(
                  name: element['name'], id: element['id'].toString()));
            },
          );
          setState(() {});
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: utf8.decode(response.bodyBytes),
              color: AppColorManager.navy,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
        );
      }
    }
  }

  void getColors() async {
    http.Response response =
        await HttpMethods().getMethod(ApiGetUrl.getColors, {});
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        color = jsonDecode(response.body);
        if (color.isNotEmpty) {
          color.forEach(
            (element) {
              colorOptions.add(NameAndId(
                  name: element['name'], id: element['id'].toString()));
            },
          );
          setState(() {});
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: utf8.decode(response.bodyBytes),
              color: AppColorManager.navy,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
        );
      }
    }
  }

  void getModels() async {
    http.Response response =
        await HttpMethods().getMethod(ApiGetUrl.getModels, {});
    if (response.statusCode == 200 || response.statusCode == 201) {
      if ((response.body ?? "").isNotEmpty) {
        model = jsonDecode(response.body);
        model = jsonDecode(response.body);
        if (model.isNotEmpty) {
          model.forEach(
            (element) {
              modelOptions.add(NameAndId(
                  name: element['name'], id: element['id'].toString()));
            },
          );
          setState(() {});
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColorManager.white,
            content: AppTextWidget(
              text: utf8.decode(response.bodyBytes),
              color: AppColorManager.navy,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    getBrands();
    getColors();
    getModels();
    getGears();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "add car"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppWidthManager.w3Point8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TitleDropDownFormFieldWidget(
                        hint: "Brand",
                        title: "Brand",
                        onChanged: (value) {
                          brandId = value?.id;
                          return null;
                        },
                        options: brandsOptions),
                  ),
                  SizedBox(
                    width: AppHeightManager.h1point8,
                  ),
                  Expanded(
                    child: TitleDropDownFormFieldWidget(
                        hint: "Gear",
                        title: "Gear",
                        onChanged: (value) {
                          gearId = value?.id;

                          return null;
                        },
                        options: gearsOptions),
                  ),
                ],
              ),
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TitleDropDownFormFieldWidget(
                        hint: "Color",
                        title: "Color",
                        onChanged: (value) {
                          colorId = value?.id;

                          return null;
                        },
                        options: colorOptions),
                  ),
                  SizedBox(
                    width: AppHeightManager.h1point8,
                  ),
                  Expanded(
                    child: TitleDropDownFormFieldWidget(
                        hint: "Model",
                        title: "Model",
                        onChanged: (value) {
                          modelId = value?.id;

                          return null;
                        },
                        options: modelOptions),
                  ),
                ],
              ),
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              TitleAppFormFiled(
                hint: "desc",
                title: "desc",
                onChanged: (value) {
                  desc = value;
                  return null;
                },
                validator: (p0) {
                  return null;
                },
              ),
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TitleAppFormFiled(
                      hint: "kilometers",
                      title: "kilometers",
                      inputType: TextInputType.number,
                      onChanged: (value) {
                        kilo = value;

                        return null;
                      },
                      validator: (p0) {
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: AppHeightManager.h1point8,
                  ),
                  Expanded(
                    child: TitleAppFormFiled(
                      hint: "price",
                      inputType: TextInputType.number,
                      title: "price",
                      onChanged: (value) {
                        price = value;

                        return null;
                      },
                      validator: (p0) {
                        return null;
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              MainAppDottedButton(
                onTap: () async {
                  image = await ImageHelper.pickImageFrom(
                      source: ImageSource.gallery);
                },
                color: AppColorManager.navy.withAlpha(50),
                child: AppTextWidget(
                  text: "Car Image(Required)",
                  color: AppColorManager.white,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizeManager.fs15,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              Visibility(
                visible: AppSharedPreferences.getCommercialRegister().isEmpty,
                child: MainAppDottedButton(
                  onTap: () async {
                    owner = await ImageHelper.pickImageFrom(
                        source: ImageSource.gallery);
                  },
                  color: AppColorManager.navy.withAlpha(50),
                  child: AppTextWidget(
                    text: "OwnerShip Image(Required)",
                    color: AppColorManager.white,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSizeManager.fs15,
                    maxLines: 2,
                  ),
                ),
              ),
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              MainAppButton(
                onTap: () {
                  addCar();
                },
                alignment: Alignment.center,
                width: AppWidthManager.w100,
                color: AppColorManager.navy,
                height: AppHeightManager.h6,
                child: AppTextWidget(
                  text: "Next",
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
