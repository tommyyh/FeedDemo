import 'package:feed_demo/widgets/post/post_media/post_indicator.dart';
import 'package:flutter/material.dart';

class PostMedia extends StatefulWidget {
  final List<Map<String, dynamic>> media;

  const PostMedia({super.key, required this.media});

  @override
  State<PostMedia> createState() => _PostMediaState();
}

class _PostMediaState extends State<PostMedia> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  void onPageChanged(int index) {
    setState(() => currentPage = index);
  }

  @override
  Widget build(BuildContext context) {
    final media = widget.media;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 13),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 400, // Fixed height
              child: PageView.builder(
                controller: _pageController,
                physics: const ClampingScrollPhysics(),
                itemCount: media.length,
                onPageChanged: onPageChanged,
                itemBuilder:
                    (context, index) => Image.asset(
                      media[index]['url']! ?? 'assets/images/placeholder.jpeg',
                      fit: BoxFit.cover,
                    ),
              ),
            ),
          ),
        ),

        // Post media indicator (dots)
        PostIndicator(currentPage: currentPage, length: media.length),
      ],
    );
  }
}
