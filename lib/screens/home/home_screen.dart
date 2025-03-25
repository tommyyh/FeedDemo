import 'package:feed_demo/providers/post/post_provider.dart';
import 'package:feed_demo/widgets/post/post.dart';
import 'package:feed_demo/widgets/feed_video/feed_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // Fetch posts on initialization
    Future.microtask(() {
      ref.read(postsNotifierProvider.notifier).fetchPosts();
    });

    _controller.addListener(() {
      // Prefetch new page of posts before reaching the end
      final int postHeight = 550;

      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - (postHeight * 5)) {
        ref.read(postsNotifierProvider.notifier).fetchPosts();
      }

      final scrollPosition = _controller.position.pixels;

      // Remove and cache posts when scrolled too far
      ref.read(postsNotifierProvider.notifier).manageCache(scrollPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final posts = ref.watch(postsNotifierProvider);
    final LayerLink layerLink = LayerLink();

    // List view for posts
    // !ADD VIDEO CACHING FOR BETTER PERFORMANCE!
    return Stack(
      children: [
        ListView.builder(
          controller: _controller,
          itemCount: posts.length,
          itemBuilder:
              (context, index) => Post(
                post: posts[index],
                index: index,
                layerLink:
                    ref.watch(activePostProvider) == index ? layerLink : null,
              ),
        ),

        // Video player
        FeedVideo(layerLink: layerLink),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  // Dispose for performance
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
