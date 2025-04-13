import 'package:car_connect/feature/car/screens/cars_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:car_connect/core/resource/color_manager.dart';
import 'package:car_connect/core/resource/icon_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/widget/text/app_text_widget.dart';

import '../../home/screen/home_screen.dart';


class MainAppBottomAppBar extends StatefulWidget {

  const MainAppBottomAppBar({super.key,});

  @override
  State<MainAppBottomAppBar> createState() => _MainAppBottomAppBarState();
}

class _MainAppBottomAppBarState extends State<MainAppBottomAppBar> {
  final List<Widget> bottomBarScreens = [
    const HomeScreen(),
    const CarsScreen(),
    const HomeScreen(),
    // const HomeScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: BottomAppBarIndex.index == 0,
      onPopInvoked: (didPop) {
        if (didPop == false) {
          setState(() {
            BottomAppBarIndex.index = 0;
          });
        } else {
          FlutterExitApp();
        }
      },
      child: Scaffold(
          bottomNavigationBar: Container(
            height: AppHeightManager.h10,
            margin: EdgeInsets.all(AppWidthManager.w3Point8),
            padding: EdgeInsets.all(
              AppWidthManager.w3Point8,
            ),
            decoration: BoxDecoration(
              // color: AppColorManager.,
              border: Border(top: BorderSide(color: AppColorManager.white)),
              borderRadius: BorderRadius.circular(AppRadiusManager.r20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  overlayColor: const MaterialStatePropertyAll(
                      AppColorManager.transparent),
                  onTap: () {
                    setState(() {
                      BottomAppBarIndex.index = 0;

                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(AppIconManager.home,
                          colorFilter: ColorFilter.mode(
                              BottomAppBarIndex.index == 0
                                  ? AppColorManager.navy
                                  : AppColorManager.grey,
                              BlendMode.srcIn)),
                      AppTextWidget(
                        text:"Home",
                        color: BottomAppBarIndex.index == 0
                            ? AppColorManager.navy
                            : AppColorManager.grey,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  overlayColor: const MaterialStatePropertyAll(
                      AppColorManager.transparent),
                  onTap: () {
                    setState(() {
                      BottomAppBarIndex.index = 1;

                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(AppIconManager.car,
                          colorFilter: ColorFilter.mode(
                              BottomAppBarIndex.index == 1
                                  ? AppColorManager.navy
                                  : AppColorManager.grey,
                              BlendMode.srcIn)),
                      AppTextWidget(
                        text: "Cars",
                        color: BottomAppBarIndex.index == 1
                            ? AppColorManager.navy
                            : AppColorManager.grey,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  overlayColor: const MaterialStatePropertyAll(
                      AppColorManager.transparent),
                  onTap: () {
                    setState(() {
                      BottomAppBarIndex.index = 2;

                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(AppIconManager.board,
                          colorFilter: ColorFilter.mode(
                              BottomAppBarIndex.index == 2
                                  ? AppColorManager.navy
                                  : AppColorManager.grey,
                              BlendMode.srcIn)),
                      AppTextWidget(
                        text: "Board",
                        color: BottomAppBarIndex.index == 2
                            ? AppColorManager.navy
                            : AppColorManager.grey,
                      ),
                    ],
                  ),
                ),
                // InkWell(
                //   overlayColor: const MaterialStatePropertyAll(
                //       AppColorManager.transparent),
                //   onTap: () {
                //     setState(() {
                //       BottomAppBarIndex.index = 3;
                //
                //     });
                //   },
                //   child: Column(
                //     children: [
                //       SvgPicture.asset(AppIconManager.more,
                //           colorFilter: ColorFilter.mode(
                //               BottomAppBarIndex.index == 3
                //
                //                   ? AppColorManager.navy
                //                   : AppColorManager.grey,
                //               BlendMode.srcIn)),
                //       AppTextWidget(
                //         text: "more",
                //         color: BottomAppBarIndex.index == 3
                //             ? AppColorManager.navy
                //             : AppColorManager.grey,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: bottomBarScreens[BottomAppBarIndex.index],
          )),
    );
  }
}

abstract class  BottomAppBarIndex {
  static int index=0;
  BottomAppBarIndex({required int index});
}
