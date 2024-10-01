import 'package:demo_app/widgets/state_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterOptionsProvider = Provider(
  (ref) => [
    const Icon(Icons.format_list_bulleted_rounded),
    const Icon(Icons.touch_app_rounded),
  ],
);

final filterSelectionProvider = StateProvider(
  (ref) => [
    true,
    false,
  ],
);

final selectedOptionProvider = Provider(
  (ref) {
    final optionId = ref.watch(filterSelectionProvider).indexOf(true);

    if (optionId == 0) return FilterType.dropdown;
    return FilterType.chips;
  },
);
