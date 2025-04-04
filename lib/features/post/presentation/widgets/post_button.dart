import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  final int count;

  const PostButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.color,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Icon(icon, color: color, size: 30),
          ),
          Text('$count', style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
