import 'package:flutter/material.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      child: IconButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.grey),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        onPressed: () {
          FocusScope.of(context).unfocus();
          onPressed();
        },
      ),
    );
  }
}
