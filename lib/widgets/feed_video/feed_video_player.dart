import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeedVideoPlayer extends StatelessWidget {
  final VideoPlayerController? currentController;

  const FeedVideoPlayer({super.key, required this.currentController});

  @override
  Widget build(BuildContext context) {
    final bool isInitialized = currentController?.value.isInitialized ?? false;
    final bool isPlaying = currentController?.value.isPlaying ?? false;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          SizedBox(
            height: 400,
            child:
                isInitialized
                    ? VideoPlayer(currentController!)
                    : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.pink,
                        strokeWidth: 2.5,
                      ),
                    ),
          ),

          // Pause / Play icon
          _VideoIndicator(isPlaying: isPlaying),
        ],
      ),
    );
  }
}

class _VideoIndicator extends StatelessWidget {
  final bool isPlaying;

  const _VideoIndicator({required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      top: 10,
      child: Icon(
        isPlaying ? Icons.pause : Icons.play_arrow,
        color: Colors.pink,
      ),
    );
  }
}
