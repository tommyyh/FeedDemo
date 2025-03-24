import 'package:feed_demo/models/post_model.dart';
import 'package:feed_demo/providers/post/post_provider.dart';
import 'package:feed_demo/widgets/post/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostModel post;

  const PostDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Go back')),
      body: Post(post: post, index: 0, noRedirect: true),
    );
  }
}
