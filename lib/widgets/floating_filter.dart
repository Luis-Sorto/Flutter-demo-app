import 'package:flutter/material.dart';

class FloatingFilter extends StatefulWidget {
  const FloatingFilter({super.key, required this.isVisible});

  final bool isVisible;
  static const heightOffset = 65.0;

  @override
  State<FloatingFilter> createState() => _FloatingFilterState();
}

class _FloatingFilterState extends State<FloatingFilter> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      top: widget.isVisible ? 0 : -FloatingFilter.heightOffset,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.only(left: 6),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)],
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        height: 60,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO add filter feature
            Expanded(
              child: Text('Filter Widget'),
            ),
          ],
        ),
      ),
    );
  }
}
