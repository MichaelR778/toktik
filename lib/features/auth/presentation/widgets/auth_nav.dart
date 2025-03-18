import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthNav extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback togglePage;

  const AuthNav({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.togglePage,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: firstText),
          TextSpan(
            text: secondText,
            style: TextStyle(fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()..onTap = () => togglePage(),
          ),
        ],
      ),
    );
  }
}
