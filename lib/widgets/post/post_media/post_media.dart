import 'package:feed_demo/providers/post/post_provider.dart';
import 'package:feed_demo/widgets/post/post_media/post_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostMedia extends ConsumerStatefulWidget {
  final int postIndex;
  final LayerLink? layerLink;
  final List<Map<String, dynamic>> media;

  const PostMedia({
    super.key,
    required this.media,
    required this.postIndex,
    this.layerLink,
  });

  @override
  ConsumerState<PostMedia> createState() => _PostMediaState();
}

class _PostMediaState extends ConsumerState<PostMedia> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  void onPageChanged(int index) {
    setState(() => currentPage = index);
  }

  // Set active post based on visibleFraction
  void _handleVisibilityChange(VisibilityInfo info) {
    bool hasVideo = widget.media.any((item) => item['photo'] == false);

    if (info.visibleFraction > 0.4 && hasVideo) {
      ref.read(activePostProvider.notifier).setActivePost(widget.postIndex);
    }
  }

  // Build the PageView to use conditionally
  Widget _buildMediaContent() {
    Widget pageView = PageView.builder(
      controller: _pageController,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.media.length,
      onPageChanged: onPageChanged,
      itemBuilder:
          (context, index) => Image.asset(
            widget.media[index]['photo']
                ? widget.media[index]['url']
                : widget.media[index]['thumbnail'],
            fit: BoxFit.cover,
          ),
    );

    // If layerLink -> Media widget becomes a target for video player to pop into
    if (widget.layerLink != null) {
      pageView = CompositedTransformTarget(
        link: widget.layerLink!,
        child: pageView,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(height: 400, child: pageView),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('post_media_${widget.postIndex}'),
      onVisibilityChanged: _handleVisibilityChange,
      child: Stack(
        children: [
          // Build the rest
          _buildMediaContent(),

          // Indicates how many media files there are
          PostIndicator(currentPage: currentPage, length: widget.media.length),
        ],
      ),
    );
  }
}
