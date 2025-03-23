import 'package:feed_demo/providers/post/post_provider.dart';
import 'package:feed_demo/widgets/post/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => ref.read(postsNotifierProvider.notifier).fetchPosts(),
    );

    _controller.addListener(() {
      // Trigger fetch when close to the bottom of the list
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - (550 * 5)) {
        ref.read(postsNotifierProvider.notifier).fetchPosts();
      }

      final scrollPosition = _controller.position.pixels;

      // **Remove and cache posts when scrolled too far**
      ref.read(postsNotifierProvider.notifier).manageCache(scrollPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsNotifierProvider);

    // List view for posts
    return ListView.builder(
      controller: _controller,
      itemCount: posts.length,
      itemBuilder: (context, index) => Post(post: posts[index], index: index),
    );
  }
}
