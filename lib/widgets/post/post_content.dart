import 'package:feed_demo/models/post_model.dart';
import 'package:flutter/material.dart';

class PostContent extends StatelessWidget {
  final PostModel post;

  const PostContent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(post.description),

        // Likes
        const SizedBox(height: 27),
        Row(
          children: [
            const Icon(Icons.favorite, color: Colors.pink),
            Padding(
              padding: const EdgeInsets.only(left: 5.5),
              child: Text('${post.likes.toString()} people liked this post'),
            ),
          ],
        ),
      ],
    );
  }
}
