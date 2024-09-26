import 'package:demo_app/assets/animations/animations_enum.dart';
import 'package:flutter/material.dart';

class LottieAnimationWidget extends StatelessWidget {
  const LottieAnimationWidget({
    required this.animation,
    this.repeat,
    this.animationController,
    super.key,
  });

  final LottieAnimation animation;
  final bool? repeat;
  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return animation.jsonAnimation(
      context,
      repeat: repeat,
      animationController: animationController,
    );
  }
}
