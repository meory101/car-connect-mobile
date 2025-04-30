import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import '../widget/snack_bar/note_message.dart';

class LocationHelper {
  static Future<Position?> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      NoteMessage.showErrorSnackBar(
          context: context,
          text: "open location"
      );
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        NoteMessage.showErrorSnackBar(
            context: context,
            text: "تم رفض إذن الوصول للموقع"
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      NoteMessage.showErrorSnackBar(
          context: context,
          text: "يجب تفعيل إذن الموقع من إعدادات الجهاز"
      );
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }
}