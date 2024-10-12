import 'package:flutter/material.dart';
import 'package:jaylog/util/util_function.dart';

class CircleProfileImage extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const CircleProfileImage(
      {super.key, required this.imageUrl, this.radius = 12.0});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: UtilFunction.getImageProviderByImageUrl(imageUrl),
      backgroundColor: Colors.transparent,
    );
  }
}
