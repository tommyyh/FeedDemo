import 'package:flutter/material.dart';

class PostProduct extends StatelessWidget {
  final List product;
  final String category;

  const PostProduct({super.key, required this.product, required this.category});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Product & price
        Text.rich(
          TextSpan(
            children: [
              // TextSpan(text: 'kapsička za '),
              TextSpan(text: '${product[0]} za '),
              // Price
              TextSpan(
                text: '${product[1]}Kč',
                style: TextStyle(
                  fontWeight: FontWeight.w700, // Bold only for price
                ),
              ),
            ],
          ),
        ),

        // Category
        Text(' / $category'),
      ],
    );
  }
}
