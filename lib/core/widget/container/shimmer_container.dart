import 'package:flutter/cupertino.dart';
import 'package:car_connect/core/resource/color_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double height;
  final double width;
  final BoxShape? boxShape;
  final double? radius;

  const ShimmerContainer(
      {super.key,
      required this.width,
      required this.height,
      this.boxShape,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return boxShape == null
        ? Shimmer.fromColors(
            baseColor: AppColorManager.shimmerBaseColor,
            highlightColor: AppColorManager.shimmerHighlightColor,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: AppColorManager.shimmerHighlightColor,
                borderRadius: BorderRadius.circular(
                  radius ?? AppRadiusManager.r10,
                ),
              ),
            ))
        : Shimmer.fromColors(
            baseColor: AppColorManager.shimmerBaseColor,
            highlightColor: AppColorManager.shimmerHighlightColor,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: AppColorManager.shimmerHighlightColor,
                  shape: boxShape ?? BoxShape.rectangle),
            ));
  }
}
