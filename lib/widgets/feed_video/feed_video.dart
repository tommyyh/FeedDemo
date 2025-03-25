import 'dart:math';

import 'package:feed_demo/providers/post/post_provider.dart';
import 'package:feed_demo/widgets/feed_video/feed_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class FeedVideo extends ConsumerStatefulWidget {
  final LayerLink layerLink;

  const FeedVideo({super.key, required this.layerLink});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends ConsumerState<FeedVideo> {
  VideoPlayerController? currentController;
  VideoPlayerController? nextController;
  bool isPrefetching = false;
  bool _firstLoad = true; // Fetch instantly if its the first video
  final random = Random();

  @override
  void initState() {
    super.initState();

    _initializeCurrentVideo();
  }

  // Initialize current playing video
  void _initializeCurrentVideo() {
    // Load video & auto play it
    currentController = VideoPlayerController.asset(
        'assets/videos/cool_video.mp4',
      )
      ..initialize().then((_) {
        if (!mounted) return;

        setState(() {
          currentController!
            ..setLooping(true)
            ..play(); // Loop and autoplay by default
        });

        // If its a the first video -> Fetch instantly otherwise schedule it
        if (_firstLoad) {
          prefetchNextVideo();

          _firstLoad = false;
        } else {
          schedulePrefetch();
        }
      });
  }

  // Switch to next video when activePostIndex changes
  void switchToNextVideo() {
    final bool nextIsInitialized = nextController?.value.isInitialized ?? false;
    if (!nextIsInitialized) return;

    // Save old controller reference & dispose it after UI is rendered
    final oldController = currentController;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      oldController?.dispose();
    });

    // Next controller will now become the current playing controller & autoplay
    setState(() {
      currentController =
          nextController!
            ..setLooping(true)
            ..play();
      nextController = null; // Next controller will be null
    });

    // Next controller is null so -> Prefetch again
    schedulePrefetch();
  }

  // Schedule video prefetch with a delay so it doesn't overload
  void schedulePrefetch() {
    Future.delayed(const Duration(milliseconds: 420), prefetchNextVideo);
  }

  // Prefetch video
  void prefetchNextVideo() {
    if (isPrefetching || nextController != null) return;
    isPrefetching = true;

    // Dispose next controller and prefetch a new video right after
    nextController?.dispose();

    // Select random video for testing
    int randomNumber = random.nextInt(2);
    List videoFiles = [
      'assets/videos/cool_video.mp4',
      'assets/videos/cool_video2.mp4',
    ];

    nextController = VideoPlayerController.asset(videoFiles[randomNumber])
      ..initialize().then((_) {
        if (!mounted) return;

        isPrefetching = false;
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    // Listen to active post change to schedule next video
    ref.listen(activePostProvider, (prev, next) {
      if (prev != next) {
        switchToNextVideo();
      }
    });

    return Positioned(
      top: -500,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: CompositedTransformFollower(
          link: widget.layerLink,
          child: FeedVideoPlayer(currentController: currentController),
        ),
      ),
    );
  }

  // Dispose for performance
  @override
  void dispose() {
    currentController?.dispose();
    nextController?.dispose();

    super.dispose();
  }
}
