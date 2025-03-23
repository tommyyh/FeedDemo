import 'package:feed_demo/models/post_model.dart';
import 'package:feed_demo/widgets/post/post_content.dart';
import 'package:feed_demo/widgets/post/post_header/post_header.dart';
import 'package:feed_demo/widgets/post/post_media/post_media.dart';
import 'package:feed_demo/widgets/test.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final PostModel post;
  final int index;

  const Post({super.key, required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post end divider
          Divider(
            height: 1,
            color: index != 0 ? Colors.grey[300] : Colors.transparent,
          ),
          SizedBox(height: 13),

          // Post details header
          PostHeader(post: post),

          // Post media files
          PostMedia(media: post.media),
          SizedBox(height: 12),

          // Post content
          PostContent(post: post),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
