import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double height;
  final String image;

  const UserAvatar({super.key, required this.height, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Image.asset(image, height: height),
    );
  }
}
