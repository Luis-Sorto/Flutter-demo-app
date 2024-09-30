import 'package:demo_app/providers/person_repository.dart';
import 'package:demo_app/widgets/state_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloatingFilter extends ConsumerStatefulWidget {
  const FloatingFilter({super.key, required this.isVisible});

  final bool isVisible;
  static const heightOffset = 125.0;

  @override
  ConsumerState createState() => _FloatingFilterState();
}

class _FloatingFilterState extends ConsumerState<FloatingFilter> {
  @override
  Widget build(BuildContext context) {
    final peopleAsync = ref.watch(peopleProvider);

    final List<String> uniqueStates = peopleAsync.when(
      data: (people) =>
          people.map((p) => p.state).whereType<String>().toSet().toList(),
      loading: () => [],
      error: (_, __) => [],
    )..sort();

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      top: widget.isVisible ? 0 : -FloatingFilter.heightOffset,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.only(left: 6),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        height: 120,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: StateFilter(
          states: uniqueStates,
        ),
      ),
    );
  }
}
