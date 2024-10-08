
import 'package:flutter/material.dart';

class CircleProfileImage extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const CircleProfileImage({super.key, required this.imageUrl, this.radius = 12.0});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imageUrl.startsWith("http") ? NetworkImage(imageUrl) : AssetImage(imageUrl) as ImageProvider,
      backgroundColor: Colors.transparent,
    );
  }
}