
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const ProfileImage({super.key, required this.imageUrl, this.radius = 12.0});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(imageUrl),
      backgroundColor: Colors.transparent,
    );
  }
}