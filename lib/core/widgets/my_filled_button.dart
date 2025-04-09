import 'package:flutter/material.dart';

class MyFilledTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const MyFilledTextButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: IntrinsicHeight(
        child: IntrinsicWidth(
          child: Container(
            constraints: BoxConstraints(minHeight: 0, minWidth: 0),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
