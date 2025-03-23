import 'package:feed_demo/models/post_model.dart';
import 'package:feed_demo/widgets/post/post_header/post_product.dart';
import 'package:feed_demo/widgets/post/post_header/post_user.dart';
import 'package:feed_demo/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final PostModel post;

  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // User avatar picture
        UserAvatar(height: 41, image: 'assets/images/blank_avatar.jpg'),

        // Post header details
        Padding(
          padding: const EdgeInsets.only(left: 11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Author's username + status
              PostUser(username: 'pepadana', status: post.status),

              // Item & price + category
              PostProduct(
                product: [post.product, post.price],
                category: post.category,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
