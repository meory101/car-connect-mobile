import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_connect/core/helper/url_launcher_helper.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';


abstract class FileHelper {
  static Future<File?> getFile({List<String>? allowedExtensions}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: allowedExtensions,
      type: allowedExtensions != null ? FileType.custom : FileType.any,

    );
    if (result != null) {
      final file = File(result.files.single.path!);
      return file;
    }
    return null;
  }

  static String convertToBase64({required File? file}) {
    if(file==null) return"";
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  static String getFileName({required File file}) {
    return path.basename(file.path);
  }

  static String getFileExtension({required String fileName}) {
    return path.extension(fileName).replaceAll('.', '');
  }

  static void downloadFile({
    required String url,
    Function(double)? onProgress,
    required BuildContext context,
  }) {
    if (url.isEmpty) return;
    //TODO FIX THIS
    UrlLauncherHelper.openUrl(pageName: url);
    // FileDownloader.downloadFile(
    //     url: url,
    //     onDownloadCompleted: (String path) {
    //       NoteMessage.showSuccessSnackBar(
    //           context: context, text: "fileDownloadedSuccessfully");
    //     },
    //     onDownloadError: (String error) {
    //       NoteMessage.showErrorSnackBar(
    //           context: context, text: "canNotDownloadFile");
    //     });
  }


// static  Future<void> _pickVideo() async {
//     final picker = ImagePicker();
//     XFile? videoFile = await picker.pickVideo(source: ImageSource.camera);
//     if (videoFile != null) {
//       setState(() {
//         _videoPath = videoFile.path;
//         _imageBase64 = null;
//         _errorText = null;
//       });
//       widget.onMediaPicked(null, _videoPath);
//     }
//   }


  static String addHeaderToBase64(
      {required String base64Data, required String extension}) {
    String base64Header = 'data:image/$extension;base64,';
    return base64Header + base64Data;
  }
}
