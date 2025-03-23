import 'package:flutter/material.dart';

// Dots indicating image position
class PostIndicator extends StatelessWidget {
  final int length;
  final int currentPage;

  const PostIndicator({
    super.key,
    required this.currentPage,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 12,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          length,
          (index) => _Dot(isActive: index == currentPage),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool isActive;

  const _Dot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 190),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: isActive ? 13 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
