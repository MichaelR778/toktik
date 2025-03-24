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
      child: Container(
        padding: const EdgeInsets.symmetric(),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
}
