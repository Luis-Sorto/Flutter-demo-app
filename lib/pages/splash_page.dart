import 'dart:io' show Platform;
import 'package:demo_app/assets/animations/animations_enum.dart';
import 'package:demo_app/widgets/lottie_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _lottieController;
  late Animation<double> _sizeAnimation;
  late Animation<BorderRadius?> _borderRadiusAnimation;
  late Animation<Color?> _colorAnimation;

  final isMobile = Platform.isIOS || Platform.isAndroid;

  @override
  void initState() {
    super.initState();

    _lottieController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _lottieController.forward().whenComplete(
          () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Bare bones'),
                ),
              ),
            ),
          ),
        );

    if (isMobile) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      // Animation setups for Desktop
      _controller = AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      );

      _sizeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          reverseCurve: Curves.easeIn,
          curve: Curves.easeInOut,
        ),
      );

      _borderRadiusAnimation = BorderRadiusTween(
        begin: BorderRadius.circular(50.0),
        end: BorderRadius.circular(0.0),
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.linear,
        ),
      );

      _colorAnimation = ColorTween(
        begin: Colors.white,
        end: const Color(0xFFFFF45A),
      ).animate(
        CurvedAnimation(
          parent: _controller,
          reverseCurve: Curves.easeIn,
          curve: Curves.easeOut,
        ),
      );

      _controller.forward().whenComplete(() {
        // Wait for the Lottie animation to complete
        Future.delayed(const Duration(seconds: 2, milliseconds: 200),
            () => _controller.reverse());
      });
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    if (!isMobile) {
      _controller.dispose();
    }
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Work around to support Desktop splash
    // without disrupting the UI

    Widget buildBackgroundAnimation() {
      return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Center(
            child: Container(
              width: _sizeAnimation.value * screenSize.width,
              height: _sizeAnimation.value * screenSize.height,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: _borderRadiusAnimation.value,
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          if (!isMobile) buildBackgroundAnimation(),
          SizedBox(
            width: double.infinity,
            child: LottieAnimationWidget(
              animation: LottieAnimation.splashAnimation,
              animationController: _lottieController,
              repeat: true,
            ),
          ),
        ],
      ),
    );
  }
}
