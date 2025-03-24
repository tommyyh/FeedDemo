import 'dart:convert';
import 'dart:math';

import 'package:feed_demo/models/post_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'post_provider.g.dart';

@riverpod
class PostsNotifier extends _$PostsNotifier {
  @override
  List<PostModel> build() {
    return [];
  }

  int _page = 0;
  final int _limit = 10;
  bool _isLoading = false;

  final Map<int, PostModel> _cache = {};

  // Fetch posts through api
  Future<void> fetchPosts() async {
    if (_isLoading) return;
    _isLoading = true;

    // Fetch post (Simulate)
    await Future.delayed(Duration(seconds: 1));

    // In production: Implement image caching!
    List<PostModel> newPosts = List.generate(
      _limit,
      (index) => PostModel(
        id: _page * _limit + index,
        title: 'Prodám lampičku č.${_page * _limit + index}',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.',
        price: (_page * _limit + index).toDouble() * 10,
        media: [
          {'photo': true, "url": "assets/images/placeholder.jpeg"},
          {'photo': true, "url": "assets/images/placeholder.jpeg"},
        ],
        status: 'prodává',
        product: 'lampička',
        category: 'Modní doplňky',
        likes: 10,
        userId: 0,
      ),
    );

    // Update state, pagination and loading
    state = [...state, ...newPosts];
    _page++;
    _isLoading = false;
  }

  void cacheOldPosts(double scrollPosition, int safeLower, int safeUpper) {
    state =
        state.map((post) {
          // Cache posts outside buffer zone (20 posts in BOTH directions)
          if (post.id < safeLower || post.id > safeUpper) {
            if (!_cache.containsKey(post.id)) {
              _cache[post.id] = post;
            }
            return PostModel.cachePost(post.id);
          }
          return post;
        }).toList();
  }

  void restoreCachedPosts(double scrollPosition, int safeLower, int safeUpper) {
    // Get cached posts within index bounds
    final restoreIds =
        _cache.keys.where((id) => id >= safeLower && id <= safeUpper).toList();

    if (restoreIds.isNotEmpty) {
      final restoredPosts = restoreIds.map((id) => _cache.remove(id)!).toList();

      state =
          state.map((post) {
            final restoredPost = restoredPosts.firstWhere(
              (p) => p.id == post.id,
              orElse: () => post,
            );
            return restoredPost;
          }).toList();
    }
  }

  void manageCache(double scrollPosition) {
    const int postHeight = 550;
    // Index of current post in view
    final int currentPostIndex = (scrollPosition ~/ postHeight);
    // Index of bounds posts that will be cached
    final int lowerBound = currentPostIndex - 10; // Old posts
    final int upperBound = currentPostIndex + 15; // New posts
    // Safety check
    final int safeLower = lowerBound.clamp(0, state.length);
    final int safeUpper = upperBound.clamp(0, state.length);

    cacheOldPosts(scrollPosition, safeLower, safeUpper);
    restoreCachedPosts(scrollPosition, safeLower, safeUpper);
  }
}
