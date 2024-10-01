import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchInput extends HookWidget {
  const SearchInput({
    super.key,
    required this.onChanged,
    this.placeholder = 'Search',
  });

  final Function(String value) onChanged;
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.all(6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: placeholder,
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(),
            suffixIcon: controller.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      controller.clear();
                      onChanged('');
                    },
                  )),
        style: const TextStyle(fontSize: 16, height: 0.8),
        onChanged: onChanged,
      ),
    );
  }
}
