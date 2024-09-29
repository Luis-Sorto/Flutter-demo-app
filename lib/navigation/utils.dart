import 'package:flutter/material.dart';

class NoAnimationRoute extends PageRouteBuilder {
  final WidgetBuilder builder;

  /// Utility to remove page transition animation
  NoAnimationRoute({required this.builder, super.settings})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              child,
        );
}
