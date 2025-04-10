import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:car_connect/core/resource/color_manager.dart';
import 'package:image_picker/image_picker.dart';

///
abstract class ImageHelper{

 static String convertBase46Encoder({required File image}) {
   List<int> imageBytes = image.readAsBytesSync() ?? [];
   return base64Encode(imageBytes);
 }

 static Image convertBase46Decoder({required String image}) {
   return Image.memory(const Base64Decoder().convert(image));
 }

 static Future<File?> pickVideoFrom({required ImageSource source}) async {
   try {
     final video = await ImagePicker().pickVideo(
       source: ImageSource.camera,
       // maxDuration: const Duration(seconds: 60),
     );

     if (video == null) {
       return null;
     }

     return File(video.path);
   } catch (error) {
     return null;
   }
 }


 static Future<File?> pickImageFrom({required ImageSource source}) async {
   File? tempImage;

   try {
     final photo = await ImagePicker().pickImage(
       source: source,
       maxHeight: 512,
        maxWidth: 512,
       imageQuality: 75,
     );

     if (photo == null) {
       return null;
     }

     tempImage = File(photo.path);

     // tempImage = await _cropImage(imageFile: tempImage);
   } catch (error) {
     return null;
   }

   return tempImage;
 }

}
