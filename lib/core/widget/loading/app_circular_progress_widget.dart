// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:car_connect/core/resource/color_manager.dart';

class AppCircularProgressWidget extends StatelessWidget {
  final Color? color;
  const AppCircularProgressWidget({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CircularProgressIndicator(color: color??AppColorManager.teal,);
  }
}
