import 'package:flutter/material.dart';

class PostUser extends StatelessWidget {
  final String username;
  final String status;

  const PostUser({super.key, required this.username, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Username
        Text(
          username,
          style: TextStyle(fontSize: 14.75, fontWeight: FontWeight.w700),
        ),

        // Status
        Text(
          ' · $status',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
      ],
    );
  }
}
