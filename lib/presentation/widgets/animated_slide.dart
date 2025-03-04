import 'package:flutter/material.dart';

class AnimatedSlider extends AnimatedWidget {
  const AnimatedSlider({
    super.key,
    required this.child,
    required this.animation,
  }) : super(listenable: animation);

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final slideWidth = MediaQuery.sizeOf(context).width * 0.3;

    return Transform.translate(
      offset: Offset(slideWidth * (1 - animation.value), 0),
      child: child,
    );
  }
}