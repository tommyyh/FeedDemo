import 'package:feed_demo/models/post_model.dart';
import 'package:feed_demo/screens/post_details/post_details_screen.dart';
import 'package:feed_demo/widgets/post/post_content.dart';
import 'package:feed_demo/widgets/post/post_header/post_header.dart';
import 'package:feed_demo/widgets/post/post_media/post_media.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final PostModel post;
  final int index;
  final bool noRedirect;
  final LayerLink? layerLink;

  const Post({
    super.key,
    required this.post,
    required this.index,
    this.noRedirect = false,
    this.layerLink,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Redirect on tap
        if (noRedirect) return;

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return PostDetailsScreen(post: post);
            },
          ),
        );
      },
      // Post
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
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
            PostMedia(
              media: post.media,
              postIndex: index,
              layerLink: layerLink,
            ),
            SizedBox(height: 12),

            // Post content
            PostContent(post: post),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
