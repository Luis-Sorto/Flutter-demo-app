import 'package:demo_app/assets/animations/animations_enum.dart';
import 'package:demo_app/widgets/lottie_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Lottie tests', () {
    testWidgets('Displays animation', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LottieAnimationWidget(
              animation: LottieAnimation.splashAnimation,
              repeat: true,
            ),
          ),
        ),
      );

      expect(find.byType(LottieAnimationWidget), findsOneWidget);
    });
  });
}
