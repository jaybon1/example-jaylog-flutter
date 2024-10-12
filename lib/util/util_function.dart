import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';

class UtilFunction {

  static ImageProvider getImageProviderByImageUrl(String imageUrl) {
    if (imageUrl.startsWith("http")) {
      return NetworkImage(imageUrl);
    }
    if (imageUrl.startsWith("asset")) {
      return AssetImage(imageUrl) as ImageProvider;
    }
    if (imageUrl.startsWith("/")) {
      return FileImage(File(imageUrl));
    }
    throw Exception("Invalid imageUrl");
  }

  static Future<File> resizeXfileImageTo50x50(XFile? xfile) async {
    if (xfile == null) {
      throw Exception("이미지를 불러오는데 실패했습니다.");
    }
    final imageBytes = await xfile.readAsBytes();
    final image = imageLib.decodeImage(imageBytes);
    if (image == null) {
      throw Exception("이미지를 불러오는데 실패했습니다.");
    }
    final resizedImage = imageLib.copyResize(image, width: 50, height: 50);
    List<int> pngBytes = imageLib.encodePng(resizedImage);
    final resizedImageFile = File(
        '${Directory.systemTemp.path}/cropped_image${DateTime.timestamp()}.png');
    await resizedImageFile.writeAsBytes(pngBytes);
    return resizedImageFile;
  }

  static FutureOr<Null> handleDefaultError(error, stackTrace) {
    if (error is DioException && error.response?.data != null) {
      print(error.response?.data["message"]);
    } else {
      print("예상치 못한 에러가 발생했습니다.\n관리자에게 문의하세요.\n$error");
    }
  }
}
