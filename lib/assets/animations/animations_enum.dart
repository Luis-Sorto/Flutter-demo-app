import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum LottieAnimation {
  splashAnimation;

  String get name => toString().split(".")[1];
  String get path => "assets/animations/$name.json";

  Widget jsonAnimation(
    BuildContext context, {
    bool? repeat = false,
    AnimationController? animationController,
  }) {
    return Lottie.asset(
      path,
      repeat: repeat,
      controller: animationController,
    );
  }
}
