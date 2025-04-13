// import 'dart:convert';
//
// import 'package:car_connect/core/api/api_links.dart';
// import 'package:car_connect/core/widget/container/shimmer_container.dart';
// import 'package:car_connect/core/widget/loading/app_circular_progress_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
// import 'package:flutter/material.dart';
// import '../../../core/api/api_methods.dart';
// import '../../../core/resource/color_manager.dart';
// import '../../../core/resource/font_manager.dart';
// import '../../../core/resource/image_manager.dart';
// import '../../../core/resource/size_manager.dart';
// import '../../../core/widget/image/main_image_widget.dart';
// import '../../../core/widget/text/app_text_widget.dart';
// import '../model/Brand.dart';
// import '../widget/car_card.dart';
// import 'package:http/http.dart' as http;
// var selectedBrand ;
// class BrandListView extends StatefulWidget {
//   const BrandListView({super.key});
//
//   @override
//   State<BrandListView> createState() => _BrandListViewState();
// }
//
// class _BrandListViewState extends State<BrandListView> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: AppHeightManager.h7,
//       child: Visibility(
//         visible: status == 1,
//         replacement: ListView.builder(
//           itemCount: 10,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () {
//                 setState(() {
//                   selectedBrandIndex = index;
//                 });
//               },
//               child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: AppWidthManager.w1),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: selectedBrandIndex == index
//                           ? AppColorManager.navy
//                           : AppColorManager.white,
//                       border: Border.all(color: AppColorManager.navy),
//                       borderRadius:
//                           BorderRadius.circular(AppRadiusManager.r10)),
//                   height: AppHeightManager.h7,
//                   width: AppHeightManager.h7,
//                   child: ShimmerContainer(
//                     height: AppHeightManager.h7,
//                     width: AppHeightManager.h7,
//                   )),
//             );
//           },
//         ),
//         child: ListView.builder(
//           itemCount: brands.length,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () {
//                 setState(() {
//                   selectedBrandIndex = index;
//                   selectedBrand = brands[index];
//                 });
//               },
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: AppWidthManager.w1),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                     color: selectedBrandIndex == index
//                         ? AppColorManager.navy
//                         : AppColorManager.white,
//                     border: Border.all(color: AppColorManager.navy),
//                     borderRadius: BorderRadius.circular(AppRadiusManager.r10)),
//                 height: AppHeightManager.h7,
//                 width: AppHeightManager.h7,
//                 child: AppTextWidget(
//                   text: "${brands[index]['name']}",
//                   color: selectedBrandIndex == index
//                       ? AppColorManager.white
//                       : AppColorManager.navy,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
