import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';
import 'package:jaylog/common/constant/constant.dart';
import 'package:jaylog/main.dart';

class UtilFunction {
  static Future<bool> confirm({
    required BuildContext context,
    required String content,
  }) async {
    bool result = false;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  result = true;
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                },
                child: Text("확인"),
              ),
              TextButton(
                onPressed: () {
                  result = false;
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                },
                child: Text("취소"),
              ),
            ],
          ),
        );
      },
    );
    return result;
  }

  static void alert({
    required BuildContext context,
    required String content,
    VoidCallback? callback,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                  if (callback != null) {
                    callback();
                  }
                },
                child: Text("확인"),
              ),
            ],
          ),
        );
      },
    );
  }

  static ImageProvider getImageProviderByImageUrl(String? imageUrl) {
    if (imageUrl == null) {
      return const NetworkImage(Constant.defaultProfileImage);
    }
    if (imageUrl.startsWith("data:")) {
      return MemoryImage(base64Decode(imageUrl.split(",").last));
    }
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

  static Future<File> resizeXfileImageTo20x20(XFile? xfile) async {
    if (xfile == null) {
      throw Exception("이미지를 불러오는데 실패했습니다.");
    }
    final imageBytes = await xfile.readAsBytes();
    final image = imageLib.decodeImage(imageBytes);
    if (image == null) {
      throw Exception("이미지를 불러오는데 실패했습니다.");
    }
    final resizedImage = imageLib.copyResize(image, width: 20, height: 20);
    List<int> pngBytes = imageLib.encodePng(resizedImage);
    final resizedImageFile = File('${Directory.systemTemp.path}/cropped_image.png');
    await resizedImageFile.writeAsBytes(pngBytes);
    return resizedImageFile;
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
    final resizedImageFile = File('${Directory.systemTemp.path}/cropped_image${DateTime.timestamp()}.png');
    await resizedImageFile.writeAsBytes(pngBytes);
    return resizedImageFile;
  }

  static FutureOr<Null> handleDefaultError(error, stackTrace, {BuildContext? context}) {
    print(error);
    print(stackTrace);
    if (error is DioException && error.response?.data != null) {
      print(error.response?.data);
      alert(
        context: context ?? navigatorKey.currentContext!,
        content: error.response?.data["message"] ?? "예상치 못한 에러가 발생했습니다.\n관리자에게 문의하세요.",
      );
    } else {
      alert(
        context: context ?? navigatorKey.currentContext!,
        content: "예상치 못한 에러가 발생했습니다.\n관리자에게 문의하세요.\n$error",
      );
    }
  }
}
