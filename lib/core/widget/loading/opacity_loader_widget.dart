import 'package:flutter/widgets.dart';
import 'package:car_connect/core/resource/color_manager.dart';

import 'app_circular_progress_widget.dart';

class OpacityLoaderWidget extends StatelessWidget {
  const OpacityLoaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        color: AppColorManager.background,
        child: const Center(
          child: AppCircularProgressWidget(),
        ),
      ),
    );
  }
}
